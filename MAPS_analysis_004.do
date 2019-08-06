

cls
capture log close
cd "/Users/kernrocke/Documents/Statistical Data Anlaysis/2019/Walkability/MAPS/Data"
log using "Log files/Data Preparation/MAPS_analysis_001", replace

**  GENERAL DO-FILE COMMENTS
**  program:		MAPS_analysis_004.do
**  project:      	Microscale Auidt of Pedestrian Streetscapes of UNESCO Hertiage Site Barbados
**  author:			Rocke, Whiteman, Hambleton, Howitt
**  task:          	Descriptives of subscale scores of MAPS
**	Date Modified:	30/07/2019


** DO-FILE SET UP COMMANDS
version 13
clear all
macro drop _all
set more 1
set linesize 200

/*	IMPORTANT: 
	The following STATA do files should be excuted prior the excuting this 
	do file
	1) MAPS_prep_001.do
	2) MAPS_prep_002.do
	3) MAPS_prep_003.do
*/


use "MAPS Overall", clear

*Route Subscale Scores

recode type (3=2)
	tabstat Res_Density_Mix_recode  Shops  Restaur_Ent Institu_Svc 			///
			Public_Rec Private_Rec DLU_pos DLU_Neg DLU_Overall  			///
			Pos_Streetscape Pos_AesthSoc Neg_AesthSoc AesthSoc_Overall   	///
			Route_Overall, by(type) stat(mean sem) long col(stat)

		
*Segment Subscale Scores
 
	tabstat PosBldgHtSetbks_S1 Sidewalk_S1 Buffers_Pos_S1 Trees_S1 			///
			BldgHt_RdWdthSetbk_Ratio_Scores Segments_Pos_S1					///
			Segment_Neg_S1 Overall_Segment , by(type) stat(mean sem) 		///
			long col(stat) 

			
*Crossing Subscale Scores

   tabstat CrosswalkAmenities_C1 Curb_Qual_C1 IntsectCtrlSign_C1		///
			PosCrossChars_C1 OverallCrossScore_C1,						///
			 by(type) stat(mean sem) long col(stat)  
			
*Overall 

   tabstat Overall_Positive Overall_Negative 		///
			Overall_Grand pedestrian_design,		///
			 by(type) stat(mean sem) long col(stat)  


 
 

////////////////////////////////////////////////////////////////////////////////
*Route Subscale Scores
	asdoc tabstat Res_Density_Mix_recode  Shops  Restaur_Ent Institu_Svc 			///
			Public_Rec Private_Rec DLU_pos DLU_Neg DLU_Overall  			///
			Pos_Streetscape Pos_AesthSoc Neg_AesthSoc AesthSoc_Overall   	///
			Route_Overall,  stat(mean semean) long col(stat) label save(Subscales.doc)

		
*Segment Subscale Scores
 
	asdoc tabstat PosBldgHtSetbks_S1 Sidewalk_S1 Buffers_Pos_S1 Trees_S1 			///
			BldgHt_RdWdthSetbk_Ratio_Scores Segments_Pos_S1					///
			Segment_Neg_S1 Overall_Segment ,  stat(mean semean) 		///
			long col(stat) label append save(Subscales.doc)

			
*Crossing Subscale Scores

   asdoc tabstat CrosswalkAmenities_C1 Curb_Qual_C1 IntsectCtrlSign_C1		///
			PosCrossChars_C1 OverallCrossScore_C1,						///
			  stat(mean semean) long col(stat)  label append save(Subscales.doc)
			
*Overall 

   asdoc tabstat Overall_Positive Overall_Negative 		///
			Overall_Grand pedestrian_design,		///
			  stat(mean semean) long col(stat) label append save(Subscales.doc)
			 
////////////////////////////////////////////////////////////////////////////////
	 
*Route Subscale Scores
	asdoc tabstat Res_Density_Mix_recode  Shops  Restaur_Ent Institu_Svc 			///
			Public_Rec Private_Rec DLU_pos DLU_Neg DLU_Overall  			///
			Pos_Streetscape Pos_AesthSoc Neg_AesthSoc AesthSoc_Overall   	///
			Route_Overall, by(type) stat(mean semean) long col(stat) label save(Subscales.doc)

		
*Segment Subscale Scores
 
	asdoc tabstat PosBldgHtSetbks_S1 Sidewalk_S1 Buffers_Pos_S1 Trees_S1 			///
			BldgHt_RdWdthSetbk_Ratio_Scores Segments_Pos_S1					///
			Segment_Neg_S1 Overall_Segment , by(type) stat(mean semean) 		///
			long col(stat) label append save(Subscales.doc)

			
*Crossing Subscale Scores

   asdoc tabstat CrosswalkAmenities_C1 Curb_Qual_C1 IntsectCtrlSign_C1		///
			PosCrossChars_C1 OverallCrossScore_C1,						///
			 by(type) stat(mean semean) long col(stat)  label append save(Subscales.doc)
			
*Overall 

   asdoc tabstat Overall_Positive Overall_Negative 		///
			Overall_Grand pedestrian_design,		///
			 by(type) stat(mean semean) long col(stat) label append save(Subscales.doc)



