nseR - Get real time NIFTY50 index option chain and more ggplot2 enhancements
===========================================================================

> *Copyright 2016 [Ramanathan Perumal](http://github.com/ramamet). Licensed under
> the MIT license.*
:snowflake::snowman:

Installation :computer::inbox_tray::books:
------------
`nseR` is available through GitHub.

To install the latest version from GitHub:

    install.packages("devtools")
    devtools::install_github("ramamet/nseR")
    

Usage :office::wrench::card_index:
-----

We'll first load the package, and then see how all the
functions work.
   
    library("nseR")

nse_options() function
-----
Let's use `nse_options` function to scrape realtime option chain properties with 11 columns.
Understanding the database with basic descriptive statistics;

>nse_options(month = "near", bet = 8100, optMin = 7500, optMax = 9000) format

month variable are "near","next" and "far" months;
bet variable is expecting the strikeprice for the coming month;
optMin and optMax are limits of the dataframe;

    my.df=nse_options()
    head(my.df)
    
           c.ltp c.netC  c.vol   c.OI c.COI   sp p.ltp p.netC   p.vol    p.OI  p.COI
        1 592.40    0.0      0      0     0 7550 23.05  -3.90   49425   17625  11775
        2 568.20   19.2  33225 234150 13875 7600 27.15  -4.15 1912725 1967850 135375
        3 408.00    0.0      0    225     0 7650 31.85  -4.80   63900   14625      0
        4 480.50   19.6  23775 263025     0 7700 37.55  -4.90 2817900 2396850 126525
        5 412.75    0.0      0    750     0 7750 44.05  -5.80   42225   40275   2175
        6 394.70   19.5 146475 738500  8175 7800 51.45  -6.00 3496950 2560725 112650


nse_gg() function
-----

![nse](https://cloud.githubusercontent.com/assets/16385390/20681234/fe83fb1e-b5a2-11e6-8c75-98d8b92c2966.png)

rawData 
-----
webscraped datasets from the following website;


http://www.moneycontrol.com/india/indexfutures/nifty/9/


contact :mailbox::package:
-----
If you would like to contribute further on this package or bugs, please respond me by `ramamet4@gmail.com`.   

