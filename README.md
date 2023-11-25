# gensaw
## Efficient generation of self-avoiding, semiflexible rotational isomeric chain ensembles in bulk, in confined geometries, and on surfaces

The code available from this repository had been published in

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

## Command line arguments 

      gensaw -help | more

or

      perl ./gensaw -help | more

## Example (see the mentioned publication for more examples)

      gensaw -C=200 -N=100 -bend=60 -tight

This command creates a lammps-dump file with 200 linear semiflexible chains (constant bending angle 60 DEG), each made of 100 beads, placed in a tight box.

## Graphical user interface

In addition to the command line utility, we provide a graphical user interface

      gensaw-visualization.jar

See gensaw-README.txt and the article for details.


