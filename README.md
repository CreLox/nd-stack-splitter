# nd-stack-splitter
This Shell script splits a MetaMorph® .nd stack into subgroups of positions and puts together related images into subfolders. Download ``nd-stack-splitter`` under this repository to your local /usr/local/bin/ and make it writable and executable only for the file owner:   
 ``chmod 544 /usr/local/bin/nd-stack-splitter``   
  Before your run, make sure that the .nd files are in the same folder as all images. The input syntax is:   
   ``nd-stack-splitter (.nd file name) (number of positions in a subgroup, optional, 3 by default)``
