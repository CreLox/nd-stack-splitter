# nd-stack-splitter
This macOS Shell script splits a MetaMorph® .nd stack into subgroups of positions and puts together related images into subfolders. Download ``nd-stack-splitter`` under this repository to your local **/usr/local/bin/** and make it writable and executable only for the file owner:   
 ``chmod 544 /usr/local/bin/nd-stack-splitter``   
 
  Before your run, make sure that the .nd file is in the same folder as all other images. The input syntax is:   
  ``nd-stack-splitter (.nd file path) (number of positions in a subgroup, optional - 3 by default)``   
  
**Tip:** after opening a such set of images in ImageJ, you can save them into a single .tif stack, which saves a lot of trouble when you open them next time. To speed up SMB file access, check out [this blog](https://dpron.com/os-x-10-11-5-slow-smb/).
