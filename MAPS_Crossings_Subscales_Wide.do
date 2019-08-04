
** GENERAL DO-FILE COMMENTS **

// project: 		MAPS STREET AUDIT - PILOT STUDY
// author: 			Kern Rocke, Christina Howitt, Ian Hambleton, Stephanie Whiteman
// description: 	Crossings Wide Format Data Management  
// date modified:	24/07/2019

preserve

drop if redcap_repeat_instrument=="maps_route"
keep if mapscrossings_complete==2
drop routeid-maps_route_complete time_start-Route_Overall 
keep CrosswalkAmenities_C1 Curb_Qual_C1 IntsectCtrlSign_C1 PosCrossChars_C1 OverallCrossScore_C1 record_id redcap_repeat_instance

*Reshape to wide format to calculate mean subscale scores for each route
reshape wide CrosswalkAmenities_C1 Curb_Qual_C1 IntsectCtrlSign_C1 PosCrossChars_C1 OverallCrossScore_C1, i(record_id) j(redcap_repeat_instance)

//Cross Walk Street Amenities Subscale Score - Mean
egen CrosswalkAmenities_C1 = rowmean(CrosswalkAmenities_C11 CrosswalkAmenities_C12 ///
										CrosswalkAmenities_C13 CrosswalkAmenities_C14 /// 
										CrosswalkAmenities_C15 CrosswalkAmenities_C16 ///
										CrosswalkAmenities_C17)
label var CrosswalkAmenities_C1 "Crosswalk amenities: Positive scale"

//Curb Quality Subscale Score - Mean
egen Curb_Qual_C1 = rowmean(Curb_Qual_C11 Curb_Qual_C12 ///
							Curb_Qual_C13 Curb_Qual_C14 /// 
							Curb_Qual_C15 Curb_Qual_C16 ///
							Curb_Qual_C17)
label var Curb_Qual_C1 "Curb Quality and Presence Subscale"

//Intersection Control/Signage Positive Subscale Score - Mean
egen IntsectCtrlSign_C1 = rowmean(IntsectCtrlSign_C11 IntsectCtrlSign_C12 ///
									IntsectCtrlSign_C13 IntsectCtrlSign_C14 /// 
									IntsectCtrlSign_C15 IntsectCtrlSign_C16 ///
									IntsectCtrlSign_C17)
label var IntsectCtrlSign_C1 "Intersection Control/Signage: Positive subscale"

// Positive Crossing Subscale Score - Mean
egen PosCrossChars_C1 = rowmean(PosCrossChars_C11 PosCrossChars_C12 ///
								PosCrossChars_C13 PosCrossChars_C14 /// 
								PosCrossChars_C15 PosCrossChars_C16 ///
								PosCrossChars_C17)
label var PosCrossChars_C1 "Positive Crossing Subscale"

// Overall Crossing Score - Mean
egen OverallCrossScore_C1 = rowmean(OverallCrossScore_C11 OverallCrossScore_C12 ///
									OverallCrossScore_C13 OverallCrossScore_C14 /// 
									OverallCrossScore_C15 OverallCrossScore_C16 ///
									OverallCrossScore_C17)
label var OverallCrossScore_C1 "Overall Crossing Score"


*Remove repeat variables
drop CrosswalkAmenities_C11 - OverallCrossScore_C17

** Save the file reading for further data management
save "Crossing Subscale Scores"

restore
