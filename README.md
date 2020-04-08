# Midwest-Hydroclim
## Code
Note that most ".R" files have corresponding ".sh" files to be run on HPC.
- 1getHCNdata.R: Uses rnoaa package to generate daily percipitation data for missouri from 1970-2019. Saves output as "Data/allprcp.Rdata"
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
└── tree.txt

4 directories, 24 files
</pre>
