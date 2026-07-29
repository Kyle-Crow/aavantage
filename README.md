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
├── StAlpha.jar
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
