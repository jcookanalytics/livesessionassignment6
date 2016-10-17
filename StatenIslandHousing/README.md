# Staten Island Housing

This study was performed by Josepth Cook, Brian Gobran, and Brian Yu.

The purpose of the study was to determine if a relationship exists between family house sizes in square feet and the sale price.

The data were downloaded from the https://www1.nyc.gov/site/finance/taxes/property-rolling-sales-data.page on October 13, 2016 and contain data for the previous 12 months.  The data was downloaded in Excel format for Staten Island and stored as rollingsales_statenisland_raw.xls in the Data directory.  A copy of the file was made in csv format (rollingsales_statenisland.csv) after the four commentary rows at the top were removed.  This file was also stored in the data directory.

gather.R, in the Data directory, was used to load the data into a data frame in R (called si), show the first 6 rows, determine some properties of the variables, and see the structure of the data frame.  Then values were converted to numeric as appropriate.  Observations with actual sales prices were copied into a new data frame (si.sale).

analyze.R, in the Analysis directory, was used analyze the si.sale data frame that was created with the gather.R program.  To look at the data, initially both Cartesian and log-log graphs of the gross square footage versus the sale price were made.  These showed a lot of low-price noise.  These were removed as a second data frame was created with just slae prices over $100,000.  Both Cartesian and log-log graphs of these data showed good relationships.

MakeFile.R, also in the data directory, sets the working directory environment (after editing) and runs the gather.R and analyze.R files.


