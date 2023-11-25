# files contained in the gensaw.tar-file: 

gensaw-install
gensaw-generic.f90
gensaw-generic
inc.overlap
inc.phantom
inc.tictoc
gensaw-erase-blanks
gensaw-density3D-to-other
gensaw-visualization.jar
gensaw-README.txt

# ---------- INSTALLATION AND TESTING OF gensaw -----------
# install gensaw and perform test runs via
perl ./gensaw-install

# once gensaw had been successfully installed, it can be used from any location except from within the installation directory.

# --------------- ADDITIONAL INFORMATION -------------------
# gensaw help is available via
gensaw -help | more
or
perl ./gensaw -help | more

# sample gensaw call (creates config.dump, in particular)
gensaw -C=100 -N=100 -bend=60 -tight
or
perl ./gensaw -C=100 -N=100 -bend=60 -tight

# clean up
gensaw -clean
or
perl ./gensaw -clean

# ---------- INSTALLATION OF gensaw-visualization ----------
# This graphical user interface requires an active internet connection and a java runtime environment 1.8 or higher.
# It must not be used together with gensaw, it is an optional interface that helps to visualize conformations and 
# to try out the effect of some of the parameters. 
# Download the gensaw-visualization.jar file and double click on the jar-file. 
# Rotate conformations and zoom into them using the mouse (click and move, or scroll)
# in the visualization window.

# If jar-files are not associated with javaw.exe you may start java from the
# command prompt via
# "c:\Program Files\Java\jre1.8.XXX\bin\javaw.exe" -jar "XXX:/XXX/gensaw-visualization.jar"
# where you have to replace the XXX depending on your local java installation and
# the location of the downloaded jar-file. 

# --------------- HOW TO CITE ------------------------------

Oliver Weismantel, Aikaterini A. Galata, Morteza Sadeghi, Achim Kroger, Martin Kroger, 
Efficient generation of self-avoiding, semiflexible rotational isomeric chain ensembles in bulk, in confined geometries, and on surfaces,
Comput. Phys. Commun. 270 (2021) 108176

DOI: 10.1016/j.cpc.2021.108176
