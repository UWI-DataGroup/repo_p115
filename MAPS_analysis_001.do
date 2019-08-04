cls
clear

**  GENERAL DO-FILE COMMENTS
**  program:		MAPS_analysis_001.do
**  project:      	Microscale Auidt of Pedestrian Streetscapes of UNESCO Hertiage Site Barbados
**  author:			Rocke, Whiteman, Hambleton, Howitt
**  task:          	Prevalence Estimates of key attributes from Route section of MAPS
**	Date Modified:	01/08/2019


** DO-FILE SET UP COMMANDS
version 13
clear all
macro drop _all
set more 1
set linesize 200


/*	IMPORTANT: 

	The following STATA do files should be excuted prior the excuting this 
	do files

	1) MAPS_prep_001.do
	2) MAPS_prep_002.do
	
*/


*This do file uses the putexcel command for ease of creation of table 1

use "MAPS Recoding Scoring", clear

/// Creating exccel file to store Prevalence estimates results
putexcel set "Prevalence Estimates.xlsx"


*Time taken to conduct audit
mean time_diff, cformat(%tcHH:MM)

* Selecting maps route section for analysis
keep if instrument_type==1

//Route Descriptives

*Recoding mixed to commercial
*Frequency and percentage of type of routes audited
recode type (3=2)
tab type


*Types of residential uses
tab1 LU3a - LU3d


////////////////////////////////////////////////////////////////////////////////

***LAND USE

*Prevalence estimates for number of destinations by type

egen destinations = rowtotal(LU6a - LU6z)
recode destinations (5/max=5)
recode destinations (1/2=1) (3/4=2) (5=3)
tab destinations, gen(dest)


*Destination

** des1 = 0-2 Destinations
** des2 = 3-4 Destinations
** des1 = >5 Destinations

*Overall
ci dest1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel B7=("Overall")
putexcel A8=("Destinations")
putexcel A9=("0-2")
putexcel B8=("Prevalence")
putexcel C8=("Lower Bound CI")
putexcel D8=("Upper Bound CI")
putexcel B9=(r(mean)) C9=(r(lb)) D9=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify


*Residential
ci dest1 if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F7=("Residential")
putexcel F8=("Prevalence")
putexcel G8=("Lower Bound CI")
putexcel H8=("Upper Bound CI")
putexcel F9=(r(mean)) G9=(r(lb)) H9=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci dest1 if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J7=("Commerical")
putexcel J8=("Prevalence")
putexcel K8=("Lower Bound CI")
putexcel L8=("Upper Bound CI")
putexcel J9=(r(mean)) K9=(r(lb)) L9=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
putexcel M8=("p-value")
proportion dest1, over(type)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M9=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Overall
ci dest2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel A10=("3-4")
putexcel B10=(r(mean)) C10=(r(lb)) D10=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Residential
ci dest2 if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F10=(r(mean)) G10=(r(lb)) H10=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci dest2 if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J10=(r(mean)) K10=(r(lb)) L10=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
proportion dest2, over(type)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M10=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify


*Overall
ci dest3 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel A11=(">5")
putexcel B11=(r(mean)) C11=(r(lb)) D11=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Residential
ci dest3 if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F11=(r(mean)) G11=(r(lb)) H10=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci dest3 if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J11=(r(mean)) K11=(r(lb)) L11=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
proportion dest3, over(type)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M11=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify


////////////////////////////////////////////////////////////////////////////////

*Shops

*Prevalence estimates for Shops

egen shops = rowtotal(LU6d  LU6e  LU6g  LU6n  LU7a  LU7b  LU7c)
recode shops (5/max=5)
recode shops (1/2=1) (3/4=2) (5=3)
tab shops, gen(shops)


** shops1 = 0 Shops
** shops2 = 1-2 Shops
** shops3 = 3-4 Shops
** shops4 = >5 Shops

*Overall
ci shops1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel A13=("Shops")
putexcel A14=("0")
putexcel B14=(r(mean)) C14=(r(lb)) D14=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Residential
ci shops1 if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F14=(r(mean)) G14=(r(lb)) H14=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci shops1 if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J14=(r(mean)) K14=(r(lb)) L14=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
proportion shops1, over(type)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M14=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Overall
ci shops2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel A15=("1-2")
putexcel B15=(r(mean)) C15=(r(lb)) D15=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Residential
ci shops2 if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F15=(r(mean)) G15=(r(lb)) H15=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci shops2 if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J15=(r(mean)) K15=(r(lb)) L15=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
proportion shops2, over(type)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M15=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify


*Overall
ci shops3 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel A16=("3-4")
putexcel B16=(r(mean)) C16=(r(lb)) D16=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Residential
ci shops3 if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F16=(r(mean)) G16=(r(lb)) H16=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci shops3 if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J16=(r(mean)) K16=(r(lb)) L16=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
proportion shops3, over(type)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M16=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify


*Overall
ci shops4 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel A17=(">5")
putexcel B17=(r(mean)) C17=(r(lb)) D17=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Residential
ci shops4 if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F17=(r(mean)) G17=(r(lb)) H17=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci shops4 if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J17=(r(mean)) K17=(r(lb)) L17=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
proportion shops4, over(type)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M17=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify


////////////////////////////////////////////////////////////////////////////////

*Prevalence estimates for Restaurant and Entertainment

egen resE = rowtotal(LU6a  LU6b  LU6c  LU6f )
recode resE (5/max=5)
recode resE (1/2=1) (3/4=2) (5=3)
tab resE, gen(resE)

** resE1 = 0 Restaurants and Entertainment destinations
** resE2 = 1-2 Restaurants and Entertainment destinations
** resE3 = 3-4 Restaurants and Entertainment destinations
** resE4 = >5 Restaurants and Entertainment destinations

*Overall
ci resE1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel A19=("Restaurants & Entertainment")
putexcel A20=("0")
putexcel B20=(r(mean)) C20=(r(lb)) D20=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Residential
ci resE1 if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F20=(r(mean)) G20=(r(lb)) H20=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci resE1 if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J20=(r(mean)) K20=(r(lb)) L20=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
proportion resE1, over(type)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M20=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Overall
ci resE2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel A21=("1-2")
putexcel B21=(r(mean)) C21=(r(lb)) D21=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Residential
ci resE2 if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F21=(r(mean)) G21=(r(lb)) H21=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci resE2 if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J21=(r(mean)) K21=(r(lb)) L21=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
proportion resE2, over(type)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M21=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify


*Overall
ci resE3 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel A22=("3-4")
putexcel B22=(r(mean)) C22=(r(lb)) D22=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Residential
ci resE3 if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F22=(r(mean)) G22=(r(lb)) H22=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci resE3 if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J22=(r(mean)) K22=(r(lb)) L22=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
proportion resE3, over(type)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M22=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify


*Overall
ci resE4 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel A23=(">5")
putexcel B23=(r(mean)) C23=(r(lb)) D23=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Residential
ci resE4 if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F23=(r(mean)) G23=(r(lb)) H23=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci resE4 if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J23=(r(mean)) K23=(r(lb)) L23=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
proportion resE4, over(type)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M23=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify


////////////////////////////////////////////////////////////////////////////////

*Prevalence estimates for Instiution/Services

egen ins_ser = rowtotal(LU6j  LU6l  LU6m )
recode ins_ser (5/max=5)
recode ins_ser (1/2=1) (3/4=2) (5=3)
tab ins_ser, gen(ins_ser)

** ins_ser1 = 0 Instiution/Services
** ins_ser2 = 1-2 Instiution/Services
** ins_ser3 = 3-4 Instiution/Services
** ins_ser4 = >5 Instiution/Services

*Overall
ci ins_ser1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel A25=("Institution/Services")
putexcel A26=("0")
putexcel B26=(r(mean)) C26=(r(lb)) D26=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Residential
ci ins_ser1 if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F26=(r(mean)) G26=(r(lb)) H26=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci ins_ser1 if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J26=(r(mean)) K26=(r(lb)) L26=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
proportion ins_ser1, over(type)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M26=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Overall
ci ins_ser2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel A27=("1-2")
putexcel B27=(r(mean)) C27=(r(lb)) D27=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Residential
ci ins_ser2 if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F27=(r(mean)) G27=(r(lb)) H27=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci ins_ser2 if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J27=(r(mean)) K27=(r(lb)) L27=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
proportion ins_ser2, over(type)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M27=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify


*Overall
ci ins_ser3 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel A28=("3-4")
putexcel B28=(r(mean)) C28=(r(lb)) D28=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Residential
ci ins_ser3 if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F28=(r(mean)) G28=(r(lb)) H28=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci ins_ser3 if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J28=(r(mean)) K28=(r(lb)) L28=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
proportion ins_ser3, over(type)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M28=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify


*Overall
ci ins_ser4 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel A29=(">5")
putexcel B29=(r(mean)) C29=(r(lb)) D29=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Residential
ci ins_ser4 if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F29=(r(mean)) G29=(r(lb)) H29=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci ins_ser4 if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J29=(r(mean)) K29=(r(lb)) L29=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
proportion ins_ser4, over(type)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M29=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify

////////////////////////////////////////////////////////////////////////////////

*Prevalence estimates for Public Recreation

egen pub_rec = rowtotal(LU6r  LU6t  LU6u  LU6y  LU6z )
recode pub_rec (1/2=1) (3/4=2) 
tab pub_rec, gen(pub_rec)

** pub_rec1 = 0 Public Recreation Destinations
** pub_rec2 = 1-2 Public Recreation Destinations
** pub_rec3 = >3 Public Recreation Destinations

*Overall
ci pub_rec1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel A31=("Public Recreation")
putexcel A32=("0")
putexcel B32=(r(mean)) C32=(r(lb)) D32=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Residential
ci pub_rec1 if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F32=(r(mean)) G32=(r(lb)) H32=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci pub_rec1 if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J32=(r(mean)) K32=(r(lb)) L32=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
proportion pub_rec1, over(type)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M32=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Overall
ci pub_rec2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel A33=("1-2")
putexcel B33=(r(mean)) C33=(r(lb)) D33=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Residential
ci pub_rec2 if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F33=(r(mean)) G33=(r(lb)) H33=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci pub_rec2 if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J33=(r(mean)) K33=(r(lb)) L33=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
proportion pub_rec2, over(type)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M33=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify


*Overall
ci pub_rec3 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel A34=(">3")
putexcel B34=(r(mean)) C34=(r(lb)) D34=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Residential
ci pub_rec3 if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F34=(r(mean)) G34=(r(lb)) H34=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci ins_ser3 if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J34=(r(mean)) K34=(r(lb)) L34=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
proportion pub_rec3, over(type)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M34=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify

////////////////////////////////////////////////////////////////////////////////

*Prevalence estimates for Private Recreation 

egen priv_rec = rowtotal(LU6q LU6s )
recode pub_rec (1/3=1) 
tab priv_rec, gen(priv_rec)

** priv_rec1 = 0 Private Recreation Destinations
** priv_rec2 = >1 Private Recreation Destinations

*Overall
ci priv_rec1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel A36=("Private Recreation")
putexcel A37=("0")
putexcel B37=(r(mean)) C37=(r(lb)) D37=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Residential
ci priv_rec1 if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F37=(r(mean)) G37=(r(lb)) H37=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci priv_rec1 if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J37=(r(mean)) K37=(r(lb)) L37=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
proportion priv_rec1, over(type)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M37=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Overall
ci priv_rec2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel A38=(">1")
putexcel B38=(r(mean)) C38=(r(lb)) D38=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Residential
ci priv_rec2 if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F38=(r(mean)) G38=(r(lb)) H38=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci priv_rec2 if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J38=(r(mean)) K38=(r(lb)) L38=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
proportion priv_rec2, over(type)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M38=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

*STREETSCAPE


*Presence of at least 1 bus stop
preserve
tab SS1a
recode SS1a (1/max=1)

*SS1a = Numbero of transit bus stops

*Overall
ci SS1a , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel A40=("Streetscape")
putexcel A41=("Presence of at least 1 bus stop")
putexcel B41=(r(mean)) C41=(r(lb)) D41=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Residential
ci SS1a if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F41=(r(mean)) G41=(r(lb)) H41=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci SS1a if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J41=(r(mean)) K41=(r(lb)) L41=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
proportion SS1a, over(type)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M41=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify

restore
////////////////////////////////////////////////////////////////////////////////


*Traffic Calming - at least 1 traffic calming feature

preserve
recode SS4a (1/max=1)
tab SS4a, gen(SS4a)

*SS4a1 = No traffic calming feature
*SS4a2 = Presence of at least 1 traffic calming feature

*Overall
ci SS4a1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel A42=("Traffic calming feature")
putexcel A43=("No traffic calming feature")
putexcel B43=(r(mean)) C43=(r(lb)) D43=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Residential
ci SS4a1 if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F43=(r(mean)) G43=(r(lb)) H43=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci SS4a1 if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J43=(r(mean)) K43=(r(lb)) L43=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
proportion SS4a1, over(type)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M43=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify


*Overall
ci SS4a2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel A44=("Presence of traffic calming feature")
putexcel B44=(r(mean)) C44=(r(lb)) D44=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Residential
ci SS4a2 if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F44=(r(mean)) G44=(r(lb)) H44=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci SS4a2 if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J44=(r(mean)) K44=(r(lb)) L44=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
proportion SS4a2, over(type)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M44=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify

restore
////////////////////////////////////////////////////////////////////////////////

*Presence of Pedestrian Crossing

preserve
recode SS8 (1/max=1)
tab SS8, gen(SS8a)

*SS8a1 = No Pedestrian Crossing
*SS8a2 = Presence of Pedestrian Crossing

*Overall
ci SS8a1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel A46=("Pedestrian Crossing")
putexcel A47=("No pedestrian crossing")
putexcel B47=(r(mean)) C47=(r(lb)) D47=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Residential
ci SS8a1 if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F47=(r(mean)) G47=(r(lb)) H47=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci SS8a1 if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J47=(r(mean)) K47=(r(lb)) L47=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
proportion SS8a1, over(type)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M47=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify


*Overall
ci SS8a2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel A48=("Presence of pedestrian crossing")
putexcel B48=(r(mean)) C48=(r(lb)) D48=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Residential
ci SS8a2 if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F48=(r(mean)) G48=(r(lb)) H48=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci SS8a2 if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J48=(r(mean)) K48=(r(lb)) L48=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
proportion SS8a2, over(type)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M48=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify

restore
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

*AESETHICS

*Presence of Hardscape Features

*Overall
ci A1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel A50=("Aesethics")
putexcel A51=("Presence of Hardscape Features")
putexcel B51=(r(mean)) C51=(r(lb)) D51=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Residential
ci A1 if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F51=(r(mean)) G51=(r(lb)) H51=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci A1 if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J51=(r(mean)) K51=(r(lb)) L51=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
proportion A1, over(type)
test [Yes] :Residential = [Yes] :Commercial
putexcel M51=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify

////////////////////////////////////////////////////////////////////////////////

*Presence of Softscape Features

*Overall
ci A2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel A52=("Presence of Softscape Features")
putexcel B52=(r(mean)) C52=(r(lb)) D52=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Residential
ci A2 if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F52=(r(mean)) G52=(r(lb)) H52=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci A2 if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J52=(r(mean)) K52=(r(lb)) L52=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
proportion A2, over(type)
test [Yes] :Residential = [Yes] :Commercial
putexcel M52=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify

////////////////////////////////////////////////////////////////////////////////

*Building Maintaince (50-99%)

preserve 
recode A4 (1=0) (2=1)

*Overall
ci A4 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel A53=("Maintaince (50-99%)")
putexcel A54=("Building Maintaince")
putexcel B54=(r(mean)) C54=(r(lb)) D54=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Residential
ci A4 if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F54=(r(mean)) G54=(r(lb)) H54=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci A4 if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J54=(r(mean)) K54=(r(lb)) L54=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
proportion A4, over(type)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M54=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify

restore

////////////////////////////////////////////////////////////////////////////////

*Outdoor Maintaince (50-99%)

preserve
recode A5 (1=0) (2=1)

*Overall
ci A5 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel A55=("Outdoor Maintaince")
putexcel B55=(r(mean)) C55=(r(lb)) D55=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Residential
ci A5 if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F55=(r(mean)) G55=(r(lb)) H55=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci A5 if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J55=(r(mean)) K55=(r(lb)) L55=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
proportion A5, over(type)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M55=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify

restore

////////////////////////////////////////////////////////////////////////////////

*Presence of Graffti

*Overall
ci A6a , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel A56=("Presence of Graffti")
putexcel B56=(r(mean)) C56=(r(lb)) D56=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Residential
ci A6a if type==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel F56=(r(mean)) G56=(r(lb)) H56=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Commerical
ci A6a if type==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Route") modify
putexcel J56=(r(mean)) K56=(r(lb)) L56=(r(ub)) using "Prevalence estimates.xlsx", sheet("Route") modify

*Wald test for differences in proportions between residential and commercial
proportion A6a, over(type)
test [Yes] :Residential = [Yes] :Commercial
putexcel M56=(r(p)) using "Prevalence estimates.xlsx", sheet("Route") modify



////////////////////////////////////////////////////////////////////////////////















