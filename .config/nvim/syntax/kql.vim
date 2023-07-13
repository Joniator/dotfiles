" Vim syntax file
" Language:            Kusto Query Language
" Maintainer:          Nate Lehman <nalehman@microsoft.com>

syntax match kustoComparisonOperator "[!=][~=]" display
syntax match kustoComparisonOperator "[><]=\=" display
syntax match kustoStringOperator "!\=\<\(contains\|startswith\|endswith\|has\|hasprefix\|hassuffix\)\(_cs\)\=\>" display
syntax match kustoStringOperator "\<matches\>\s\+\<regex\>" display
syntax match kustoLogicalOperator "\<\(and\|or\)\>" display
syntax match kustoBetweenOperator "!\=\<between\>" display
syntax match kustoInOperator "!\=\<in\>\~\=" display
syntax match kustoNumericOperator "[*/%+-]" display

syntax match kustoComment "//.*$"

syntax keyword kustoTabularOperator as consume distinct count evaluate extend externaldata facet find fork getschema invoke join limit take lookup make-series mv-apply mv-expand order sort project project-away project-keep project-rename project-reorder parse parse-where partition print range reduce render sample sample-distinct scan search serialize summarize top top-nested top-hitters union where
syntax keyword kustoTabularStatement by on from to step asc desc with nulls first last

syntax keyword kustoQueryStatement let alias declare pattern restrict access set

syntax keyword kustoConstant false true visible hidden default linear log none axes panels

syntax keyword kustoBuiltinFunction count ingestion_time max max min iff isempty isnotempty log sum extract now makeset make_set makelist make_list arg_max arg_min any take_any dcount sumif countif avg materialize pack database strcat translate substring tostring toscalar strlen split typeof gettype datatable has_all has_any

syntax keyword kustoChartType anomalychart areachart barchart card columnchart ladderchart linechart piechart pivotchart scatterchart stackedareachart table timechart timepivot
syntax keyword kustoChartProperty kind accumulate legend series ymin ymax title xaxis xcolumn xtitle yaxis ycolumns ysplit ytitle anomalycolumns

syntax region kustoString matchgroup=kustoQuote start=/```/ end=/```/
syntax region kustoString matchgroup=kustoQuote start=/h\="/ skip=/\\"/ end=/"/ oneline
syntax region kustoString matchgroup=kustoQuote start=/h\='/ skip=/\\'/ end=/'/ oneline
syntax region kustoVerbatimString matchgroup=kustoQuote start=+h\=@"+ end=+"+ skip=+""+ extend contains=kustoVerbatimQuote
syntax match kustoVerbatimQuote	+""+ contained

syntax match kustoNumber "\<0[xX]\x\+\>" display
syntax match kustoNumber "\<\d\+\>" display
syntax match kustoNumber "\<\d\+[eE][-+]\=\d\+\>" display
syntax match kustoNumber "\<\d\+\%\([eE][-+]\=\d\+\)\=\>" display
syntax match kustoNumber "\<\d\+\.\d*\%\([eE][-+]\=\d\+\)\=" display

syntax match kustoTimespan "\<\d\+\%\(\.\d\+\)\=\%\([dhms]\|ms\|microsecond\|tick\)\>" display

highlight default link kustoComment Comment
highlight default link kustoComparisonOperator Operator
highlight default link kustoStringOperator Operator
highlight default link kustoLogicalOperator Operator
highlight default link kustoBetweenOperator Operator
highlight default link kustoInOperator Operator
highlight default link kustoNumericOperator Operator

highlight default link kustoTabularOperator Operator
highlight default link kustoTabularStatement Statement

highlight default link kustoQueryStatement Statement

highlight default link kustoConstant Constant

highlight default link kustoBuiltinFunction Function

highlight default link kustoChartType Constant
highlight default link kustoChartProperty Statement

highlight default link kustoString String
highlight default link kustoQuote String
highlight default link kustoVerbatimString String
highlight default link kustoVerbatimQuote SpecialChar

highlight default link kustoNumber Number

highlight default link kustoTimespan Number
