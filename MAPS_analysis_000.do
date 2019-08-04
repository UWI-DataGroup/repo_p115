clear
capture log close
cls

**  GENERAL DO-FILE COMMENTS
**  program:		MAPS_analysis_000.do
**  project:      	Microscale Auidt of Pedestrian Streetscapes of UNESCO Hertiage Site Barbados
**  author:			Rocke, Whiteman, Hambleton, Howitt
**  task:          	Overall Audit Descriptives
**	Date Modified:	03/08/2019


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
	3) MAPS_prep_003.do
	
*/


use "MAPS Recoding Scoring.dta", clear

**Overall Descriptives

*Time taken to conduct audit
mean time_diff, cformat(%tcHH:MM)

*Recoding mixed into commercial
recode type (3=2)
recode type_segment (3=2)

* Frequencies for type of routes, segments and crossings

*Route
tab type

*Segment
tab type_segment

*Crossing
recode type_crossing (1=.) (2=.) if instrument_type==1
recode type_crossing (1=.) (2=.) if instrument_type==2
tab type_crossing

*Number of segments per route
preserve
collapse (count) type_segment, by(record_id)
sum type_segment
restore

*Number of crossings per route
preserve
collapse (count) type_crossing, by(record_id)
sum type_crossing
restore

*Internal Consistency - Cronh Alpha
use "MAPS Overall", clear
alpha Res_Density_Mix_recode - C1_7c
