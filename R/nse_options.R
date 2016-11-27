#' nse options dataframe analysis
#' 
#' @importFrom magrittr %>%
#' @name %>%
#' @rdname pipe
#' @importFrom xml2 read_html
#' @name read_html
#' @importFrom rvest html_nodes
#' @name html_nodes
#' @importFrom rvest html_attr
#' @name html_attr
#' @importFrom rvest html_table
#' @name html_table
#' @export

specify_decimal <- function(x, k) format(round(x, k), nsmall = k)

#' @export
nsub = function(x) {
    x = gsub(",", "", x)
    return(x)
}

#' @export
numb = function(x) {
    x = as.numeric(as.character(x))
    return(x)
}

#***********************************
#++++++++++++ Main function ++++++++
#***********************************

#' @export

nse_options <- function(month = "near", bet = 8100, optMin = 7500, optMax = 9000) {

     options(warn=-1)
     
    #input dataset  
    url = "http://www.moneycontrol.com/india/indexfutures/nifty/9"
    
    exD = read_html(url) %>% 
	  html_nodes("#sel_exp_date option") %>%
	  html_attr("value")
    
    near = exD[3]
    nxt = exD[4]
    far = exD[5]
   
    if (month == "near") {
        Month = near
    } else if (month == "next") {
        Month = nxt
    } else Month = far
    
    bett = specify_decimal(bet, 2)
    
    # org
    # myurl='http://www.moneycontrol.com/india/indexfutures/nifty/9/2016-12-29/OPTIDX/CE/8100.00/true'
    
    myurl <- paste0("http://www.moneycontrol.com/india/indexfutures", "/nifty", "/", 
        9, "/", Month, "/OPTIDX", "/CE", "/", bett, "/true", sep = "")
    
    webpage <- read_html(myurl)
    
    
    tbls <- html_nodes(webpage, "table")
    
    
    # current price data
    live1_ls <- webpage %>% html_nodes("table") %>% .[3] %>% html_table(fill = TRUE)
    
    live1 = live1_ls[[1]]
    
    # current price data
    live2_ls <- webpage %>% html_nodes("table") %>% .[4] %>% html_table(fill = TRUE)
    
    live2 = live2_ls[[1]]
    
    live = rbind(live1, live2)
    
    colnames(live) <- c("v1", "v2")
    
    take = function(x) {
        x = gsub(",", "", x)
        x = as.numeric(as.character(x))
        return(x)
    }
    
    live$v2 = take(live$v2)
    
    # ** current NIFTY index
    cmp = live[5, 2]
    
    #+++++++++++++
    
    tbls_ls <- webpage %>% html_nodes("table") %>% .[7] %>% html_table(fill = TRUE)
    
    df1 = tbls_ls[[1]]
    
    colnames(df1) <- c("c.ltp", "c.netC", "c.vol", "c.OI", "c.COI", "sp", "p.ltp", 
        "p.netC", "p.vol", "p.OI", "p.COI")    
    
    df11 <- lapply(df1[1:11], nsub)
    df11 <- data.frame(df11)
        
    df2 <- lapply(df11[1:11], numb)
    df2 <- data.frame(df2)
    
    df3 <- data.frame(df2)
    df3[is.na(df3)] <- 0
    
    #+++ Filter the data
    Df = dplyr::filter(df3, (c.OI > 0) | (p.OI > 0))
    Df = dplyr::filter(Df, sp < optMax & sp > optMin)
    return(Df)
    
}



