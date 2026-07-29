# aavantage

`aavantage` is a Stata 19 command that imports financial and economic data directly from the Alpha Vantage API.

The command supports:

- Stocks
- Market indexes
- Cryptocurrencies
- Commodities
- Gold and silver spot prices
- Ticker symbol searches
- Lists of supported indexes, markets, cryptocurrencies, and commodities

---

# Installation

## Requirements

Before installing `aavantage`, make sure you have:

- Stata 19 or newer
- Java enabled in Stata
- An internet connection
- A free Alpha Vantage API key

You can obtain a free API key from:

https://www.alphavantage.co/support/#api-key

---

## Install the Package

1. Download or clone this repository.

2. Copy **all package files** into your personal Stata directory.

### Linux

```text
~/.stata/ado/personal/
```

### macOS

```text
~/.stata/ado/personal/
```

### Windows

```text
C:\Users\<username>\ado\personal\
```

Your personal directory should contain the package files:

```text
personal/
├── aavantage.ado
├── aavantage.sthlp
├── aavantage.dlg
├── StAlphaCombined.jar
```

3. Restart Stata.

---

## Configure Your API Key

Once the files have been installed, set your Alpha Vantage API key:

```stata
aavantage set YOUR_API_KEY
```

Replace `YOUR_API_KEY` with your personal Alpha Vantage API key.

You only need to do this once.

---

## Verify the Installation

Search for a ticker:

```stata
aavantage search Microsoft
```

or import stock data:

```stata
aavantage stock IBM, clear
```

If data are successfully returned, the installation is complete.

---

# Command Syntax

## Set an API Key

```stata
aavantage set apikey
```

## Import Stock Data

```stata
aavantage stock ticker [, stock_options]
```

## Import Market-Index Data

```stata
aavantage index ticker [, index_options]
```

## Import Cryptocurrency Data

```stata
aavantage crypto ticker [, crypto_options]
```

## Import Commodity Data

```stata
aavantage commodity commodity_name [, commodity_options]
```

## Search for a Ticker

```stata
aavantage search text
```

## List Supported Values

```stata
aavantage list index
aavantage list market
aavantage list crypto
aavantage list commodity
```
# Examples

The following examples demonstrate some of the most common uses of `aavantage`, including downloading stock and cryptocurrency data, searching for ticker symbols, and listing supported markets and cryptocurrencies by Alpha Vantage.

## Import Stock Data

This example downloads the complete daily price history for Ford Motor Company (`F`) and Shopify Inc (`SHOP.TRT`).
```stata

. aavantage stock F SHOP.TRT, clear full
(7 vars, 9532 obs)

. des

Contains data
 Observations:         9,532                  
    Variables:             7                  
--------------------------------------------------------------
Variable      Storage   Display    Value
    name         type    format    label      Variable label
--------------------------------------------------------------
date            int     %td                   
ticker          str8    %9s                   
open            double  %10.0g                
high            double  %10.0g                
low             double  %10.0g                
close           double  %10.0g                
volume          long    %10.0g                
--------------------------------------------------------------
Sorted by: 
     Note: Dataset has changed since last saved.

```
---

## Search for and Import an Internationally Listed Stock

The `search` command searches Alpha Vantage for ticker symbols matching a company name. In this example, searching for *Samsung* returns several listings across different stock exchanges. The weekly stock data are then downloaded using the London Stock Exchange ticker (`SMSN.LON`), demonstrating that `aavantage` supports both U.S.- and international-listed stocks.

```stata
. aavantage search Samsung

Symbol:     SMSN.LON
Name:       Samsung Electronics Co. Ltd
<out omitted>

. aavantage stock SMSN.LON, weekly clear
(7 vars, 1131 obs)
```


## List Cryptocurrency

To list all of the available currencies you can import, type: 

```stata
. aavantage list crypto
00: 00 Token
1INCH: 1inch
A8: Ancient8
<out omitted>
```


## Import Cryptocurrency Data

In this example, daily price data are downloaded for both **ALCX** and **Bitcoin (BTC)** using the **euro (`EUR`) market**, so prices are returned in euros rather than U.S. dollars.

```stata
. aavantage list market
USD: US Dollar
BTC: Bitcoin
EUR: Euro
GBP: British Pound Sterling
USDT: Tether
ETH: Ethereum
USDC: USD Coin
DAI: Dai

. aavantage crypto ALCX BTC, clear market(EUR)
(7 vars, 700 obs)

. des

Contains data
 Observations:           700                  
    Variables:             7                
-------------------------------------------------------------
Variable      Storage   Display    Value
    name         type    format    label      Variable label
-------------------------------------------------------------
date            int     %td                   
ticker          str4    %9s                   
open            double  %10.0g                
high            double  %10.0g                
low             double  %10.0g                
close           double  %10.0g                
volume          double  %10.0g                
--------------------------------------------------------------
Sorted by: 
     Note: Dataset has changed since last saved.
```

