# gensaw (code)
## Efficient generation of self-avoiding, semiflexible rotational isomeric chain ensembles in bulk, in confined geometries, and on surfaces

The code available from the current repository https://github.com/mkmat/gensaw had been published in

O. Weismantel, A.A. Galata, M. Sadeghi, A. Kröger, M. Kröger, 
Efficient generation of self-avoiding, semiflexible rotational isomeric chain ensembles in bulk, in confined geometries, and on surfaces, 
Computer Physics Communications **270** (2022) 108176

DOI: https://doi.org/10.1016/j.cpc.2021.108176

Link to the article: https://www.sciencedirect.com/science/article/pii/S0010465521002885

Link to Mendeley: https://data.mendeley.com/datasets/8xfgf88f3w/1

## Installation instructions

Either clone this repository, or download gensaw.tar.gz and place it into a fresh folder. Then execute

      perl ./gensaw-install
      
Once gensaw had been successfully installed, it can be used from any location except from within the installation directory.

## Command line arguments (see [below](#options) for details)

      gensaw -help | more

or

      perl ./gensaw -help | more

## Examples (see the mentioned publication for more examples)

      gensaw -C=200 -N=100 -bend=60 -tight

This command creates a lammps-dump file with 200 linear semiflexible multibead chains (constant bending angle 60, default bond length 1, default bead diameter 1), each made of 100 beads, placed in a tight box.

      gensaw -C=100000 -N=100 -b=1 -d=0 -confinementNONE -large -output=ee -bendWLC=5

This command creates a file containing end-to-end distances of 100000 unconfined wormlike chains (100 beads each, bond length 1, chain diameter 0) with bending stiffness 5.

      perl ./gensaw -C=10 -N=100 -b=1 -bend=68 -torsTGG=0.3 -anchorICYL=5.0,10.0 -output=xyz

This command creates a xyz-formatted configuration with 10 chains (100 beads each), anchored on the inner wall of a cylinder of radius 5 and height 10, bond length 1, bead diameter 1, fixed bending angle 68 DEG, trans-probability 0.3, equal gauche-probability, 
      

## Graphical user interface

In addition to the command line utility, we provide a graphical user interface

      gensaw-visualization.jar

See gensaw-README.txt and the article for details.

## gensaw options<a name=options>

      gensaw    -C=<number of chains>
                -N=<bonds per chain> 
                -b=<bond length>
 	            -box=<linear box size>
	            -output=<dump or data or mol2 or xyz or Z1 or gro or pdb or ee or fn or d[3D|xy|xz|yz|rx|ry|rz]>  

	            -anchor0 (the default, all chains anchored at the origin)
	            -anchorPLANE=<area-per-chain> OR 
	            -anchorOCYL=<radius,height>
	            -anchorICYL=<radius,height>
  	            -anchorOSPH=<radius>
                -anchorISPH=<radius>
 	            -anchorOCONE=<r_small,r_large,height>
                -anchorICONE=<r_small,r_large,height>
	            -anchorRANDOM=<monomer number density>
	            -anchor=<filename>

	            -confinementNONE (the default, no confinement)
	            -confinementPLANE=<z-value>
	            -confinementAUTO
	            -confinementOCYL=<radius,height>
	            -confinementICYL=<radius,height>
	            -confinementOSPH=<radius>
	            -confinementISPH=<radius>
	            -confinementOCONE=<r_small,r_large,height>
	            -confinementICONE=<r_small,r_large,height>
	            -confinement=<filename>

	            -bendRANDOM
	            -bend=<bending angle in DEG>
	            -bendWLC=<bending-stiffness-kb>
	            -bendFUNC=<function-in-terms-of-theta>
	            -bendTABLE=<filename>

	            -torsRANDOM
	            -torsTGG=<trans probability>
	            -torsFUNC=<function-in-terms-of-phi>
	            -torsTABLE=<filename>

                [-compile] (do not run)
	            [-clean]

 	            [-d=<monomer diameter>]
	            [-xlo=<lower box bound on x-axis>]
                [-xhi=<upper box bound on x-axis>]
                [-ylo=<lower box bound on y-axis>]
                [-yhi=<upper box bound on y-axis>]
	            [-zlo=<lower box bound on z-axis>]
                [-zhi=<upper box bound on z-axis>]
                [-tight] (all box sizes automatically determined)
                [-large] (all box sizes automatically determined)
                [-px (creates periodic box in x-direction)] 
                [-py (creates periodic box in y-direction)]
                [-pz (creates periodic box in z-direction)]
                [-p (creates periodic box in all directions)]
                [-12] (allows for overlap between 12-neighbors)
                [-123] (further allows for overlap between 13-neighbors)
                [-1234] (further allows for overlap between 14-neighbors)
                [-X=<X> (manually fixes the branching functionality X)]
                [-s=<s> (manually fixes the spacer length s between branchings)]
                [-seed=<seed integer>]
                [-citeas] [-version] [-v] (how to cite gensaw)


note: all lengths have to be specified using the same user-chosen units. The resulting configurations are using the same unit. 

### Monomer diameter

        -d=<monomer diameter>
   Diameter of the assumed spherical monomer. The default is d=b.
   To create a single chain, or an ensemble of chains without excluded volume choose -d=0

### Box size

        -box=<value> specifies box size in all dimensions (xhi=box/2, xlo=-box/2 etc). 
        -xlo=<value> specifies the lower box bound on the x-axis. This value is ignored if -tight is chosen. 
        -xhi=<value> specifies the upper box bound on the x-axis. This value is ignored if -tight is chosen.
        -ylo=<value> for the y-axis. If -ylo remains unspecified, ylo=xlo is used. Same for yhi, zlo, zhi.
        -tight       box sizes are chosen automatically depending on the anchoring and confinement options.
        -large       box sizes are chosen automatically depending on the anchoring and confinement options.

        -px	       makes the box periodic in x-direction 
        -py          makes the box periodic in y-direction
        -pz          makes the box periodic in z-direction
        -p           makes the box periodic in all directions
 
   Note: if the box is non-periodic, chains are enforced to stay within box bounds. 

### Anchoring options:

        -anchor0
   This is the default in the absence of any -anchor* command. All chains emanate from the origin, first bond aligned in z-direction
   and 2nd bond residing in the x-z-plane.

        -anchorPLANE=<area-per-chain>
   All chains start in the x-y-plane at z=0, at random positions within a square area determined by the provided area per chain. 
   First bond aligned in z-direction, 2nd bond randomly oriented. 

        -anchorOCYL<cylinder-radius,cylinder-height>
   All chains start somewhere randomly on the outer surface of an open cylinder of cylinder-radius and cylinder-height. Cylinder oriented in z-direction
   and centered at the origin. First segment oriented in the direction of the surface normal. 
    
        -anchorICYL=<cylinder-radius,cylinder-height>
   All chains start somewhere randomly on the inner surface of an open cylinder of cylinder-radius and cylinder-height. Cylinder oriented in z-direction.
   First segment oriented in the direction of the surface normal.

        -anchorOSPH=<sphere-radius>
   All chains start somewhere randomly on the outer surface of a sphere of sphere-radius. Sphere centered at the origin. 
   First segment oriented in the direction of the surface normal.

        -anchorISPH=<sphere-radius>
   All chains start somewhere randomly on the inner surface of a sphere of sphere-radius. Sphere centered at the origin.
   First segment oriented in the direction of the surface normal.

        -anchorOCONE=<small-radius,large-radius,cone-height>
   All chains start at the outer surface of a (partial) open cone, parameterized by small and large cone radii, and the 
   height of the (partial) cone. For a full cone, choose small-radius=0. Cone tip located at the origin. 
   First segment oriented in the direction of the surface normal.

        -anchorICONE=<small-radius,large-radius,cone-height>
   All chains start at the inner surface of a (partial) open cone, parameterized by small and large cone radii, and the
   height of the (partial) cone. For a full cone, choose small-radius=0. Cone tip located at the origin.
   First segment oriented in the direction of the surface normal.

        -anchorRANDOM=<monomer-number-density>
   All chains start somewhere inside a box whose volume is determined by the monomer number density.

        -anchor=<filename>
   Anchoring conditions for all chains specified in file filename. For each chain, this file contains 
   one line. Each line has six columns, x y z ux uy uz speciying the anchoring point and the orientation 
   of the first bond.

### Confinement options:

        -confinementNONE
   This is the default in the absence of any -confinemend* option.

        -confinementAUTO
   Choose a confinement in accord with the chosen anchoring condition.

        -confinementPLANE=<z-value>
   Enforce chains to stay at z>z-value

        -confinementOCYL=<cylinder-radius, cylinder-height>
   Enforce chains to stay outside a cylinder of cylinder-radius and cylinder-height. Cylinder oriented 
   in z-direction and centered at the origin. 

        -confinementICYL=<cylinder-radius, cylinder-height>
   Enforce chains to stay inside a cylinder of cylinder-radius and cylinder-height. Cylinder oriented
   in z-direction and centered at the origin.

        -confinementOSPH=<sphere-radius>
   Enforce chains to stay outside a sphere of sphere-radius. Sphere centered at the origin.

        -confinementISPH=<sphere-radius>
   Enforce chains to stay inside a sphere of sphere-radius. Sphere centered at the origin.

        -confinementOCONE=<small-radius, large-radius, cone-height>
   Enforce chains to stay outside the cone with small-radius and large-radius and cone-height.

        -confinementICONE=<small-radius, large-radius, cone-height>
   Enforce chains to stay inside the open cone with small-radius and large-radius and cone-height.

        -confinement=<filename>
   Enforce chains to stay outside the region defined in filename. For examples, see manuscript.

### Bending energy:

        -bendRANDOM
   This is the default. Zero bending energy. This is equivalent with -bendFUNC=0

        -bend=<angle in DEG>
   Fixed bending angle in [0,180) (as for a freely rotating chain). 

        -bendWLC=<kbend>
   Bending energy of a wormlike chain, parameterized by dimensionless stiffness kbend

        -bendFUNC="function in terms of theta"
   Bending energy divided by kBT specified by a function in terms of theta in [0,pi]. 
   Basic fortran syntax must be used. 

        -bendTABLE=<filename>
   Bending energy divided by kBT specified by a table with two columns. Each row contains
   two values: bending angle in radiants, and dimensionless bending energy. If the table contains less
   than 10 rows, the angles are interpreted at fixed bending angles with their corresponding energies. 
  
### Torsion/dihedral energy:

        -torsRANDOM
   This is the default. Zero torsion energy. This is equivalent with -torsFUNC=0

        -torsTGG=<p>
   trans-gauche chains, equal gauche probability, trans probability is given by p, gauche+/- probability is (1-p)/2
  
        -torsFUNC="function in terms of phi"
   Dihedral energy divided by kBT is given by the analytic expression in terms of dihedral angle phi in [-pi,pi].
  
        -torsTABLE=<filename>
   Dihedral energy divided by kBT as function of phi provided by the table stored in filename. 
   Each row contains two values: dihedral angle in radiants, and dimensionless torsion energy. If the table contains less
   than 10 rows, the angles are interpreted at fixed torsion angles with their corresponding energies.
  
### Examples 

      perl ./gensaw -C=10 -N=100 -b=1 -tight -output=d3D
      perl ./gensaw -C=10 -N=100 -b=1 -tight -output=dump
      perl ./gensaw -C=10 -N=100 -b=1 -tight -output=data
      perl ./gensaw -C=10 -N=100 -b=1 -p -torsTGG=0.4 -output=dump
      perl ./gensaw -C=10 -N=100 -b=1 -bend=68 -torsTGG=0.2 -output=dump
      perl ./gensaw -C=10 -N=100 -b=1 -bend=10 -output=dump
      perl ./gensaw -C=200 -N=100 -b=1 -bend=10 -output=dump -confinementICONE=5,10,100 -tight
      perl ./gensaw -C=100 -N=100 -b=1 -bend=10 -output=dump -confinementISPH=50 -tight 
      perl ./gensaw -C=200 -N=100 -b=1 -bend=10 -output=dump -anchorPLANE=10 -confinementAUTO -tight
      
      perl ./gensaw -C=10 -N=100 -b=1 -bend=68 -torsTGG=0.2 -output=Z1
      perl ./gensaw -C=10 -N=100 -b=1 -bend=68 -torsTGG=0.3 -anchorICYL=5.0,10.0 -output=xyz
      perl ./gensaw -C=10 -N=100 -b=1 -d=0.5 -torsTGG=0.4 -anchorPLANE=5.0 -confinementAUTO
      perl ./gensaw -C=10 -N=100 -b=1 -bend=120 -energymode=tgg,0.2 -anchorICONE=5,10,20 -confinementAUTO -output=dump
      perl ./gensaw -C=10 -N=100 -b=1 -d=1 -px -py -bendWLC=4 -anchorCYLO=5,20 -output=dump
      
      perl ./gensaw -N=156 -C=1000 -tight -b=0.154 -d=0.3 -123 -bendFUNC="128.89*(theta-1.187)**2" -torsFUNC="1.119*(2.217-2.905*cos(phi)-3.135*cos(phi)**2+0.731*cos(phi)**3+6.271*cos(phi)**4+7.527*cos(phi)**5)"

### Problems? 

If you experience any problems please contact the author. 
