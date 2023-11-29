### Get the data

To get the data go to [http://bnci-horizon-2020.eu/database/data-sets]() (might need to find it on the web archive https://web.archive.org/web/20231119215248/http://bnci-horizon-2020.eu/database/data-sets) and download all the files on the 2. entry. This means all the SxT files and all the SxE files from x = 01 to 13.

Then put them in the folder named data like so:

data/
-S01T
-S01E
-...
-S13T
-S13E

Then run the mne_analisys.ipynb

Remember to create a Virtual enviornment with all the neccecary libraries like this:

```bash
python -m venv ttk7
source ttk7/bin/activate  # On Windows: ttk7\Scripts\activate
pip install -r requirements.txt
```

Also when you select the mne_analisys.ipynb remember to select the ttk7 venv as the python env in the upper right corner.
