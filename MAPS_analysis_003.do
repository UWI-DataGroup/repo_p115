cls
capture log close
cd "/Users/kernrocke/Documents/Statistical Data Anlaysis/2019/Walkability/MAPS/Data"
log using "Log files/Data Preparation/MAPS_analysis_001", replace


**  GENERAL DO-FILE COMMENTS
**  program:		MAPS_analysis_003.do
**  project:      	Microscale Auidt of Pedestrian Streetscapes of UNESCO Hertiage Site Barbados
**  author:			Rocke, Whiteman, Hambleton, Howitt
**  task:          	Prevalence Estimates of key attributes from Crossing section of MAPS
**	Date Modified:	30/07/2019


** DO-FILE SET UP COMMANDS
version 13
clear all
macro drop _all
set more 1
set linesize 200

/*	
IMPORTANT: 
	The following STATA do files should be excuted prior the excuting this 
	do file
	1) MAPS_prep_001.do
	2) MAPS_prep_002.do
	
*/


use "MAPS Recoding Scoring", clear

*Keeping all street crossing data
keep if instrument_type==3

tab type_crossing

////////////////////////////////////////////////////////////////////////////////
*PEDESTRIAN SIGNALIZATION

*Prevalence estimates for No signals
ci crossings2___4 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Crossing") modify
putexcel B6=("Overall")
putexcel A7=("Pedestrian Signalization")
putexcel A8=("No signals")
putexcel B7=("Prevalence")
putexcel C7=("Lower Bound CI")
putexcel D7=("Upper Bound CI")
putexcel B8=(r(mean)) C8=(r(lb)) D8=(r(ub)) using "Prevalence estimates.xlsx", sheet("Crossing") modify

*Residential
ci crossings2___4 if type_crossing==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Crossing") modify
putexcel F6=("Residential")
putexcel F7=("Prevalence")
putexcel G7=("Lower Bound CI")
putexcel H7=("Upper Bound CI")
putexcel F8=(r(mean)) G8=(r(lb)) H8=(r(ub)) using "Prevalence estimates.xlsx", sheet("Crossing") modify

*Commerical
ci crossings2___4 if type_crossing==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Crossing") modify
putexcel J6=("Commerical")
putexcel J7=("Prevalence")
putexcel K7=("Lower Bound CI")
putexcel L7=("Upper Bound CI")
putexcel J8=(r(mean)) K8=(r(lb)) L8=(r(ub)) using "Prevalence estimates.xlsx", sheet("Crossing") modify

*Wald test for differences in proportions between residential and commercial
putexcel M7=("p-value")
proportion crossings2___4, over(type_crossing)
test [Checked] :Residenital = [Checked] :Commercial 
putexcel M8=(r(p)) using "Prevalence estimates.xlsx", sheet("Crossing") modify


*Prevalence estimates for Pedestrian walk signals
ci C1_3b , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Crossing") modify
putexcel A9=("Pedestrian walk signals")
putexcel B9=(r(mean)) C9=(r(lb)) D9=(r(ub)) using "Prevalence estimates.xlsx", sheet("Crossing") modify

*Residential
ci C1_3b if type_crossing==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Crossing") modify
putexcel F9=(r(mean)) G9=(r(lb)) H9=(r(ub)) using "Prevalence estimates.xlsx", sheet("Crossing") modify

*Commerical
ci C1_3b if type_crossing==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Crossing") modify
putexcel J9=(r(mean)) K9=(r(lb)) L9=(r(ub)) using "Prevalence estimates.xlsx", sheet("Crossing") modify

*Wald test for differences in proportions between residential and commercial
proportion C1_3b, over(type_crossing)
test [Checked] :Residenital = [Checked] :Commercial 
putexcel M9=(r(p)) using "Prevalence estimates.xlsx", sheet("Crossing") modify


*Prevalence estimates for Pedestrian push buttons
ci C1_3c , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Crossing") modify
putexcel A10=("Pedestrian push buttons")
putexcel B10=(r(mean)) C10=(r(lb)) D10=(r(ub)) using "Prevalence estimates.xlsx", sheet("Crossing") modify

*Residential
ci C1_3c if type_crossing==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Crossing") modify
putexcel F10=(r(mean)) G10=(r(lb)) H10=(r(ub)) using "Prevalence estimates.xlsx", sheet("Crossing") modify

*Commerical
ci C1_3c if type_crossing==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Crossing") modify
putexcel J10=(r(mean)) K10=(r(lb)) L10=(r(ub)) using "Prevalence estimates.xlsx", sheet("Crossing") modify

*Wald test for differences in proportions between residential and commercial
proportion C1_3c, over(type_crossing)
test [Checked] :Residenital = [Checked] :Commercial 
putexcel M10=(r(p)) using "Prevalence estimates.xlsx", sheet("Crossing") modify


*Prevalence estimates for Pedestrian countdown signals
ci C1_3d , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Crossing") modify
putexcel A11=("Pedestrian countdown signals")
putexcel B11=(r(mean)) C11=(r(lb)) D11=(r(ub)) using "Prevalence estimates.xlsx", sheet("Crossing") modify

*Residential
ci C1_3d if type_crossing==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Crossing") modify
putexcel F11=(r(mean)) G11=(r(lb)) H11=(r(ub)) using "Prevalence estimates.xlsx", sheet("Crossing") modify

*Commerical
ci C1_3d if type_crossing==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Crossing") modify
putexcel J11=(r(mean)) K11=(r(lb)) L11=(r(ub)) using "Prevalence estimates.xlsx", sheet("Crossing") modify

*Wald test for differences in proportions between residential and commercial
proportion C1_3d, over(type_crossing)
test [Checked] :Residenital = [Checked] :Commercial 
putexcel M11=(r(p)) using "Prevalence estimates.xlsx", sheet("Crossing") modify


////////////////////////////////////////////////////////////////////////////////
*PRE-CROSSING CURB

*Prevalence estimates for Pre-Crossing curb
ci C1_5a , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Crossing") modify
putexcel A13=("Pre-crossing curb")
putexcel B13=(r(mean)) C13=(r(lb)) D13=(r(ub)) using "Prevalence estimates.xlsx", sheet("Crossing") modify

*Residential
ci C1_5a if type_crossing==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Crossing") modify
putexcel F13=(r(mean)) G13=(r(lb)) H13=(r(ub)) using "Prevalence estimates.xlsx", sheet("Crossing") modify

*Commerical
ci C1_5a if type_crossing==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Crossing") modify
putexcel J13=(r(mean)) K13=(r(lb)) L13=(r(ub)) using "Prevalence estimates.xlsx", sheet("Crossing") modify

*Wald test for differences in proportions between residential and commercial
proportion C1_5a, over(type_crossing)
test [_prop_2] :Residenital = [_prop_2] :Commercial
putexcel M13=(r(p)) using "Prevalence estimates.xlsx", sheet("Crossing") modify

////////////////////////////////////////////////////////////////////////////////
*POST-CROSSING CURB

*Prevalence estimates for Post-Crossing curb
ci C1_5b , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Crossing") modify
putexcel A14=("Post-crossing curb")
putexcel B14=(r(mean)) C14=(r(lb)) D14=(r(ub)) using "Prevalence estimates.xlsx", sheet("Crossing") modify

*Residential
ci C1_5b if type_crossing==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Crossing") modify
putexcel F14=(r(mean)) G14=(r(lb)) H14=(r(ub)) using "Prevalence estimates.xlsx", sheet("Crossing") modify

*Commerical
ci C1_5b if type_crossing==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Crossing") modify
putexcel J14=(r(mean)) K14=(r(lb)) L14=(r(ub)) using "Prevalence estimates.xlsx", sheet("Crossing") modify

*Wald test for differences in proportions between residential and commercial
proportion C1_5b, over(type_crossing)
test [_prop_2] :Residenital = [_prop_2] :Commercial
putexcel M14=(r(p)) using "Prevalence estimates.xlsx", sheet("Crossing") modify

////////////////////////////////////////////////////////////////////////////////
*CROSSWALK TREATMENT


*Prevalence estimates for Marked crosswalk
ci C1_8a , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Crossing") modify
putexcel A16=("Crosswalk Treatment")
putexcel A17=("Marked crosswalk")
putexcel B17=(r(mean)) C17=(r(lb)) D17=(r(ub)) using "Prevalence estimates.xlsx", sheet("Crossing") modify

*Residential
ci C1_8a if type_crossing==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Crossing") modify
putexcel F17=(r(mean)) G17=(r(lb)) H17=(r(ub)) using "Prevalence estimates.xlsx", sheet("Crossing") modify

*Commerical
ci C1_8a if type_crossing==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Crossing") modify
putexcel J17=(r(mean)) K17=(r(lb)) L17=(r(ub)) using "Prevalence estimates.xlsx", sheet("Crossing") modify

*Wald test for differences in proportions between residential and commercial
proportion C1_8a, over(type_crossing)
test [Checked] :Residenital = [Checked] :Commercial 
putexcel M17=(r(p)) using "Prevalence estimates.xlsx", sheet("Crossing") modify


*Prevalence estimates for High-visibility striping
ci C1_8b , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Crossing") modify
putexcel A18=("High visibility striping")
putexcel B18=(r(mean)) C18=(r(lb)) D18=(r(ub)) using "Prevalence estimates.xlsx", sheet("Crossing") modify

*Residential
ci C1_8b if type_crossing==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Crossing") modify
putexcel F18=(r(mean)) G18=(r(lb)) H18=(r(ub)) using "Prevalence estimates.xlsx", sheet("Crossing") modify

*Commerical
ci C1_8b if type_crossing==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Crossing") modify
putexcel J18=(r(mean)) K18=(r(lb)) L18=(r(ub)) using "Prevalence estimates.xlsx", sheet("Crossing") modify

*Wald test for differences in proportions between residential and commercial
proportion C1_8b, over(type_crossing)
test [Checked] :Residenital = [Checked] :Commercial 
putexcel M18=(r(p)) using "Prevalence estimates.xlsx", sheet("Crossing") modify


*Prevalence estimates for No crosswalk treatment
ci crossings5___4 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Crossing") modify
putexcel A19=("No crosswalk treatment")
putexcel B19=(r(mean)) C19=(r(lb)) D19=(r(ub)) using "Prevalence estimates.xlsx", sheet("Crossing") modify

*Residential
ci crossings5___4 if type_crossing==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Crossing") modify
putexcel F19=(r(mean)) G19=(r(lb)) H19=(r(ub)) using "Prevalence estimates.xlsx", sheet("Crossing") modify

*Commerical
ci crossings5___4 if type_crossing==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Crossing") modify
putexcel J19=(r(mean)) K19=(r(lb)) L19=(r(ub)) using "Prevalence estimates.xlsx", sheet("Crossing") modify

*Wald test for differences in proportions between residential and commercial
proportion crossings5___4, over(type_crossing)
test [Checked] :Residenital = [Checked] :Commercial
putexcel M19=(r(p)) using "Prevalence estimates.xlsx", sheet("Crossing") modify


////////////////////////////////////////////////////////////////////////////////

/*
Note: crosswalk treatment - different material than road not included due to low
frequency (<5)

Curb extension present also excluded due to low frequency (<5)

*/

log close











