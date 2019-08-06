clear
cls

**  GENERAL DO-FILE COMMENTS
**  program:		MAPS_analysis_005.do
**  project:      	Microscale Auidt of Pedestrian Streetscapes of UNESCO Hertiage Site Barbados
**  author:			Rocke, Whiteman, Hambleton, Howitt
**  task:          	Distribution and Inferential Statistics of subscale scores of MAPS
**	Date Modified:	01/08/2019


** DO-FILE SET UP COMMANDS
version 13
clear all
macro drop _all
set more 1
set linesize 200

/*	IMPORTANT: 
	The following STATA do file should be excuted prior the excuting this 
	do file
	1) MAPS_prep_001.do
	2) MAPS_prep_002.do
	3) MAPS_prep_003.do
*/


*Reading in dataset
use "MAPS Overall", clear

*Recoding mixed to commercial
recode type (3=2)


////////////////////////////////////////////////////////////////////////////////
**Test for assessing Normal distribution

*Skewness and Kurtosis Tests

*Route Subscale Scores

sktest		Res_Density_Mix_recode  Shops  Restaur_Ent Institu_Svc 			///
			Public_Rec Private_Rec DLU_pos DLU_Neg DLU_Overall  			///
			Pos_Streetscape Pos_AesthSoc Neg_AesthSoc AesthSoc_Overall   	///
			Route_Overall

			
*Segment Subscale Scores

sktest		PosBldgHtSetbks_S1 Sidewalk_S1 Buffers_Pos_S1 Trees_S1 			///
			BldgHt_RdWdthSetbk_Ratio_Scores Segments_Pos_S1					///
			Segment_Neg_S1 Overall_Segment
			
			
*Crossing Subscale Scores
			
sktest		CrosswalkAmenities_C1 Curb_Qual_C1 IntsectCtrlSign_C1		///
			PosCrossChars_C1 OverallCrossScore_C1
			
sktest		Overall_Positive Overall_Negative 		///
			Overall_Grand pedestrian_design	
			
*Shapiro Wilks Test

*Route Subscale Scores
			
swilk		Res_Density_Mix_recode  Shops  Restaur_Ent Institu_Svc 			///
			Public_Rec Private_Rec DLU_pos DLU_Neg DLU_Overall  			///
			Pos_Streetscape Pos_AesthSoc Neg_AesthSoc AesthSoc_Overall   	///
			Route_Overall

*Segment Subscale Scores

swilk		PosBldgHtSetbks_S1 Sidewalk_S1 Buffers_Pos_S1 Trees_S1 			///
			BldgHt_RdWdthSetbk_Ratio_Scores Segments_Pos_S1					///
			Segment_Neg_S1 Overall_Segment

			
			*Crossing Subscale Scores			
swilk		CrosswalkAmenities_C1 Curb_Qual_C1 IntsectCtrlSign_C1		///
			PosCrossChars_C1 OverallCrossScore_C1
			
swilk		Overall_Positive Overall_Negative 		///
			Overall_Grand pedestrian_design	

////////////////////////////////////////////////////////////////////////////////

*Inferential Statistical Analyses

/*
Note: Due to sub-scale scores being derived from ordinal data, non-parametric 
analyses shall be used
*/
			
**Mann Whitney U test

*Route Subscale Scores

foreach x of varlist Res_Density_Mix_recode  Shops  Restaur_Ent Institu_Svc 			///
			Public_Rec Private_Rec DLU_pos DLU_Neg DLU_Overall  			///
			Pos_Streetscape Pos_AesthSoc Neg_AesthSoc AesthSoc_Overall   	///
			Route_Overall{
ranksum `x', by(type) 
}
 
 
*Segment Subscale Scores

foreach x of varlist PosBldgHtSetbks_S1 Sidewalk_S1 Buffers_Pos_S1 Trees_S1 			///
			BldgHt_RdWdthSetbk_Ratio_Scores Segments_Pos_S1					///
			Segment_Neg_S1 Overall_Segment{
ranksum `x', by(type) 
}


*Crossing Subscale Scores

foreach x of varlist CrosswalkAmenities_C1 Curb_Qual_C1 IntsectCtrlSign_C1		///
			PosCrossChars_C1 OverallCrossScore_C1{
ranksum `x', by(type) 
}


*Overall

foreach x of varlist Overall_Positive Overall_Negative 		///
			Overall_Grand pedestrian_design{
ranksum `x', by(type) 
}

 
