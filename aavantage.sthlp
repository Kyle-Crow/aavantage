{smcl}
{* *! version 1.0.0  19jul2026}{...}
{vieweralsosee "[R] help" "help help"}{...}
{vieweralsosee "Alpha Vantage" "https://www.alphavantage.co/"}{...}
{p2colset 1 14 10 2}{...}

{p2col:{bf:aavantage} {hline 2}}Import various asset classes data from Alpha Vantage website{p_end}
{p2colreset}{...}

{marker syntax}{...}
{title:Syntax}

{phang}
Set the Alpha Vantage API key

{p 8 32 2}
{cmd:aavantage set} {it:apikey}

{phang}
Import stock data

{p 8 32 2}
{cmd:aavantage stock} {it:ticker}
[{cmd:,} {help aavantage##stock_options:{it:stock_options}}]

{phang}
Import market-index data

{p 8 32 2}
{cmd:aavantage index} {it:ticker}
[{cmd:,} {help aavantage##index_options:{it:index_options}}]


{phang}
Import cryptocurrency data

{p 8 32 2}
{cmd:aavantage crypto} {it:ticker}
[{cmd:,} {help aavantage##cryto_options:{it:cryto_options}}]

{phang}
Import commodity data

{p 8 32 2}
{cmd:aavantage commodity} {it:commodity_name}
[{cmd:,} {help aavantage##commodity_options:{it:commodity_options}}]

{phang}
Search for a ticker

{p 8 32 2}
{cmd:aavantage search} {it:text}

{phang}
List supported indexes or crypto markets

{p 8 32 2}
{cmd:aavantage list} {it:index}|{it:market}

{marker stock_options}{...}
{synoptset 25 tabbed}{...}
{synopthdr:stock_options}
{synoptline}
{synopt:{opt intraday(#)}}import intraday stock data.{p_end}
{synopt:{opt weekly}}import weekly stock data {p_end}
{synopt:{opt monthly}}import monthly stock data {p_end}
{synopt:{opt adjusted}}import adjusted stock data{p_end}
{synopt:{opt full}}request the full available{p_end}
{synopt:{opt wide}}reshape imported results into wide form{p_end}
{synopt:{opt clear}}clear the dataset currently in memory before importing{p_end}
{synoptline}
{pstd}
The default timespan is daily if no timespan is specified.{p_end}
{pstd}
The options {opt intraday()}, {opt weekly}, and {opt monthly} are mutually exclusive; only one may be specified.{p_end}

{marker index_options}{...}
{synoptset 25 tabbed}{...}
{synopthdr:index_options}
{synoptline}
{synopt:{opt weekly}}import weekly index data{p_end}
{synopt:{opt monthly}}import monthly index data{p_end}
{synopt:{opt wide}}reshape imported results into wide form{p_end}
{synopt:{opt clear}}clear the dataset currently in memory before importing{p_end}
{synoptline}
{pstd}
The default timespan is daily if no timespan is specified.{p_end}
{pstd}
The options {opt weekly}, and {opt monthly} are mutually exclusive; only one may be specified.{p_end}

{marker crypto_options}{...}
{synoptset 25 tabbed}{...}
{synopthdr:crypto_options}
{synoptline}
{synopt:{opt intraday(#)}}import intraday cryptocurrency data{p_end}
{synopt:{opt market(string)}}specify the market currencys{p_end}
{synopt:{opt weekly}}import weekly cryptocurrency data{p_end}
{synopt:{opt monthly}}import monthly cryptocurrency data{p_end}
{synopt:{opt full}}request the full available Alpha Vantage dataset{p_end}
{synopt:{opt wide}}reshape imported results into wide form{p_end}
{synopt:{opt clear}}clear the dataset currently in memory before importing{p_end}
{synoptline}
{pstd}
The default timespan is daily if no timespan is specified.{p_end}
{pstd}
The options {opt intraday()}, {opt weekly}, and {opt monthly} are mutually exclusive; only one may be specified.{p_end}
{marker commodity_options}{...}


{marker commodity_options}{...}
{synoptset 25 tabbed}{...}
{synopthdr:commodity_options}
{synoptline}
{synopt:{opt daily}}import daily commodity data{p_end}
{synopt:{opt weekly}}import weekly commodity data{p_end}
{synopt:{opt quarterly}}import quarterly commodity data{p_end}
{synopt:{opt annual}}import annual commodity data{p_end}
{synopt:{opt clear}}clear the dataset currently in memory before importing
data.{p_end}
{synoptline}
{pstd}The default timespan is monthly if no timespan is specified.{p_end}
{pstd}
The options {opt daily}, {opt weekly},{opt monthly}, {opt quarterly}, and {opt annual} are mutually exclusive; only one may be specified.{p_end}

{pstd}
Daily and weekly data are available for

{phang2}
{cmd:gold}, {cmd:silver}, {cmd:gas}, {cmd:oilbrent}, {cmd:oilwti}, {cmd:aluminum}, and {cmd:copper}.

{pstd}
Quarterly and annual data are available for {p_end}

{phang2}
{cmd:wheat}, {cmd:sugar}, {cmd:index},
{cmd:corn}, {cmd:cotton}, and {cmd:coffee}.

{pstd}
Requesting a frequency that is not available for the selected commodity
results in error code {cmd:198}.

{marker description}{...}
{title:Description}

{pstd}
{cmd:aavantage} imports stock, market-index, cryptocurrency, and commodity
data from Alpha Vantage.

{pstd}
{cmd:aavantage search} searches for ticker symbols matching the specified text(case sensitive).

{pstd}
{cmd:aavantage list} displays supported market indexes or cryptocurrency market
codes.

{pstd}
An Alpha Vantage API key must be set before data can be imported. The key
may be obtained from

{phang2}
{browse "https://www.alphavantage.co/support/#api-key":Alpha Vantage API key registration}.

{pstd}
The API key is set by typing

{phang2}
{cmd:aavantage set} {it:apikey}

{pstd}
where {it:apikey} is a valid Alpha Vantage API key.

{pstd}
Imported date strings are converted to Stata numeric dates. Daily, weekly,
monthly, quarterly, and annual dates are stored using the {cmd:%td} display
format. Intraday dates and times are stored using the {cmd:%tc} display
format.

{pstd}
{cmd:aavantage stock} can import data from supported exchanges by 
adding the exchange to the ticker.  For example, 

{col 8}{cmd:TSCO.LON}
{col 8}{cmd:SHOP.TRT}
{col 8}{cmd:GPV.TRV}
{col 8}{cmd:MBG.DEX}
{col 8}{cmd:RELIANCE.BSE}
{col 8}{cmd:600104.SHH}
{col 8}{cmd:000002.SHZ}

{marker options}{...}
{title:Options}

{pstd}
Options are presented under the following headings:

        {help aavantage##stock_opts:Options for aavantage stock}
        {help aavantage##index_opts:Options for aavantage index}
        {help aavantage##crypto_opts:Options for aavantage crypto}
        {help aavantage##commodity_opts:Options for aavantage commodity}


{marker stock_opts}{...}
{title:Options for aavantage stock}

{pstd}
{opt intraday(#)} imports intraday stock data. Valid values for
{it:#} are {cmd:1}, {cmd:5}, {cmd:15}, {cmd:30}, and {cmd:60}, representing
the interval in minutes.{p_end}

{pstd}
{opt full} requests the full available Alpha Vantage dataset rather
than the default compact data. This option only works with option {opt intraday()}
{p_end}

{pstd}
{opt weekly} import weekly stock data.  The default is daily data.
{p_end}

{pstd}
{opt monthly} import monthly stock data. The default is daily data.
{p_end}

{pstd}
{opt adjusted} import adjusted stock data. With daily data,
{opt adjusted} requests daily adjusted data. When combined with
{opt weekly} or {opt monthly}, it requests adjusted data at the selected
frequency.
{p_end}

{pstd}
{opt wide} reshapes imported results into wide form.  The default is long form.
{p_end}

{pstd}
{opt clear} clear the dataset currently in memory before importing data.
{p_end}

{marker index_opts}{...}
{title:Options for aavantage index}

{pstd}
{opt weekly} imports weekly market index data. The default is daily data.
{p_end}

{pstd}
{opt monthly} imports monthly market index data. The default is daily data.
{p_end}

{pstd}
The options {opt weekly} and {opt monthly} are mutually exclusive.
{p_end}

{pstd}
{opt wide} reshapes imported results into wide form. The default is long form.
{p_end}

{pstd}
{opt clear} clears the dataset currently in memory before importing data.
{p_end}


{marker crypto_opts}{...}
{title:Options for aavantage crypto}

{pstd}
{opt intraday(#)} imports intraday cryptocurrency data. Valid values for
{it:#} are {cmd:1}, {cmd:5}, {cmd:15}, {cmd:30}, and {cmd:60}, representing
the interval in minutes.
{p_end}

{pstd}
{opt market(string)} specifies the market currency used for the request.
The default market is {cmd:USD}.
{p_end}

{pstd}
{opt full} requests the full available Alpha Vantage dataset rather
than the default compact data. This option is only available with
{opt intraday()} cryptocurrency requests.

{pstd}
{opt weekly} imports weekly cryptocurrency data. The default is daily data.
{p_end}

{pstd}
{opt monthly} imports monthly cryptocurrency data. The default is daily data.
{p_end}

{pstd}
The options {opt intraday()}, {opt weekly}, and {opt monthly} are mutually
exclusive.
{p_end}

{pstd}
{opt wide} reshapes imported results into wide form. The default is long form.
{p_end}

{pstd}
{opt clear} clears the dataset currently in memory before importing data.
{p_end}


{marker commodity_opts}{...}
{title:Options for aavantage commodity}

{pstd}
Commodity information is presented under the following headings:

        {help aavantage##commodity_list:Supported commodities}
        {help aavantage##commodity_history:Historical Commodity Data}
        {help aavantage##commodity_spot:Gold and Silver Spot Prices}


{marker commodity_list}{...}
{title:Supported commodities}

{pstd}
The following commodities are currently supported:

{col 8}{cmd:aluminum}
{col 8}{cmd:brent}
{col 8}{cmd:coffee}
{col 8}{cmd:copper}
{col 8}{cmd:corn}
{col 8}{cmd:cotton}
{col 8}{cmd:goldsilverspot}
{col 8}{cmd:naturalgas}
{col 8}{cmd:oilwti}
{col 8}{cmd:rice}
{col 8}{cmd:soybeans}
{col 8}{cmd:sugar}
{col 8}{cmd:wheat}

{pstd}
The special commodity {cmd:goldsilverspot} returns the current gold and
silver spot prices and is described under
{help aavantage##commodity_spot:Gold and Silver Spot Prices}. All other
commodities import historical data and are described under
{help aavantage##commodity_history:Historical Commodity Data}.
{p_end}

{marker commodity_history}{...}
{title:Historical Commodity Data}

{pstd}
The default timespan is monthly.
{p_end}

{pstd}
{opt daily} imports daily commodity data when supported by the selected
commodity.
{p_end}

{pstd}
{opt weekly} imports weekly commodity data when supported by the selected
commodity.
{p_end}

{pstd}
{opt quarterly} imports quarterly commodity data when supported by the
selected commodity.
{p_end}

{pstd}
{opt annual} imports annual commodity data when supported by the selected
commodity.
{p_end}

{pstd}
The options {opt daily}, {opt weekly}, {opt quarterly}, and
{opt annual} are mutually exclusive. Only one frequency option may be
specified.
{p_end}

{pstd}
Not every commodity supports every frequency. If an unsupported
frequency is requested, {cmd:aavantage} returns error code {cmd:198}.
{p_end}

{pstd}
{opt clear} clears the dataset currently in memory before importing
data.
{p_end}

{marker commodity_spot}{...}
{title:Gold and Silver Spot Prices}

{pstd}
The special commodity {cmd:goldsilverspot} returns the current gold and
silver spot prices. Unlike the historical commodity commands, it does
not import a dataset.
{p_end}

{pstd}
No options are allowed with {cmd:goldsilverspot}. Specifying any option
returns error code {cmd:198}.
{p_end}

{pstd}
The command returns the following scalars:
{p_end}

{phang2}
{cmd:r(gold_spot)} current gold spot price.

{phang2}
{cmd:r(silver_spot)} current silver spot price.

{pstd}
The precise variables returned may depend on the Alpha Vantage endpoint and
the requested data type.

{marker examples}{...}
{title:Examples}

{phang}
Set an API key

{phang2}
{cmd:. aavantage set ABCDEFGHIJKLMNOP}

{phang}
Search for a ticker

{phang2}
{cmd:. aavantage search Microsoft}

{phang}
Import daily stock data

{phang2}
{cmd:. aavantage stock IBM, clear}

{phang}
Set an API key

{phang2}
{cmd:. aavantage set ABCDEFGHIJKLMNOP}

{phang}
Import daily stock data

{phang2}
{cmd:. aavantage stock IBM, clear}

{phang}
Import 15-minute intraday stock data

{phang2}
{cmd:. aavantage stock IBM, intraday(15) clear}

{phang}
Import adjusted weekly stock data

{phang2}
{cmd:. aavantage stock IBM, weekly adjusted clear}

{phang}
Import monthly stock data using the full output size

{phang2}
{cmd:. aavantage stock F, monthly full clear}

{phang}
Import daily stock data from the Toronto Stock Exchange

{phang2}
{cmd:. aavantage stock SHOP.TRT, clear}

{phang}
List supported indexes

{phang2}
{cmd:. aavantage list index}

{phang}
Import daily market-index data

{phang2}
{cmd:. aavantage index DJI, clear}

{phang}
Import weekly market-index data

{phang2}
{cmd:. aavantage index DJI, weekly clear}

{phang}
List supported cryptocurrency markets

{phang2}
{cmd:. aavantage list market}

{phang}
Import daily Bitcoin data using the default USD market

{phang2}
{cmd:. aavantage crypto BTC, clear}

{phang}
Import 5-minute Ethereum data

{phang2}
{cmd:. aavantage crypto ETH, intraday(5) market(USD) clear}

{phang}
Import monthly corn data

{phang2}
{cmd:. aavantage commodity corn, clear}

{phang}
Import annual corn data

{phang2}
{cmd:. aavantage commodity corn, annual clear}

{phang}
Import daily West Texas Intermediate crude-oil data

{phang2}
{cmd:. aavantage commodity oilwti, daily clear}

{phang}
Import quarterly gold data

{phang2}
{cmd:. aavantage commodity gold, quarterly clear}

{marker errors}{...}
{title:Common error codes}

{synoptset 15 tabbed}{...}
{synopthdr}
{synoptline}

{synopt:{cmd:4}}the dataset in memory has changed and {opt clear} was not
specified.{p_end}

{synopt:{cmd:100}}a required argument, such as the API key, ticker, or
commodity name, was omitted.{p_end}

{synopt:{cmd:198}}an invalid option, option combination, intraday interval,
commodity name, or commodity frequency was specified.{p_end}

{synoptline}

{marker author}{...}
{title:Author}

{pstd}
Kyle Crow
