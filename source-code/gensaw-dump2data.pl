#! /usr/bin/perl

# 28 nov 2023 mk@mat.ethz.ch

sub USAGE { print<<EOF;
\n
perl $0 config.dump 
OR
perl $0 -angles config.dump 

This code converts a dump-file created by gensaw to a lammps data file. 
If -angles is added, the data-file contains angles.
EOF
exit;
};

sub strip { chomp $_[0]; $_[0]=~s/^\s+//g; $_[0]=~s/\s+$//; $_[0]=~s/\s+/ /g; $_[0]; }; 
sub round { if ($_[0] eq 0) { } else { $_[0]=($_[0]/abs($_[0]))*int(abs($_[0])+0.5); }; $_[0]; };

$atomstyle = "bond";
foreach $arg (@ARGV) { 
    if ($arg eq "-angles") { 
        $add_angles = 1; 
        $atomstype = "angle"
    } else { 
        $dumpfile = $arg; 
        if (-s "$dumpfile") { } else { USAGE; };
    };
}; 
    
open(D,"<$dumpfile"); 
while (!eof(D)) {
    $line=<D>; $line=strip($line);
    if      ($line=~/ITEM: NUMBER OF ATOMS/) {
        $line=<D>; $line=strip($line);
        $atoms=$line+0; 
        print "# $atoms atoms | ";
    } elsif ($line=~/ITEM: BOX BOUNDS/) { 
        @split=split(/ /,$line); 
        if ($split[3] eq "pp") { $px=1; } else { $px=0; }; 
        if ($split[4] eq "pp") { $py=1; } else { $py=0; };
        if ($split[5] eq "pp") { $pz=1; } else { $pz=0; };
        $line=<D>; $line=strip($line); ($xlo,$xhi)=split(/ /,$line); $boxx=$xhi-$xlo;
        $line=<D>; $line=strip($line); ($ylo,$yhi)=split(/ /,$line); $boxy=$yhi-$ylo;
        $line=<D>; $line=strip($line); ($zlo,$zhi)=split(/ /,$line); $boxz=$zhi-$zlo;
        print "box dimensions $boxx $boxy $boxz | ";
        print "periodic [$px $py $pz] | ";
    } elsif ($line=~/ITEM: ATOMS/) {
        foreach $id (1 .. $atoms) {
            $line=<D>; $line=strip($line); ($id,$rest)=split(/ /,$line); ($d,$mol,$type[$id],$xu,$yu,$zu)=split(/ /,$line);    
            $ix[$id] = $px*round($xu/$boxx);
            $iy[$id] = $py*round($yu/$boxy);
            $iz[$id] = $pz*round($zu/$boxz);
            $x[$id]  = $xu-$boxx*$ix[$id];
            $y[$id]  = $yu-$boxy*$iy[$id];
            $z[$id]  = $zu-$boxz*$iz[$id];
            if (!$mol_beg[$mol]) { $mol_beg[$mol]=$id; };
            $mol_end[$mol] = $id;   
            $chains  = $mol;
            if (!$min_type) { $min_type = $type[$id]; }; 
            if (!$max_type) { $max_type = $type[$id]; }; 
            if ($type[$id]<$min_type) { $min_type=$type[$id]; };
            if ($type[$id]>$max_type) { $max_type=$type[$id]; }; 
        };   
    }; 
};
close(D);
print "$chains chains | ";

$atoms = 0; 
$types = $max_type-$min_type+1; 
print "$types atom types | ";
foreach $c (1 .. $chains) {
    $N[$c]   = $mol_end[$c]-$mol_beg[$c]+1; 
    $atoms  += $N[$c]; 
    $bonds  += $N[$c]-1;
    $angles += $N[$c]-2; 
};
print "$bonds bonds | ";
if ($add_angles) { print "$angles angles"; } else { print "ignoring angles"; };
print "\n";

$datafile = $dumpfile; $datafile=~s/\.dump$/.data/; 

open(D,">$datafile"); 
print D<<EOF;
multiple self-avoiding chains created by gensaw

$atoms atoms
$bonds bonds
EOF
if ($add_angles) { print D "$angles angles\n"; };
print D<<EOF;
$types atom types
1 bond types
EOF
if ($add_angles) { print D "1 angle types\n"; }; 
print D<<EOF;

$xlo $xhi xlo xhi
$ylo $yhi ylo yhi
$zlo $zhi zlo zhi

Atoms 

EOF
$ID=0;
foreach $c (1 .. $chains) {
foreach $j (1 .. $N[$c]) { 
   $ID+=1; 
   print D "$ID $c $type[$ID] $x[$ID] $y[$ID] $z[$ID] $ix[$ID] $iy[$ID] $iz[$ID]\n"; 
};
};
print D "\nBonds\n\n"; 
$IDA=0; $BID=0;
foreach $c (1 .. $chains) {
foreach $j (2 .. $N[$c]) {
   $IDA+=1; $BID+=1; $IDB=$IDA+1; 
   print D "$BID 1 $IDA $IDB\n"; 
};
$IDA+=1; 
};
if ($add_angles) { 
print D "\nAngles\n\n";
$IDA=0; $AID=0;
foreach $c (1 .. $chains) {
foreach $j (3 .. $N[$c]) {
   $IDA+=1; $AID+=1; $IDB=$IDA+1; $IDC=$IDB+1; 
   print D "$AID 1 $IDA $IDB $IDC\n";
};
};
}; 
close(D);

print<<EOF;
The lammps-data-file is: $datafile

To use this $datafile in lammps, you may begin your lammps script with:

units lj
atom_style $atomstyle
read_data $datafile

group tethers type 1
group interior type 2
group terminals type 3
mass * 1

# you have $types atom types, need to add pair and bond styles etc 
# and a soft repulsion to equilibrate the system
EOF

open(C,">_created"); print C "$datafile\n"; close(C);
