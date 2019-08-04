
** GENERAL DO-FILE COMMENTS **

// project: 		MAPS STREET AUDIT - PILOT STUDY
// author: 			Kern Rocke, Christina Howitt, Ian Hambleton, Stephanie Whiteman
// description: 	Segments Wide Format Data Management 
// date modified:	24/07/2019

preserve

drop if redcap_repeat_instrument=="maps_route"
keep if maps_segment==2
drop routeid-maps_route_complete time_start-Route_Overall 
keep type_segment redcap_repeat_instance record_id Sidewalk_S1 PosBldgHtSetbks_S1 Buffers_Pos_S1 Trees_S1 S1_17 BldgHt_RdWdthSetbk_Ratio_S1 Segments_Pos_S1 Segment_Neg_S1 Overall_Segment

*Reshape to wide format to calculate mean subscale scores for each route
reshape wide type_segment - Overall_Segment, i(record_id) j(redcap_repeat_instance)

//Positive Setback and Building Height Subscale Score - Mean
egen PosBldgHtSetbks_S1 = rowmean(PosBldgHtSetbks_S11 PosBldgHtSetbks_S12 ///
									PosBldgHtSetbks_S13 PosBldgHtSetbks_S14 /// 
									PosBldgHtSetbks_S15 PosBldgHtSetbks_S16)
label var PosBldgHtSetbks_S1 "Positive Setbacks/Bldg. Height: Positive subscale"

//Sidewalk Subscale Score - Mean
egen Sidewalk_S1 = rowmean(Sidewalk_S11 Sidewalk_S12 ///
							Sidewalk_S13 Sidewalk_S14 /// 
							Sidewalk_S15 Sidewalk_S16)
label var Sidewalk_S1 "Sidewalk: Positive subscale"

//Buffer Positive Subscale Score - Mean
egen Buffers_Pos_S1 = rowmean(Buffers_Pos_S11 Buffers_Pos_S12 ///
							Buffers_Pos_S13 Buffers_Pos_S14 /// 
							Buffers_Pos_S15 Buffers_Pos_S16)
label var Buffers_Pos_S1 "Buffers: Positive Subscale"

//Trees Positive Subscale Score - Mean
egen Trees_S1 = rowmean(Trees_S11 Trees_S12 ///
							Trees_S13 Trees_S14 /// 
							Trees_S15 Trees_S16)
label var Trees_S1 "Trees: Positive subscale"

//Building Height: Road Width+Setback Avgs. Ratio Positive Subscale Score - Mean
egen BldgHt_RdWdthSetbk_Ratio_S1 = rowmean(BldgHt_RdWdthSetbk_Ratio_S11 BldgHt_RdWdthSetbk_Ratio_S12 ///
											BldgHt_RdWdthSetbk_Ratio_S13 BldgHt_RdWdthSetbk_Ratio_S14 /// 
											BldgHt_RdWdthSetbk_Ratio_S15 BldgHt_RdWdthSetbk_Ratio_S16)
label var BldgHt_RdWdthSetbk_Ratio_S1 "Building Height: Road Width+Setback Avgs. Ratio"

gen BldgHt_RdWdthSetbk_Ratio_Scores = BldgHt_RdWdthSetbk_Ratio_S1
recode BldgHt_RdWdthSetbk_Ratio_Scores (min/0.49999=0) (0.50/0.99999=1) (1.0/1.99999=3) (2.0/2.99999=2) (3.0/max=1)
label define BldgHt_RdWdthSetbk_Ratio_Scores 0"Lowest - 0.499" 1"0.50 - 0.999; 3.0 - Highest" 2"2.0 - 2.999" 3"1.0 - 1.999"
label value BldgHt_RdWdthSetbk_Ratio_Scores BldgHt_RdWdthSetbk_Ratio_Scores
label var BldgHt_RdWdthSetbk_Ratio_Scores "Scores for the ratio"

//Positive Segements Subscale - Mean
egen Segments_Pos_S1 = rowmean(Segments_Pos_S11 Segments_Pos_S12 ///
								Segments_Pos_S13 Segments_Pos_S14 /// 
								Segments_Pos_S15 Segments_Pos_S16)
label var Segments_Pos_S1 "Sum of positive segments subscales"

//Negative Segements Subscale - Mean
egen Segment_Neg_S1 = rowmean(Segment_Neg_S11 Segment_Neg_S12 ///
								Segment_Neg_S13 Segment_Neg_S14 /// 
								Segment_Neg_S15 Segment_Neg_S16)
label var Segment_Neg_S1 "Sum of negative segments subscales"

//Overall Segments Subscale - Mean
egen Overall_Segment = rowmean(Overall_Segment1 Overall_Segment2 ///
								Overall_Segment3 Overall_Segment4 /// 
								Overall_Segment5 Overall_Segment6)
label var Overall_Segment "Overall segment score"

*Remove repeat variables
drop type_segment1 - Overall_Segment6


** Save the file reading for further data management
save "Segment Subscale Scores"

restore
