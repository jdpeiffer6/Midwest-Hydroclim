# Midwest-Hydroclim
## Code
Note that most ".R" files have corresponding ".sh" files to be run on HPC.
- **1getHCNdata.R** uses rnoaa package to generate daily percipitation data for missouri from 1970-2019. Saves output as "Data/allprcp.Rdata"
- **2.1NAcheck.R** loads output of 1 and analyzes the timing and extent of missing dates in the dataset/
- **3indicies.R** computes climdex indicies, currently only consecutive wet days (CWD).
- **Old** code that is not used anymore
## Data
- **MOstations** raw HCN output subsetted to Missouri precipation stations.
- **allprcp** time series data 1970-2019 of all Missouri precipation stations.
- **cwd** climdex.cwd data for allprcp. Much of the dataset has too many missing values.
- **missingdate** output of script 2 showing how many days each station misses as cutoff date progresses from 1970->2019.
- **uptonow** MOstations subsetted to data that goes to current date.
## Documents
- Not currently in use
## bin
- **tohpc** shell script that syncs repository to HPC and changes R setwd() paths to HPC paths.
- **fromhpc** brings data back from HPC and changes R paths back to local machine
- **toshare** copies repository to network drive
<pre>
.
├── Code
│   ├── 1getHCNdata.R
│   ├── 1getHCNdata.sh
│   ├── 2.1NAcheck.R
│   ├── 2.1NAcheck.sh
│   ├── 3indicies.R
│   ├── 3indicies.sh
│   └── Old
│       ├── 200224HCNdata.R
│       ├── 200224getHCNdata.R
│       ├── 200317_getHCNdata.R
│       ├── dateFormat.R
│       ├── getAverages.R
│       ├── getParkData.R
│       ├── locationStringConvert.R
│       ├── readData.R
│       └── success.R
├── Data
│   ├── MOstations.Rdata
│   ├── allprcp.Rdata
│   ├── cwd.Rdata
│   ├── missingDate.Rdata
│   └── uptonow.Rdata
├── Documents
│   ├── Journal.docx
│   ├── Links.xlsx
│   └── avgData.xlsx
├── bin
│   ├── fromhpc
│   ├── tohpc
│   └── toshare
└── tree.txt

5 directories, 27 files
</pre>
