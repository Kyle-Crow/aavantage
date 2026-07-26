*! version 1.0.0  24may2026
program define aavantage, rclass
	version 19
	local version : di "version " string(_caller()) ":"

	gettoken subcmd 0 : 0, parse(" ,")
	local l = length(`"`subcmd'"')

	if `"`subcmd'"' == "set" {
		`version' AaSet `macval(0)'
	}
	else if `"`subcmd'"' == bsubstr("stock", 1, max(3,`l')) {
		`version' AaStock `macval(0)'
	}
	else if `"`subcmd'"' == bsubstr("index", 1, max(3,`l')) {
		`version' AaIndex `macval(0)'
	}
	else if `"`subcmd'"' == bsubstr("crypto", 1, max(3,`l')) {
		`version' AaCrypto `macval(0)'
	}
	else if `"`subcmd'"' == bsubstr("commodity", 1, max(3,`l')) {
		`version' AaCommodity `macval(0)'
	}
	else if `"`subcmd'"' == bsubstr("search", 1, max(4,`l')) {
		`version' AaSearch `macval(0)'
	}
	else if `"`subcmd'"' == bsubstr("list", 1, max(4,`l')) {
		`version' AaList `macval(0)'
	}
	else {
		local s_err `"{bf:aavantage}: unknown subcommand "{bf:`subcmd'}""'
		display as err "`s_err'"
	}
end

global javacall "javacall io.github.kylecrow.aavantage.StAlphaAvantage"
global jars "sfi-api.jar;StAlphaCombined.jar;"
//global jars "gson-2.14.0.jar;StAlpha.jar;sfi-api.jar"

program define AaSet
	version 19
	syntax anything(id="apikey")

	$javacall setClientStrings, args("`anything'")			///
		jars($jars)
end

program define AaStock
	version 19
	syntax anything(id="ticker")					///
		[, intraday(integer 0) weekly monthly adjusted 		/// 
		full wide clear entitlement reghours]

	if `c(changed)' == 1 & "`clear'" == "" {
		di as err "no; dataset in memory has changed since last saved"
		exit 4
	}
	if("`clear'" != ""){
		clear
	}
	if "`weekly'" != "" & "`monthly'" != "" {
		di as err "options {bf:weekly} and {bf:monthly} may not be combined"
		exit 198
	}
	if "`weekly'" != "" & "`intraday'" != "0" {
		di as err "options {bf:weekly} and {bf:intraday} may not be combined"
		exit 198
	}
	if "`monthly'" != "" & "`intraday'" != "0" {
		di as err "options {bf:monthly} and {bf:intraday} may not be combined"
		exit 198
	}
	if "`adjusted'" != "" & "`intraday'" != "0" {
		di as err "options {bf:adjusted} and {bf:intraday} may not be combined"
		exit 198
	}
	
	local interval = "daily"

	if  "`adjusted'" != "" {
		local interval = "daily_adjusted"
	}
	if "`intraday'" != "0" {
		aavantage_check_intraday `intraday'
		local interval = "`s(mintype)'"
	}
	if "`weekly'" != "" {
		local interval = "weekly"
		if  "`adjusted'" != "" {
			local interval = "weekly_adjusted"
		}
	}
	
	if "`monthly'" != "" {
		local interval = "monthly"
		if  "`adjusted'" != "" {
			local interval = "monthly_adjusted"
		}
	}
	local full_allowed = 0
	if index("`interval'", "daily") > 0 | index("`interval'", "min") > 0 {
		local full_allowed = 1
	}

	if "`full'" != ""  & `full_allowed' == 0 {
		di as err "{bf:full} not allowed with time series specified"
		exit(198)
	}
	if "`reghours'" != ""  & `full_allowed' == 0 {
		di as err "{bf:reghours} not allowed with time series specified"
		exit(198)
	}
	if "`entitlement'" != ""  & `full_allowed' == 0 {
		di as err "{bf:entitlement} not allowed with time series specified"
		exit(198)
	}

	$javacall getStockData, ///
	args("`anything'" "`interval'" "`full'" "`reghours'" "`entitlement'") ///
	jars($jars)

	if  "`wide'" != "" {
		aavantage_wide_merge, varp(ticker) varm(date)		///
			rvars(open high low close volume)
	}
	if "`intraday'" != "0" {
		qui gen double date_num = clock(date,"YMDhms")
		format date_num %tc
	}
	else{
		qui gen double date_num = date(date,"YMD")
		format date_num %td
		
	}
	
	qui drop date
	rename date_num date
	order date
	qui compress
	di as text "(`c(k)' vars, `c(N)' obs)"
end

//INDEX
program define AaIndex
	version 19
	syntax anything(id="ticker")					///
		[, weekly monthly wide clear]

	if `c(changed)' == 1 & "`clear'" == "" {
		di as err "no; dataset in memory has changed since last saved"
		exit 4
	}
	if("`clear'" != ""){
		clear
	}
	if "`weekly'" != "" & "`monthly'" != "" {
		di as err "options {bf:weekly} and {bf:monthly} may not be combined"
		exit 198
	}
	
	local interval = "daily"
	if "`weekly'" != "" {
		local interval = "weekly"
	}
	if "`monthly'" != "" {
		local interval = "monthly"
	}

	$javacall getIndexData, ///
		args("`anything'" "`interval'")			///
		jars($jars)

	if  "`wide'" != "" {
		aavantage_wide_merge, varp(ticker) varm(date)		///
			rvars(open high low close)
	}
	
	
	qui gen double date_num = date(date,"YMD")
	format date_num %td
	
	qui drop date
	rename date_num date
	order date
	qui compress
	di as text "(`c(k)' vars, `c(N)' obs)"
end

//CRYPTO

program define AaCrypto
	version 19
	syntax anything(id="ticker")					///
		[, intraday(integer 0) market(string) weekly monthly full wide clear]

	if `c(changed)' == 1 & "`clear'" == "" {
		di as err "no; dataset in memory has changed since last saved"
		exit 4
	}
	if("`clear'" != ""){
		clear
	}
	if "`weekly'" != "" & "`monthly'" != "" {
		di as err "options {bf:weekly} and {bf:monthly} may not be combined"
		exit 198
	}
	if "`weekly'" != "" & "`intraday'" != "0" {
		di as err "options {bf:weekly} and {bf:intraday} may not be combined"
		exit 198
	}
	if "`monthly'" != "" & "`intraday'" != "0" {
		di as err "options {bf:monthly} and {bf:intraday} may not be combined"
		exit 198
	}
	
	local interval = "daily"
	
	if "`intraday'" != "0" {
		aavantage_check_intraday `intraday'
		local interval = "`s(mintype)'"
	}
	if "`weekly'" != "" {
		local interval = "weekly"
	}
	
	if "`monthly'" != "" {
		local interval = "monthly"
	}

	if "`market'" == "" {
		local market = "USD"
	}

	if "`full'" != "" {
		if index("`interval'", "min") == 0 {
			di as err "full not allowed with time series specified"
			exit(198)
		}
	}

	if("`market'" == ""){
		local market = "USD"
	}

	$javacall getCryptoData, ///
		args("`anything'" "`interval'" "`market'" "`full'")			///
		jars($jars)

	if  "`wide'" != "" {
		aavantage_wide_merge, varp(ticker) varm(date)		///
			rvars(open high low close volume)
	}
	if "`intraday'" != "0" {
		qui gen double date_num = clock(date,"YMDhms")
		format date_num %tc
	}
	else{
		qui gen double date_num = date(date,"YMD")
		format date_num %td
		
	}
	
	qui drop date
	rename date_num date
	order date
	qui compress
	di as text "(`c(k)' vars, `c(N)' obs)"
end

//COMMODITY

//INDEX
program define AaCommodity
	version 19
	syntax anything(id="commodity_name")				///
		[, daily weekly quarterly annual clear]
	
	aavantage_check_commodity "`anything'"
	local commodity = "`s(commoditytype)'" 

	if ("`commodity'" == "goldsilverspot") {
		local opts = "`daily'`weekly'`quarterly'`annual'`full'`clear'"
		if ("`opts'" != "") {
			di as err "no options allowed with goldsilverspot"
			exit 198
		}
		$javacall getCommodityData, ///
			args("`anything'" "daily")				///
			jars($jars)
		exit
	}

	if `c(changed)' == 1 & "`clear'" == "" {
		di as err "no; dataset in memory has changed since last saved"
		exit 4
	}
	if("`clear'" != ""){
		clear
	}

	if "`weekly'" != "" & "`daily'" != "" {
		di as err "options {bf:weekly} and {bf:monthly} may not be combined"
		exit 198
	}

	if "`weekly'" != "" & "`quarterly'" != "" {
		di as err "options {bf:weekly} and {bf:quarterly} may not be combined"
		exit 198
	}

	if "`daily'" != "" & "`quarterly'" != "" {
		di as err "options {bf:monthly} and {bf:quarterly} may not be combined"
		exit 198
	}

	if "`weekly'" != "" & "`annual'" != "" {
		di as err "options {bf:weekly} and {bf:annual} may not be combined"
		exit 198
	}

	if "`daily'" != "" & "`annual'" != "" {
		di as err "options {bf:monthly} and {bf:annual} may not be combined"
		exit 198
	}
	if "`quarterly'" != "" & "`annual'" != "" {
		di as err "options {bf:quarterly} and {bf:annual} may not be combined"
		exit 198
	}

	local interval = "monthly"
	if "`daily'" != "" {
		local interval = "daily"
	}

	if "`weekly'" != "" {
		local interval = "weekly"
	}
	
	if "`quarterly'" != "" {
		local interval = "quarterly"
	}
	if "`annual'" != "" {
		local interval = "annual"
	}
	if("`interval'" == "daily" | "`interval'" == "weekly") {
		if ("`commodity'" != "gold" & "`commodity'" != "silver" &  ///
		"`commodity'" != "gas" & "`commodity'" != "oilbrent" & ///
			"`commodity'" != "oilwti" & "`commodity'" != "aluminum" & ///
			"`commodity'" != "copper") {
di as err "invalid syntax: {bf:`commodity'} only allows intervals monthly, quarterly, and annual"
				exit 198
			
		}
	}
	
	if "`interval'" == "quarterly" | "`interval'" == "annual" {
		if ("`commodity'" != "wheat" & "`commodity'" != "sugar" &	///
		"`commodity'" != "index" & "`commodity'" != "corn" &		///
		"`commodity'" != "cotton" & "`commodity'" != "coffee") {
di as err "invalid syntax: {bf:`commodity'} only allows intervals daily, weekly, and monthly"
				exit 198
		}
	}
	
	$javacall getCommodityData, ///
		args("`commodity'" "`interval'" )			///
		jars($jars)
	
	qui gen double date_num = date(date,"YMD")
	format date_num %td
		
	qui drop date
	rename date_num date
	order date
	qui compress
	di as text "(`c(k)' vars, `c(N)' obs)"
end

program define AaSearch
	version 19
	syntax anything(id="searchText")
	$javacall search, args(`"`anything'"')				///
		jars($jars)
end

program define AaList
	version 19
	syntax anything(id="listType")

	if "`anything'" != "index" & "`anything'" != "market" & "`anything'" != ///
	"crypto" & "`anything'" != "commodity"{
		di as err "invalid list type"
		exit 198
	}
	$javacall list, args(`"`anything'"')				///
		jars($jars)
end

//UTILITY
program aavantage_check_intraday, sclass
	args min_type

	local valid_min_types "1 5 15 30 60"

	local valid = 0
	foreach m of local valid_min_types {
		if ("`m'" == "`min_type'") {
			local valid = 1
			break
		}
	}

	if `valid' == 0 {
		di as err "{bf:`min_type'}: invalid value for option {bf:intraday()}"
		exit 198
	}
	local jc_arg = "`min_type'" + "min"
	sreturn local mintype "`jc_arg'"
end

program aavantage_check_commodity, sclass
	args commodity

	local valid_comm "goldsilverspot oilwti oilbrent gas gold silver copper aluminum"
	local valid_comm "`valid_comm' wheat corn cotton sugar coffee index"

	local valid = 0
	foreach c of local valid_comm { 
		if ("`c'" == "`commodity'") {
			local valid = 1
			break
		}
	}

	if `valid' == 0 {
		di as err "{bf:`commodity'}: invalid commodity specified"
		exit 198
	}
	sreturn local commoditytype "`commodity'"
end

program aavantage_wide_merge
	syntax, varp(varname) varm(varname) rvars(varlist)

	qui levelsof `varp', clean local(ticker_list)
	local levels = `r(r)'
	if `levels' == 1 {
		rename (`rvars') =_`ticker_list'
		exit
	}
	qui {
		foreach lvl of local ticker_list {
			preserve
			keep if `varp' == "`lvl'"
			rename (`rvars') =_`lvl'
			tempfile `lvl'
			sort `varm'
			drop `varp'
			qui save "``lvl''", replace
			restore
		}
		preserve
		local i = 1
		foreach lvl of local ticker_list {
			if `i' == 1 {
				capture use "``lvl''", clear
				if _rc {
					restore
					di as text "`_rc': option {bf:wide} failed on load"
					return
				}
		 		local i = `i' + 1
				continue
			}
			else {
				capture merge 1:1 `varm' using "``lvl''"
				if _rc {
					restore
					di as text "`_rc': option {bf:wide} failed on merge"
					return
				}
				drop _merge
			}
		 	local i = `i' + 1
		}
		restore, not
	}
end
