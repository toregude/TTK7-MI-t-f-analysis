### Get the data

To get the data go to [http://bnci-horizon-2020.eu/database/data-sets]() and download all the files on the 2. entry. This means all the SxT files and all the SxE files from x = 01 to 13.

Then put them in a folder structure like the following in a matlab repo:

fix_data.m
data/
-S01T
-S01E
-...
-S13T
-S13E

Also remember to move the fix_data.m file into the repo on the same level as the data folder.

Then run the fix_data file and you will be left with a workable .mat file that can then be moved into this repo.

The file will be to big to be hosted on git.

When the file is in this repo change the name in the analisys.ipynb to the name of the file you made and run the ipynb file
