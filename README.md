# aavantage

`aavantage` is a Stata command that imports financial and economic data from the [Alpha Vantage](https://www.alphavantage.co/) API.

The command supports:

* Stocks
* Market indexes
* Cryptocurrencies
* Commodities
* Gold and silver spot prices
* Ticker-symbol searches
* Lists of supported symbols and markets

## Requirements

To use `aavantage`, you need:

* Stata
* An internet connection
* A valid Alpha Vantage API key
* The files included with the `aavantage` package

You can obtain an API key from the [Alpha Vantage website](https://www.alphavantage.co/support/#api-key).

## Setting the API Key

Before downloading data, set your Alpha Vantage API key:

```stata
aavantage set YOUR_API_KEY
```

Example:

```stata
aavantage set ABCDEFGHIJKLMNOP
```

Replace `ABCDEFGHIJKLMNOP` with your actual API key.

> Do not publish your personal API key in a public GitHub repository.

## Command Syntax

### Stock Data

```stata
aavantage stock ticker [, stock_options]
```

Example:

```stata
aavantage stock IBM, clear
```

### Market-Index Data

```stata
aavantage index ticker [, index_options]
```

Example:

```stata
aavantage index DJI, clear
```

### Cryptocurrency Data

```stata
aavantage crypto ticker [, crypto_options]
```

Example:

```stata
aavantage crypto BTC, clear
```

### Commodity Data

```stata
aavantage commodity commodity_name [, commodity_options]
```

Example:

```stata
aavantage commodity corn, clear
```

### Search for a Ticker

```stata
aavantage search text
```

Example:

```stata
aavantage search Microsoft
```

Ticker searches are case-sensitive.

### List Supported Values

```stata
aavantage list index
aavantage list market
aavantage list crypto
aavantage list commodity
```

These commands display the supported market indexes, cryptocurrency markets, cryptocurrencies, and commodities.

---

# Stock Data

The `stock` subcommand imports stock-market data.

## Basic Usage

```stata
aavantage stock ticker, clear
```

Example:

```stata
aavantage stock IBM, clear
```

Daily data are imported by default.

## Stock Options

| Option        | Description                                           |
| ------------- | ----------------------------------------------------- |
| `intraday(#)` | Imports intraday data at the selected minute interval |
| `weekly`      | Imports weekly stock data                             |
| `monthly`     | Imports monthly stock data                            |
| `adjusted`    | Imports adjusted stock data                           |
| `full`        | Requests the full available intraday dataset          |
| `wide`        | Reshapes the imported results into wide form          |
| `clear`       | Clears the current dataset before importing           |

Valid values for `intraday(#)` are:

```text
1
5
15
30
60
```

These values represent the number of minutes between observations.

Only one of the following frequency options may be specified:

```text
intraday()
weekly
monthly
```

## Stock Examples

Import daily IBM data:

```stata
aavantage stock IBM, clear
```

Import 15-minute IBM data:

```stata
aavantage stock IBM, intraday(15) clear
```

Import adjusted weekly IBM data:

```stata
aavantage stock IBM, weekly adjusted clear
```

Import monthly Ford data:

```stata
aavantage stock F, monthly clear
```

Request the full available intraday dataset:

```stata
aavantage stock F, intraday(5) full clear
```

Import stock data and reshape the results into wide form:

```stata
aavantage stock IBM, weekly wide clear
```

## International Exchanges

Stocks from supported international exchanges can be requested by adding an exchange suffix to the ticker.

Examples:

```stata
aavantage stock TSCO.LON, clear
aavantage stock SHOP.TRT, clear
aavantage stock GPV.TRV, clear
aavantage stock MBG.DEX, clear
aavantage stock RELIANCE.BSE, clear
aavantage stock 600104.SHH, clear
aavantage stock 000002.SHZ, clear
```

---

# Market-Index Data

The `index` subcommand imports market-index data.

## Basic Usage

```stata
aavantage index ticker, clear
```

Daily data are imported by default.

## Index Options

| Option    | Description                                 |
| --------- | ------------------------------------------- |
| `weekly`  | Imports weekly index data                   |
| `monthly` | Imports monthly index data                  |
| `wide`    | Reshapes the results into wide form         |
| `clear`   | Clears the current dataset before importing |

The `weekly` and `monthly` options cannot be used together.

## Index Examples

List supported indexes:

```stata
aavantage list index
```

Import daily Dow Jones Industrial Average data:

```stata
aavantage index DJI, clear
```

Import weekly index data:

```stata
aavantage index DJI, weekly clear
```

Import monthly index data:

```stata
aavantage index DJI, monthly clear
```

Import weekly data in wide form:

```stata
aavantage index DJI, weekly wide clear
```

---

# Cryptocurrency Data

The `crypto` subcommand imports cryptocurrency data.

## Basic Usage

```stata
aavantage crypto ticker, clear
```

Daily data are imported by default, and the default market currency is `USD`.

## Cryptocurrency Options

| Option           | Description                                  |
| ---------------- | -------------------------------------------- |
| `intraday(#)`    | Imports intraday cryptocurrency data         |
| `market(string)` | Specifies the market currency                |
| `weekly`         | Imports weekly cryptocurrency data           |
| `monthly`        | Imports monthly cryptocurrency data          |
| `full`           | Requests the full available intraday dataset |
| `wide`           | Reshapes the results into wide form          |
| `clear`          | Clears the current dataset before importing  |

Valid intraday intervals are:

```text
1
5
15
30
60
```

Only one of the following frequency options may be specified:

```text
intraday()
weekly
monthly
```

The `full` option is only available with `intraday()` requests.

## Cryptocurrency Examples

List supported cryptocurrency symbols:

```stata
aavantage list crypto
```

List supported market currencies:

```stata
aavantage list market
```

Import daily Bitcoin data using the default USD market:

```stata
aavantage crypto BTC, clear
```

Import daily Bitcoin data using another supported market:

```stata
aavantage crypto BTC, market(EUR) clear
```

Import five-minute Ethereum data:

```stata
aavantage crypto ETH, intraday(5) market(USD) clear
```

Import the full available five-minute Ethereum dataset:

```stata
aavantage crypto ETH, intraday(5) market(USD) full clear
```

Import weekly Bitcoin data:

```stata
aavantage crypto BTC, weekly clear
```

Import monthly Ethereum data in wide form:

```stata
aavantage crypto ETH, monthly wide clear
```

---

# Commodity Data

The `commodity` subcommand imports historical commodity data or returns current gold and silver spot prices.

## Basic Usage

```stata
aavantage commodity commodity_name, clear
```

Historical commodity data are imported monthly by default.

## Supported Commodities

```text
aluminum
brent
coffee
copper
corn
cotton
goldsilverspot
naturalgas
oilwti
rice
soybeans
sugar
wheat
```

Use the following command to see the supported commodity codes in Stata:

```stata
aavantage list commodity
```

## Commodity Options

| Option      | Description                                     |
| ----------- | ----------------------------------------------- |
| `daily`     | Imports daily commodity data when supported     |
| `weekly`    | Imports weekly commodity data when supported    |
| `quarterly` | Imports quarterly commodity data when supported |
| `annual`    | Imports annual commodity data when supported    |
| `clear`     | Clears the current dataset before importing     |

Only one frequency option may be used at a time.

Not every commodity supports every frequency. Requesting an unsupported frequency results in Stata error code `198`.

## Commodity Examples

Import monthly corn data:

```stata
aavantage commodity corn, clear
```

Import annual corn data:

```stata
aavantage commodity corn, annual clear
```

Import daily West Texas Intermediate crude-oil data:

```stata
aavantage commodity oilwti, daily clear
```

Import quarterly coffee data:

```stata
aavantage commodity coffee, quarterly clear
```

Import monthly copper data:

```stata
aavantage commodity copper, clear
```

---

# Gold and Silver Spot Prices

The special `goldsilverspot` commodity returns current gold and silver spot prices.

It does not import a dataset.

```stata
aavantage commodity goldsilverspot
```

No options are allowed with `goldsilverspot`.

The command returns two Stata scalars:

```stata
r(gold_spot)
r(silver_spot)
```

Display the returned values:

```stata
aavantage commodity goldsilverspot

display r(gold_spot)
display r(silver_spot)
```

Store the values in local macros:

```stata
aavantage commodity goldsilverspot

local gold = r(gold_spot)
local silver = r(silver_spot)

display "`gold'"
display "`silver'"
```

---

# Imported Dates

`aavantage` automatically converts dates returned by Alpha Vantage into Stata numeric dates.

Daily, weekly, monthly, quarterly, and annual observations use the Stata daily-date format:

```stata
%td
```

Intraday dates and times use the Stata datetime format:

```stata
%tc
```

You can inspect the format of a variable with:

```stata
describe date
```

You can manually apply a date format with:

```stata
format date %td
```

For intraday data:

```stata
format date %tc
```

---

# The `clear` Option

Stata protects datasets that have unsaved changes.

If a dataset is already loaded and has changed, this command may produce error code `4`:

```stata
aavantage stock IBM
```

To allow `aavantage` to remove the dataset currently in memory, specify `clear`:

```stata
aavantage stock IBM, clear
```

> Save important data before using the `clear` option.

---

# Long and Wide Data

Imported results use long form by default.

Example long-form structure:

```text
date          ticker    open    high    low    close
2026-07-01    IBM       ...     ...     ...    ...
2026-07-02    IBM       ...     ...     ...    ...
```

Use the `wide` option to reshape supported results into wide form:

```stata
aavantage stock IBM, weekly wide clear
```

```stata
aavantage crypto BTC, monthly wide clear
```

---

# Common Error Codes

| Error code | Meaning                                                                           |
| ---------- | --------------------------------------------------------------------------------- |
| `4`        | The dataset in memory has changed and `clear` was not specified                   |
| `100`      | A required argument was omitted                                                   |
| `198`      | An invalid option, option combination, interval, name, or frequency was specified |

## Error 4

Example:

```text
no; data in memory would be lost
r(4);
```

Solution:

```stata
save mydata, replace
aavantage stock IBM, clear
```

## Error 100

This error occurs when a required argument is missing.

Incorrect:

```stata
aavantage stock
```

Correct:

```stata
aavantage stock IBM, clear
```

## Error 198

This error may occur when:

* An invalid option is used.
* Mutually exclusive options are combined.
* An invalid intraday interval is specified.
* An unsupported commodity is requested.
* A commodity frequency is unavailable.
* Options are specified with `goldsilverspot`.

Incorrect:

```stata
aavantage stock IBM, weekly monthly
```

Correct:

```stata
aavantage stock IBM, weekly clear
```

Incorrect:

```stata
aavantage crypto BTC, intraday(10)
```

Correct:

```stata
aavantage crypto BTC, intraday(15) clear
```

Incorrect:

```stata
aavantage commodity goldsilverspot, clear
```

Correct:

```stata
aavantage commodity goldsilverspot
```

---

# Complete Example

The following example sets an API key, searches for Microsoft, imports Microsoft stock data, and examines the imported dataset:

```stata
clear all

aavantage set YOUR_API_KEY

aavantage search Microsoft

aavantage stock MSFT, weekly adjusted clear

describe
summarize
list in 1/10
```

Cryptocurrency example:

```stata
clear all

aavantage set YOUR_API_KEY

aavantage crypto BTC, intraday(15) market(USD) clear

describe
summarize
list in 1/10
```

Commodity example:

```stata
clear all

aavantage set YOUR_API_KEY

aavantage commodity copper, monthly clear

describe
summarize
list in 1/10
```

---

# GitHub Markdown Syntax

The following Markdown can be used when editing this README.

## Heading

```markdown
# Main Heading
## Section Heading
### Smaller Heading
```

## Bold Text

```markdown
**bold text**
```

Result: **bold text**

## Italic Text

```markdown
*italic text*
```

Result: *italic text*

## Inline Code

```markdown
Use the `aavantage stock` command.
```

## Code Block

Use three backticks before and after the code:

````markdown
```stata
aavantage stock IBM, clear
```
````

## Bullet List

```markdown
- Stocks
- Indexes
- Cryptocurrencies
- Commodities
```

## Numbered List

```markdown
1. Obtain an API key.
2. Set the API key.
3. Import data.
```

## Link

```markdown
[Alpha Vantage](https://www.alphavantage.co/)
```

## Table

```markdown
| Option | Description |
|---|---|
| `weekly` | Imports weekly data |
| `monthly` | Imports monthly data |
```

## Warning or Note

```markdown
> Do not publish your API key.
```

---

# Updating the GitHub Repository

After replacing or adding files in the local repository folder, run:

```bash
git status
git add .
git commit -m "Update aavantage files and documentation"
git push
```

To add only specific files:

```bash
git add README.md
git add aavantage.ado
git add aavantage.sthlp
git commit -m "Update README and Stata package files"
git push
```

To check which remote repository is connected:

```bash
git remote -v
```

To download changes from GitHub before uploading local changes:

```bash
git pull
```

A normal update workflow is:

```bash
git pull
git status
git add .
git commit -m "Describe the changes"
git push
```

---

# Project Files

A typical package may contain files such as:

```text
aavantage.ado
aavantage.sthlp
StAlpha.jar
README.md
LICENSE
```

* `aavantage.ado` contains the Stata command.
* `aavantage.sthlp` contains the Stata help documentation.
* `StAlpha.jar` contains compiled Java classes used by the command.
* `README.md` explains the project on GitHub.
* `LICENSE` explains how others may use or distribute the project.

Users normally do not extract the JAR file. The Stata command loads and uses the compiled Java classes contained inside it.

---

# Author

Kyle Crow
