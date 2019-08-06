
cls
capture log close
cd "/Users/kernrocke/Documents/Statistical Data Anlaysis/2019/Walkability/MAPS/Data"
log using "Log files/Data Preparation/MAPS_analysis_001", replace

**  GENERAL DO-FILE COMMENTS
**  program:		MAPS_analysis_002.do
**  project:      	Microscale Auidt of Pedestrian Streetscapes of UNESCO Hertiage Site Barbados
**  author:			Rocke, Whiteman, Hambleton, Howitt
**  task:          	Prevalence Estimates of key attributes from Segment section of MAPS
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

*Keeping all street segment data
keep if instrument_type==2

*Recoding mixed to commercial
recode type_segment (3=2)

tab type_segment

////////////////////////////////////////////////////////////////////////////////
*SIDEWALK

tab S1_1, gen(S1_1a)

*Prevalence estimates for no sidewalk
ci S1_1a1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel B6=("Overall")
putexcel A8=("No sidewalk")
putexcel B7=("Prevalence")
putexcel C7=("Lower Bound CI")
putexcel D7=("Upper Bound CI")
putexcel B8=(r(mean)) C8=(r(lb)) D8=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Residential
ci S1_1a1 if type_segment==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel F6=("Residential")
putexcel F7=("Prevalence")
putexcel G7=("Lower Bound CI")
putexcel H7=("Upper Bound CI")
putexcel F8=(r(mean)) G8=(r(lb)) H8=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Commerical
ci S1_1a1 if type_segment==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel J6=("Commerical")
putexcel J7=("Prevalence")
putexcel K7=("Lower Bound CI")
putexcel L7=("Upper Bound CI")
putexcel J8=(r(mean)) K8=(r(lb)) L8=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Wald test for differences in proportions between residential and commercial
putexcel M7=("p-value")
proportion S1_1a1, over(type_segment)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M8=(r(p)) using "Prevalence estimates.xlsx", sheet("Segment") modify



*Prevalence estimates for sidewalk present
ci S1_1a2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel A9=("Sidewalk Present")
putexcel B9=(r(mean)) C9=(r(lb)) D9=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Residential
ci S1_1a2 if type_segment==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel F9=(r(mean)) G9=(r(lb)) H9=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Commerical
ci S1_1a2 if type_segment==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel J9=(r(mean)) K9=(r(lb)) L9=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Wald test for differences in proportions between residential and commercial
proportion S1_1a2, over(type_segment)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M9=(r(p)) using "Prevalence estimates.xlsx", sheet("Segment") modify



////////////////////////////////////////////////////////////////////////////////
*WIDTH OF SIDEWALK

tab S1_2, gen(S1_2a)

*Prevalence estimates for <3 feet 
ci S1_2a2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel A11=("Sidewalk width")
putexcel A12=("< 3 ft")
putexcel B12=(r(mean)) C12=(r(lb)) D12=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Residential
ci S1_2a2 if type_segment==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel F12=(r(mean)) G12=(r(lb)) H12=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Commerical
ci S1_2a2 if type_segment==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel J12=(r(mean)) K12=(r(lb)) L12=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Wald test for differences in proportions between residential and commercial
proportion S1_2a2, over(type_segment)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M12=(r(p)) using "Prevalence estimates.xlsx", sheet("Segment") modify


*Prevalence estimates for 3-5 feet 
ci S1_2a3 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel A13=("3-5 ft")
putexcel B13=(r(mean)) C13=(r(lb)) D13=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Residential
ci S1_2a3 if type_segment==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel F13=(r(mean)) G13=(r(lb)) H13=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Commerical
ci S1_2a3 if type_segment==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel J13=(r(mean)) K13=(r(lb)) L13=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Wald test for differences in proportions between residential and commercial
proportion S1_2a3, over(type_segment)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M13=(r(p)) using "Prevalence estimates.xlsx", sheet("Segment") modify



*Prevalence estimates for >5 feet 
ci S1_2a4 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel A14=(">5 ft")
putexcel B14=(r(mean)) C14=(r(lb)) D14=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Residential
ci S1_2a4 if type_segment==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel F14=(r(mean)) G14=(r(lb)) H14=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Commerical
ci S1_2a4 if type_segment==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel J14=(r(mean)) K14=(r(lb)) L14=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Wald test for differences in proportions between residential and commercial
proportion S1_2a4, over(type_segment)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M14=(r(p)) using "Prevalence estimates.xlsx", sheet("Segment") modify


////////////////////////////////////////////////////////////////////////////////
 *PRESENCE OF BUFFER
 
 /*
 NOTE: No table will be produced for presence of buffer due to the fact that 
 only 2.41% of segments had a buffer present
 */
 
 ////////////////////////////////////////////////////////////////////////////////
*SIDEWALK CONTINUINITY

/*
 NOTE: No table will be produced for sidewalk discontinuous (change of surface) due to the fact that 
 only 1.81% of segments had this problem.
 */

 
 *Prevalence sidewalk continunity
ci S1_4b , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel A16=("Sidewalk Continuinity")
putexcel A17=("Sidewalk continuous")
putexcel B17=(r(mean)) C17=(r(lb)) D17=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Residential
ci S1_4b if type_segment==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel F17=(r(mean)) G17=(r(lb)) H17=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Commerical
ci S1_4b if type_segment==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel J17=(r(mean)) K17=(r(lb)) L17=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Wald test for differences in proportions between residential and commercial
proportion S1_4b, over(type_segment)
test [Checked] :Residential = [Checked] :Commercial
putexcel M17=(r(p)) using "Prevalence estimates.xlsx", sheet("Segment") modify


 *Prevalence sidewalk interupted by driveway
ci S1_4c , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel A18=("Sidewalk interupted by driveway")
putexcel B18=(r(mean)) C18=(r(lb)) D18=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Residential
ci S1_4c if type_segment==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel F18=(r(mean)) G18=(r(lb)) H18=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Commerical
ci S1_4c if type_segment==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel J18=(r(mean)) K18=(r(lb)) L18=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Wald test for differences in proportions between residential and commercial
proportion S1_4c, over(type_segment)
test [Checked] :Residential = [Checked] :Commercial
putexcel M18=(r(p)) using "Prevalence estimates.xlsx", sheet("Segment") modify


 *Prevalence sidewalk interupted (Have to walk in street)
ci S1_4d , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel A19=("Sidewalk interupted (Have to walk in street)")
putexcel B19=(r(mean)) C19=(r(lb)) D19=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Residential
ci S1_4d if type_segment==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel F19=(r(mean)) G19=(r(lb)) H19=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Commerical
ci S1_4d if type_segment==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel J19=(r(mean)) K19=(r(lb)) L19=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Wald test for differences in proportions between residential and commercial
proportion S1_4d, over(type_segment)
test [Checked] :Residential = [Checked] :Commercial
putexcel M19=(r(p)) using "Prevalence estimates.xlsx", sheet("Segment") modify


////////////////////////////////////////////////////////////////////////////////
*POORLY MAINTAINED SECTIONS ON SIDEWALK

preserve
recode S1_5b (0=.) (1=0) (2/max=1)
recode S1_5c (0=.) (1=0) (2/max=1)
egen hazards = rowtotal(S1_5b S1_5c)
recode hazards (1/max=1)

tab hazards, gen(hazards_)

 *Prevalence no sidewalk hazards
ci hazards_1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel A21=("Sidewalk Hazards")
putexcel A22=("No Hazards")
putexcel B22=(r(mean)) C22=(r(lb)) D22=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Residential
ci hazards_1 if type_segment==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel F22=(r(mean)) G22=(r(lb)) H22=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Commerical
ci hazards_1 if type_segment==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel J22=(r(mean)) K22=(r(lb)) L22=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Wald test for differences in proportions between residential and commercial
proportion hazards_1, over(type_segment)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M22=(r(p)) using "Prevalence estimates.xlsx", sheet("Segment") modify


 *Prevalence of at least 1 sidewalk hazards
ci hazards_2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel A23=("Hazards Present")
putexcel B23=(r(mean)) C23=(r(lb)) D23=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Residential
ci hazards_2 if type_segment==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel F23=(r(mean)) G23=(r(lb)) H23=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Commerical
ci hazards_2 if type_segment==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel J23=(r(mean)) K23=(r(lb)) L23=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify


*Wald test for differences in proportions between residential and commercial
proportion hazards_2, over(type_segment)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M23=(r(p)) using "Prevalence estimates.xlsx", sheet("Segment") modify

restore

////////////////////////////////////////////////////////////////////////////////
*TREE COVERAGE

gen trees = S1_25
recode trees (5=.) (1/4=1)

tab trees, gen (tree_)
 
 *Prevalence of no tree coverage
ci tree_1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel A25=("Tree Coverage")
putexcel A26=("No Coverage")
putexcel B26=(r(mean)) C26=(r(lb)) D26=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Residential
ci tree_1 if type_segment==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel F26=(r(mean)) G26=(r(lb)) H26=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Commerical
ci tree_1 if type_segment==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel J26=(r(mean)) K26=(r(lb)) L26=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Wald test for differences in proportions between residential and commercial
proportion tree_1, over(type_segment)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M26=(r(p)) using "Prevalence estimates.xlsx", sheet("Segment") modify


 *Prevalence of tree coverage
ci tree_2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel A27=("Coverage")
putexcel B27=(r(mean)) C27=(r(lb)) D27=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Residential
ci tree_2 if type_segment==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel F27=(r(mean)) G27=(r(lb)) H27=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Commerical
ci tree_2 if type_segment==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel J27=(r(mean)) K27=(r(lb)) L27=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Wald test for differences in proportions between residential and commercial
proportion tree_2, over(type_segment)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M27=(r(p)) using "Prevalence estimates.xlsx", sheet("Segment") modify

////////////////////////////////////////////////////////////////////////////////
*SMALLEST BUILDING SETBACK

preserve
recode S1_26 (0=.) (3=2)

tab S1_26, gen(S1_26_)

 *Prevalence of < 10 feet
ci S1_26_1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel A29=("Smallest Building Setback")
putexcel A30=("<10 feet")
putexcel B30=(r(mean)) C30=(r(lb)) D30=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Residential
ci S1_26_1 if type_segment==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel F30=(r(mean)) G30=(r(lb)) H30=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Commerical
ci S1_26_1 if type_segment==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel J30=(r(mean)) K30=(r(lb)) L30=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Wald test for differences in proportions between residential and commercial
proportion S1_26_1, over(type_segment)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M30=(r(p)) using "Prevalence estimates.xlsx", sheet("Segment") modify


 *Prevalence of >10 feet
ci S1_26_2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel A31=(">10 feet")
putexcel B31=(r(mean)) C31=(r(lb)) D31=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Residential
ci S1_26_2 if type_segment==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel F31=(r(mean)) G31=(r(lb)) H31=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Commerical
ci S1_26_2 if type_segment==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel J31=(r(mean)) K31=(r(lb)) L31=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Wald test for differences in proportions between residential and commercial
proportion S1_26_2, over(type_segment)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M31=(r(p)) using "Prevalence estimates.xlsx", sheet("Segment") modify


////////////////////////////////////////////////////////////////////////////////
*LARGEST BUILDING SETBACK

recode S1_27 (0=.)
tab S1_27, gen(S1_27_)


 *Prevalence of <10 feet
ci S1_27_1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel A33=("Largest Building Setback")
putexcel A34=("<10 feet")
putexcel B34=(r(mean)) C34=(r(lb)) D34=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Residential
ci S1_27_1 if type_segment==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel F34=(r(mean)) G34=(r(lb)) H34=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Commerical
ci S1_27_1 if type_segment==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel J34=(r(mean)) K34=(r(lb)) L34=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Wald test for differences in proportions between residential and commercial
proportion S1_27_1, over(type_segment)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M34=(r(p)) using "Prevalence estimates.xlsx", sheet("Segment") modify


 *Prevalence of 10-20 feet
ci S1_27_2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel A35=("10-20 feet")
putexcel B35=(r(mean)) C35=(r(lb)) D35=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Residential
ci S1_27_2 if type_segment==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel F35=(r(mean)) G35=(r(lb)) H35=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Commerical
ci S1_27_2 if type_segment==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel J35=(r(mean)) K35=(r(lb)) L35=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Wald test for differences in proportions between residential and commercial
proportion S1_27_2, over(type_segment)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M35=(r(p)) using "Prevalence estimates.xlsx", sheet("Segment") modify


*Prevalence of 10-20 feet
ci S1_27_3 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel A36=(">20 feet")
putexcel B36=(r(mean)) C36=(r(lb)) D36=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Residential
ci S1_27_3 if type_segment==1 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel F36=(r(mean)) G36=(r(lb)) H36=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Commerical
ci S1_27_3 if type_segment==2 , binomial
putexcel set "Prevalence estimates.xlsx", sheet("Segment") modify
putexcel J36=(r(mean)) K36=(r(lb)) L36=(r(ub)) using "Prevalence estimates.xlsx", sheet("Segment") modify

*Wald test for differences in proportions between residential and commercial
proportion S1_27_3, over(type_segment)
test [_prop_2] :Residential = [_prop_2] :Commercial
putexcel M36=(r(p)) using "Prevalence estimates.xlsx", sheet("Segment") modify

////////////////////////////////////////////////////////////////////////////////
restore














