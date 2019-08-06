** CLOSE ANY OPEN LOG FILE AND OPEN A NEW LOG FILE
capture log close
cd "/Users/kernrocke/Documents/Statistical Data Anlaysis/2019/Walkability/MAPS/Data"
log using "Log files/Data Preparation/MAPS_prep_002", replace

**  GENERAL DO-FILE COMMENTS
**  program:		MAPS_prep_002.do
**  project:      	Microscale Auidt of Pedestrian Streetscapes of UNESCO Hertiage Site Barbados
**  author:			Rocke, Whiteman, Hambleton, Howitt
**  task:          	Creation of MAPS scores and subscales 
**	Date Modified:	25/07/2019



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
	
*/


use "MAPS_cleaned", clear

********************************************************************************

//Route 

********************************************************************************

//Route: Destinations and Land Use

//Residential Density Subscale

gen ResMix = .
replace ResMix = 4 if LU3a==1
replace ResMix = 1 if LU3d==1
replace ResMix = 2 if LU3c==1
replace ResMix = 3 if LU3b==1
replace ResMix = 0 if LU3e==1
label var ResMix "Residential Mix"
label define ResMix 0"None" 1"Apartment over retail only" 2"Apartments or multifamily only" 3"Mixed or other" 4"Single family only"
label value ResMix ResMix

gen Res_Density_Mix_recode= .
replace Res_Density_Mix_recode = 0 if type==2
replace Res_Density_Mix_recode = 1 if LU3a==1
replace Res_Density_Mix_recode = 2 if LU3b==1 | LU3c==1
replace Res_Density_Mix_recode = 3 if LU3d==1
label var Res_Density_Mix_recode "Residential density mix recoded (points)"
label define Res_Density_Mix_recode 0"Commercial" 1"Single Family" 2"Multi-Family only and any other mix" 3"Apartments over retail only"
label value Res_Density_Mix_recode Res_Density_Mix_recode


//Shops Subscale
gen Shops = LU6d + LU6e + LU6g + LU6n + LU7a + LU7b + LU7c
label var Shops "Shops Subscale Score"


*Consider the following: Grocery/Supermarket, Convience Store, Bakery, Age-restricted bar, rum shop, Other retial

//Restaurant and Entertainment Subscale
gen Restaur_Ent = LU6a + LU6b + LU6c + LU6f 
label var Restaur_Ent "Restaurant and Entertainment Subscale"


//Institutional/Services Subscale

gen Institu_Svc = LU6j + LU6l + LU6m
label var Institu_Svc "Institutional/Services Subscale"

//Public Recreation

gen Public_Rec = LU6r + LU6t + LU6u + LU6y + LU6z
label var Public_Rec "Public Recreation"

//Private Recreation

gen Private_Rec = LU6q + LU6s
label var Private_Rec "Private Recreation"

//Destinations and Land Use: Subscales

gen DLU_pos = Res_Density_Mix_recode + Shops + Restaur_Ent + Institu_Svc + LU6o + LU6p + Public_Rec + Private_Rec
label var DLU_pos "Destinations and Land Use: Positive subscale"

gen DLU_Neg = LU6g + LU6h
label var DLU_Neg "Destinations and Land Use: Negative subscale"

gen DLU_Overall = DLU_pos - DLU_Neg
label var DLU_Overall "Overall Destinations and Land Use Scale"

********************************************************************************

//Route: Streetscape

//Positive Streetscape

gen Transit_tally = SS1a + SS2_1b + SS2_1c
label var Transit_tally "Transit stop that includes amenities (bench, shelter)"

gen Transit_tally_trichot = SS1a
recode Transit_tally_trichot (3/4=2)
label var Transit_tally_trichot "Transit stop tally, Trichotomized"

recode SS4a (.=0)
gen SS4a_dichot = SS4a
recode SS4a_dichot (2/max=1)
label var SS4a_dichot "What other street characteristics are present"

gen SS5_dichot = SS5
recode SS5_dichot (2/max=1)
label var SS5_dichot "Are street lights installed? Dichotomized"

gen SS6_dichot = SS6
recode SS6_dichot (1/max=1)
label var SS6_dichot "How many driveways or alleys are there? Dichotomized"

gen SS8_dichot = SS8
recode SS8_dichot (2/max=1)
label var SS8_dichot "How many pedestrian crossing are there? Dichotomized"

//Positive Streetscape Subscale

gen Pos_Streetscape = Transit_tally_trichot + SS4a_dichot + SS5_dichot + SS6_dichot + SS7a + SS7b + SS7c + SS7d + SS6_dichot + SS9a + SS9b + SS9c
label var Pos_Streetscape "Positive Streetscape subscale"


********************************************************************************

//Route: Aesthetics and Social

//Positive Aesthetics and Social Elements

gen A5_dichot = A5
recode A5_dichot (1=0) (2=1)
label var A5_dichot "Is the landscape well maintained? Dichotomized"

//Positive Aesthetics and Social Subscale

gen Pos_AesthSoc = A1 + A2 + A5_dichot
label var Pos_AesthSoc "Positive Aesthetics and Social Subscale"

//Negative Aesthetics and Social Elements


gen A4_dichot_neg = A4
recode A4_dichot (2=1) 
label var A4_dichot_neg "Negative Aesthetics and Social Elements"

gen A7_dichot = A7
label var A7_dichot "Rate the extent of physical disorder. Dichotomized"

//Negative Aesthetics and Social Subscale

gen Neg_AesthSoc = A4_dichot_neg + A6a + A7_dichot
label var Neg_AesthSoc "Negative Aesthetics and Social Subscale"

//Overall Aesthetics and Social Subscale

gen AesthSoc_Overall = Pos_AesthSoc - Neg_AesthSoc 
label var AesthSoc_Overall "Overall Aesthetics and Social Subscale"



//Route Overall Score

gen Route_Overall = DLU_Overall + Pos_Streetscape + AesthSoc_Overall
label var Route_Overall "Route Overall Score"


********************************************************************************

//Segments 

********************************************************************************

//Positive Setback and Building Height

gen S1_26_recode = S1_26
recode S1_26_recode (0=1) (1=2) (2=3) (3=4) (4=5) (5=6)
label var S1_26_recode "Smallest Building Setback Recoded"

gen S1_27_recode = S1_27
recode S1_27_recode (0=1) (1=2) (2=3) (3=4) (4=5) (5=6)
label var S1_27_recode "Largest Building Setback Recoded"

gen S1_26_27_0pts = .
replace S1_26_27_0pts = 1 if S1_26_recode==1 | S1_27_recode==1
replace S1_26_27_0pts = 0 if S1_26_recode==2 | S1_27_recode==2
replace S1_26_27_0pts = 0 if S1_26_recode==3 | S1_27_recode==3
replace S1_26_27_0pts = 0 if S1_26_recode==4 | S1_27_recode==4
replace S1_26_27_0pts = 1 if S1_26_recode==5 | S1_27_recode==5
replace S1_26_27_0pts = 1 if S1_26_recode==6 | S1_27_recode==6
label var S1_26_27_0pts "Either setback >50ft and no building"
label define S1_26_27_0pts 0"No" 1"Yes"
label value S1_26_27_0pts S1_26_27_0pts 

gen S1_26_27_1point = .
replace S1_26_27_1point = 0 if S1_26_recode==1 | S1_27_recode==1
replace S1_26_27_1point = 0 if S1_26_recode==2 | S1_27_recode==2
replace S1_26_27_1point = 0 if S1_26_recode==3 | S1_27_recode==3
replace S1_26_27_1point = 1 if S1_26_recode==4 | S1_27_recode==4
replace S1_26_27_1point = 0 if S1_26_recode==5 | S1_27_recode==5
replace S1_26_27_1point = 0 if S1_26_recode==6 | S1_27_recode==6
label var S1_26_27_1point "Either setback >21-50ft"
label define S1_26_27_1point 0"No" 1"Yes"
label value S1_26_27_1point S1_26_27_1point 

gen S1_26_27_2points = .
replace S1_26_27_2points = 0 if S1_26_recode==1  
replace S1_26_27_2points = 0 if S1_26_recode==2  
replace S1_26_27_2points = 0 if S1_26_recode==4  
replace S1_26_27_2points = 0 if S1_26_recode==5  
replace S1_26_27_2points = 0 if S1_26_recode==6  
replace S1_26_27_2points = 0 if S1_27_recode==1  
replace S1_26_27_2points = 0 if S1_27_recode==2 
replace S1_26_27_2points = 0 if S1_27_recode==4  
replace S1_26_27_2points = 0 if S1_27_recode==5  
replace S1_26_27_2points = 0 if S1_27_recode==6 
replace S1_26_27_2points = 2 if S1_26_recode==3 & S1_27_recode==3
replace S1_26_27_2points = 2 if S1_26_recode==2 & S1_27_recode==3
label var S1_26_27_2points "Both setbacks >10-20ft or one setback <10ft and one setback 10-20ft"
label define S1_26_27_2points 0"No" 2"Yes"
label value S1_26_27_2points S1_26_27_2points

gen S1_26_27_3points = .
replace S1_26_27_3points = 0 if S1_26_recode==1  
replace S1_26_27_3points = 0 if S1_26_recode==3  
replace S1_26_27_3points = 0 if S1_26_recode==4  
replace S1_26_27_3points = 0 if S1_26_recode==5  
replace S1_26_27_3points = 0 if S1_26_recode==6  
replace S1_26_27_3points = 0 if S1_27_recode==1  
replace S1_26_27_3points = 0 if S1_27_recode==3 
replace S1_26_27_3points = 0 if S1_27_recode==4  
replace S1_26_27_3points = 0 if S1_27_recode==5  
replace S1_26_27_3points = 0 if S1_27_recode==6 
replace S1_26_27_3points = 3 if S1_26_recode==2 & S1_27_recode==2
label var S1_26_27_3points "Both setbacks <10ft"
label define S1_26_27_3points 0"No" 3"Yes"
label value S1_26_27_3points S1_26_27_3points

gen S1_26_27_points = S1_26_27_0pts + S1_26_27_1point + S1_26_27_2points + S1_26_27_3points
label var S1_26_27_points "Smallest and largest setback scores combined"

gen S1_28_trichot = S1_28
label var S1_28_trichot "What is the average of buildings? Trichotomized"


//Positive Buildings Height and Setbacks Subscale

gen PosBldgHtSetbks_S1 = S1_26_27_points + S1_28_trichot
label var PosBldgHtSetbks_S1 "Positive Setbacks/Bldg. Height: Positive subscale"


//Sidewalk subscale

gen S1_1_recode = S1_1
recode S1_1_recode (1=2)
label define S1_1_recode 0"No" 1"Yes"
label value S1_1_recode S1_1_recode
label var S1_1_recode "Is a sidewalk present? Recoded"

gen S1_2_recode = S1_2
recode S1_2_recode (1=2)
label define S1_2_recode 0"No sidewalk" 2"<3 feet; 3-5 feet" 3">5 feet"
label value S1_2_recode S1_2_recode
label var S1_2_recode "What is the width of the majority of the sidewalk? Recoded"

gen S1_4_recode = S1_4b
label define S1_4_recode 0"No" 1"Yes"
label value S1_4_recode S1_4_recode
label var S1_4_recode "Is the sidewalk continuous within the segment? Recoded"

gen S1_5b_dichot = .
replace S1_5b_dichot = 0 if S1_5b==0 | S1_5c==0
replace S1_5b_dichot = 0 if S1_5b==1 | S1_5c==1
replace S1_5b_dichot = 0 if S1_5b==2 | S1_5c==2
replace S1_5b_dichot = 1 if S1_5b==3 | S1_5c==3
replace S1_5b_dichot = 1 if S1_5b==4 | S1_5c==4
label define S1_5b_dichot 0"0-1" 1"A few or alot"
label value S1_5b_dichot S1_5b_dichot
label var S1_5b_dichot "Are there poorly maintained sections of the sidewalk that constitue trip hazards? Dichotomized"

gen Sidewalk_S1 = S1_1_recode + S1_2_recode + S1_4_recode + S1_5b_dichot
label var Sidewalk_S1 "Sidewalk subscale"


//Positive Buffer Subscale

gen Buffers_Pos_S1 = S1_3a
label define Buffers_Pos_S1 0"No" 1"Yes"
label value Buffers_Pos_S1 Buffers_Pos_S1
label var Buffers_Pos_S1 "Buffers: Positive Subscale"

//Positive Bike Infrastructure

gen S1_14_recode = S1_14
label var S1_14_recode "Is there a marked bicycle lane marked with a line or a raised curb?"

//Bike Infrastructure Positive Subscale

gen Bike_Infra_S1 = S1_14_recode 
label var Bike_Infra_S1 "Bike Infrastructure: Positive subscale"

//Trees Positive

gen S1_23_trichot = S1_23
recode S1_23_trichot (1=0) (2=1) (3/max=2)
label define S1_23_trichot 0"No sidewalk; N/A; 0-1 trees" 1"2-10 trees" 2">11 trees"
label value S1_23_trichot S1_23_trichot
label var S1_23_trichot "How many trees exist within 5 feet of either side of the sidewalk/pathway? Trichotomized"

gen S1_24_recode = S1_24
recode S1_24_recode (2=0)
label define S1_24_recode 0"N/A; Irregularly spaced" 1"Evenly Spaced"
label value S1_24_recode S1_24_recode
label var S1_24_recode "How are the trees generally spaced? Recoded"

gen S1_25_trichot = S1_25
recode S1_25_trichot (1=0) (5=0) (2/3=1) (4=2)
label define S1_25_trichot 0"No coverage or no sidewalk; N/A" 1"26%-75%" 2">75%"
label value S1_25_trichot S1_25_trichot
label var S1_25_trichot "What percentage of sidewalk/walkway is covered by trees/other overhead coverage? Trichotomized"


//Trees Positive Subscale

gen Trees_S1 = S1_23_trichot + S1_24_recode + S1_25_trichot
label var Trees_S1 "Trees: Positive subscale"

//Informal Path or Shortcut Positive (single item, not a subscale)

gen S1_17 = S1_17a + S1_17b
label define S1_17 0"No" 1"Yes"
label value S1_17 S1_17
label var S1_17 "Is there an informal path (shortcut), not on a cul-de-sac which connects to something else?"

//Building Height to Road Width Ratio Subscale

gen S1_28_feet = S1_28
recode S1_28_feet (1=18) (2=48) (3=96) (4=144)
label var S1_28_feet "Average building height - recalculated in feet"

gen RdWdth = S1_10
recode RdWdth (1=12) (2=24) (3=36) (4=48)
label var RdWdth "Road Width in Ft"

gen S1_26_feet = S1_26
recode S1_26_feet (1=5) (2=15) (3=35) (4=75) (5=100)
label var S1_26_feet "Smallest Building Setback from the sidewalk in Ft - midpoint"

gen S1_27_feet = S1_27
recode S1_27_feet (1=5) (2=15) (3=35) (4=75) (5=100)
label var S1_27_feet "Largest Building Setback from the sidewalk in Ft - midpoint"

gen Setbk_avg_S1 = (S1_26_feet + S1_27_feet)/2
label var Setbk_avg_S1 "Average smallest and largest Building Setback"

gen BldgHt_RdWdthSetbk_Ratio_S1 = S1_28_feet / (RdWdth + Setbk_avg_S1)
label var BldgHt_RdWdthSetbk_Ratio_S1 "Building Height: Road Width+Setback Avgs. Ratio"

gen BldgHt_RdWdthSetbk_Ratio_Scores = BldgHt_RdWdthSetbk_Ratio_S1
recode BldgHt_RdWdthSetbk_Ratio_Scores (min/0.49999=0) (0.50/0.99999=1) (1.0/1.99999=3) (2.0/2.99999=2) (3.0/max=1)
label define BldgHt_RdWdthSetbk_Ratio_Scores 0"Lowest - 0.499" 1"0.50 - 0.999; 3.0 - Highest" 2"2.0 - 2.999" 3"1.0 - 1.999"
label value BldgHt_RdWdthSetbk_Ratio_Scores BldgHt_RdWdthSetbk_Ratio_Scores
label var BldgHt_RdWdthSetbk_Ratio_Scores "Scores for the ratio"

//Road Width

gen S1_10_dichot = S1_10
recode S1_10_dichot (1/2=1) (3/4=2)
label define S1_10_dichot 1"1-2 lanes" 2"3-4 lanes"
label value S1_10_dichot S1_10_dichot
label var S1_10_dichot "Road Width"
rename S1_10_dichot Road_Width_S1

//Positive Segements Subscale

gen Segments_Pos_S1 = PosBldgHtSetbks_S1 + Sidewalk_S1 + Buffers_Pos_S1 + Bike_Infra_S1 + Trees_S1 + S1_17 + BldgHt_RdWdthSetbk_Ratio_Scores
label var Segments_Pos_S1 "Sum of positive segments subscales"

//Negative Segement

gen S1_3_negative = S1_4b
recode S1_3_negative (0=1) (1=0)
label var S1_3_negative "Is the sidewalk continuous within the segement? recoded"

gen S1_6_trichot1 = S1_5b 
recode S1_6_trichot1 (1=0) (2=0) (3=1) (4=2)
label var S1_6_trichot1 "Are there poorly maintained sections of the sidewalk that constitute trip hazards? Major, trichotomized"

gen S1_6_trichot2 = S1_5c 
recode S1_6_trichot2 (1=0) (2=0) (3=1) (4=2)
label var S1_6_trichot2 "Are there poorly maintained sections of the sidewalk that are obstructed by objects? Major, trichotomized"

gen S1_6_trichot = S1_6_trichot1 + S1_6_trichot2
label var S1_6_trichot "Are there poorly maintained sections of the sidewalk that are obstructed? Major, trichotomized"

//Negative Segments Subscale

gen Segment_Neg_S1 = S1_3_negative + S1_6_trichot
replace Segment_Neg_S1 = 13 if S1_1==0
label var Segment_Neg_S1 "Sidewalk: Negative subscale"

//Overall Segments Subscale

gen Overall_Segment = Segments_Pos_S1 - Segment_Neg_S1
label var Overall_Segment "Overall segment score"

********************************************************************************

//Crossings

********************************************************************************

//Crosswalk Amenities Positive Subscale

gen CrosswalkAmenities_C1 = C1_7c + C1_8a + C1_8b + C1_8c + C1_11e
label var CrosswalkAmenities_C1 "Crosswalk amenities: Positive scale"

//Curb Quality/Presence

gen C1_5a_positive = C1_5a
label define C1_5a_positive 0"No ramp" 1"Ramp lines up with crossing"
label value C1_5a_positive C1_5a_positive
label var C1_5a_positive "Pre-crossing curb- Ramp lines up with crossing"

gen C1_5b_positive = C1_5b
label define C1_5b_positive 0"No ramp" 1"Ramp lines up with crossing"
label value C1_5b_positive C1_5b_positive
label var C1_5b_positive "Post-crossing curb- Ramp lines up with crossing"

//Curb Quality/Presence Positive Subscale

gen Curb_Qual_C1 = C1_5a_positive + C1_5b_positive
label var Curb_Qual_C1  "Curb Quality and Presence Subscale"

//Intersection Control and Signage Positive Subscale

gen IntsectCtrlSign_C1 = C1_1d + C1_3b + C1_3c + C1_3d
label var IntsectCtrlSign_C1 "Intersection Control/Signage: Positive subscale"

//Positive Crossing Subscale

gen PosCrossChars_C1 = CrosswalkAmenities_C1 + Curb_Qual_C1 + IntsectCtrlSign_C1
recode PosCrossChars_C1 (.=25)
label var PosCrossChars_C1 "Positive Crossing Subscale"

//Overall Crossing
gen OverallCrossScore_C1 = PosCrossChars_C1
label var OverallCrossScore_C1 "Overall Crossing Scale"


save "MAPS Recoding Scoring", replace

log close
