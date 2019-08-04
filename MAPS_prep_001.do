** CLOSE ANY OPEN LOG FILE AND OPEN A NEW LOG FILE
capture log close
cd "/Users/kernrocke/Documents/Statistical Data Anlaysis/2019/Walkability/MAPS/Data"
log using "Log files/Data Preparation/MAPS_prep_001", replace


**  GENERAL DO-FILE COMMENTS
**  program:		MAPS_prep_001.do
**  project:      	Microscale Auidt of Pedestrian Streetscapes of UNESCO Hertiage Site Barbados
**  author:			Rocke, Whiteman, Hambleton, Howitt
**  task:          	Initial Data Cleaning 
**	Date Modified:	25/07/2019

** DO-FILE SET UP COMMANDS
version 13
clear all
macro drop _all
set more 1
set linesize 200

** DO-FILE SECTION 01 - Importing Data from RedCap


	import delimited record_id redcap_repeat_instrument redcap_repeat_instance routeid auditorid type side crossstreet_s crossstreet_e starttime endtime mapsadmin_variables_complete land1 land2___1 land2___2 land2___3 land2___4 land2___5 land3a land3b land3c land3d land3e land3f land3g land3h land3i land3j land3k land3l land3m land3n land3o land3p land3q land3r land3s land3t land3u land3v land3w land3x land3y land3z land4___1 land4___2 land4___3 land4___4 street1 street2a street2b___1 street2b___2 street2b___3 street3___1 street3___2 street3___3 street3a street3b street4 street5 street6___0 street6___1 street6___2 street6___3 street6___4 street7 street8 street8a street8b aesthetics1 aesthetics2 aesthetics3 aesthetics4 aesthetics5 aesthetics6 aesthetics7 maps_route_complete type_segment segment1 segment2 segment3a segment3b segment4___0 segment4___1 segment4___2 segment4___3 segment4___4 segment5 segment6 segment7 segment8 segment9a segment9b segment10 segment11 segment12 segment13 segment14 segment15 maps_segment_complete intesection1 intersection2 streetfrom streetto crossings1 crossings2___1 crossings2___2 crossings2___3 crossings2___4 crossings3a crossings3b crossings4 crossings5___1 crossings5___2 crossings5___3 crossings5___4 crossings6 mapscrossings_complete using "MAPS_DATA_NOHDRS_2019-07-25_1148", varnames(nonames)

	label data "MAPS_DATA_NOHDRS_2019-07-22_0729.csv"

	label define type_ 1 "Residential" 2 "Commercial" 3 "Mixed" 
	label define side_ 1 "Left" 2 "Right" 
	label define mapsadmin_variables_complete_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 
	label define land1_ 1 "Foot (walked route)" 2 "Auto (drove route)" 3 "Both (walked & drove route)" 
	label define land2___1_ 0 "Unchecked" 1 "Checked" 
	label define land2___2_ 0 "Unchecked" 1 "Checked" 
	label define land2___3_ 0 "Unchecked" 1 "Checked" 
	label define land2___4_ 0 "Unchecked" 1 "Checked" 
	label define land2___5_ 0 "Unchecked" 1 "Checked" 
	label define land3a_ 0 "0" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 
	label define land3b_ 0 "0" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 
	label define land3c_ 0 "0" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 
	label define land3d_ 0 "0" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 
	label define land3e_ 0 "0" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 
	label define land3f_ 0 "0" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 
	label define land3g_ 0 "0" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 
	label define land3h_ 0 "0" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 
	label define land3i_ 0 "0" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 
	label define land3j_ 0 "0" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 
	label define land3k_ 0 "0" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 
	label define land3l_ 0 "0" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 
	label define land3m_ 0 "0" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 
	label define land3n_ 0 "0" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 
	label define land3o_ 0 "0" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 
	label define land3p_ 0 "0" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 
	label define land3q_ 0 "0" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 
	label define land3r_ 0 "0" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 
	label define land3s_ 0 "0" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 
	label define land3t_ 0 "0" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 
	label define land3u_ 0 "0" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 
	label define land3v_ 0 "0" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 
	label define land3w_ 0 "0" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 
	label define land3x_ 0 "0" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 
	label define land3y_ 0 "0" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 
	label define land3z_ 0 "0" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 
	label define land4___1_ 0 "Unchecked" 1 "Checked" 
	label define land4___2_ 0 "Unchecked" 1 "Checked" 
	label define land4___3_ 0 "Unchecked" 1 "Checked" 
	label define land4___4_ 0 "Unchecked" 1 "Checked" 
	label define street2b___1_ 0 "Unchecked" 1 "Checked" 
	label define street2b___2_ 0 "Unchecked" 1 "Checked" 
	label define street2b___3_ 0 "Unchecked" 1 "Checked" 
	label define street3___1_ 0 "Unchecked" 1 "Checked" 
	label define street3___2_ 0 "Unchecked" 1 "Checked" 
	label define street3___3_ 0 "Unchecked" 1 "Checked" 
	label define street4_ 0 "None" 1 "Some (e.g overhead street lights on utility poles with wide spacing)" 2 "Ample (e.g regularly spaced pedestrian lampposts)" 
	label define street5_ 0 "None" 1 "1-2" 2 "3-5" 3 "6+" 
	label define street6___0_ 0 "Unchecked" 1 "Checked" 
	label define street6___1_ 0 "Unchecked" 1 "Checked" 
	label define street6___2_ 0 "Unchecked" 1 "Checked" 
	label define street6___3_ 0 "Unchecked" 1 "Checked" 
	label define street6___4_ 0 "Unchecked" 1 "Checked" 
	label define street7_ 0 "0" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 
	label define street8_ 1 "Yes" 0 "No" 
	label define street8a_ 1 "Yes" 0 "No" 
	label define street8b_ 1 "Yes" 0 "No" 
	label define aesthetics1_ 1 "Yes" 0 "No" 
	label define aesthetics2_ 1 "Yes" 0 "No" 
	label define aesthetics3_ 0 "0%" 1 "1-49%" 2 "50-99%" 3 "100%" 
	label define aesthetics4_ 0 "0%" 1 "1-49%" 2 "50-99%" 3 "100%" 
	label define aesthetics5_ 1 "Yes" 0 "No" 
	label define aesthetics6_ 0 "None" 1 "A little (present)" 2 "Some (very noticeable)" 3 "A lot (overwhelming)" 
	label define aesthetics7_ 1 "Yes" 0 "No" 
	label define maps_route_complete_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 
	label define type_segment_ 1 "Residential" 2 "Commercial" 3 "Mixed" 
	label define segment1_ 1 "Yes" 0 "No" 
	label define segment2_ 0 "No sidewalk" 1 "< 3 ft" 2 "3-5 ft" 3 "> 5 ft" 
	label define segment3a_ 1 "Yes" 0 "No" 
	label define segment3b_ 0 "No buffer" 1 "< 3 ft" 2 "3-5 ft" 3 "> 5 ft" 
	label define segment4___0_ 0 "Unchecked" 1 "Checked" 
	label define segment4___1_ 0 "Unchecked" 1 "Checked" 
	label define segment4___2_ 0 "Unchecked" 1 "Checked" 
	label define segment4___3_ 0 "Unchecked" 1 "Checked" 
	label define segment4___4_ 0 "Unchecked" 1 "Checked" 
	label define segment5_ 0 "No sidewalk" 1 "None" 2 "One" 3 "A few" 4 "A lot" 
	label define segment6_ 0 "No sidewalks" 1 "None" 2 "One" 3 "A few" 4 "A lot" 
	label define segment7_ 1 "1 lane" 2 "2 lanes" 3 "3 lanes" 4 "4 lanes" 5 "5 lanes" 6 "6 lanes" 
	label define segment8_ 1 "Yes" 0 "No" 
	label define segment9a_ 1 "Yes" 0 "No" 
	label define segment9b_ 1 "Yes" 0 "No" 
	label define segment10_ 0 "N/A" 1 "0-1" 2 "2-5" 3 "6-10" 4 "11-20" 5 "21+" 
	label define segment11_ 0 "N/A" 1 "Evenly Spaces" 2 "Irregularly spaced" 
	label define segment12_ 0 "N/A" 1 "1-25%" 2 "25-50%" 3 "51-75%" 4 "76-100%" 5 "No coverage" 
	label define segment13_ 0 "No building" 1 "< 10 feet" 2 "10-20 feet" 3 "21-50 feet" 4 "51-100 feet" 5 "> 100 feet" 
	label define segment14_ 0 "No building" 1 "< 10 feet" 2 "10-20 feet" 3 "21-50 feet" 4 "51-100 feet" 5 "> 100 feet" 
	label define segment15_ 0 "No buildings" 1 "1-2 stories" 2 "3-5 stores" 3 "6-10 stories" 4 "> 10 stories" 
	label define maps_segment_complete_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 
	label define streetfrom_ 1 "Left" 2 "Right" 
	label define streetto_ 1 "Left" 2 "Right" 
	label define crossings1_ 1 "Yes" 0 "No" 
	label define crossings2___1_ 0 "Unchecked" 1 "Checked" 
	label define crossings2___2_ 0 "Unchecked" 1 "Checked" 
	label define crossings2___3_ 0 "Unchecked" 1 "Checked" 
	label define crossings2___4_ 0 "Unchecked" 1 "Checked" 
	label define crossings3a_ 0 "No ramp available" 1 "Ramp available" 
	label define crossings3b_ 0 "No ramp available" 1 "Ramp available" 
	label define crossings4_ 1 "Yes" 0 "No" 
	label define crossings5___1_ 0 "Unchecked" 1 "Checked" 
	label define crossings5___2_ 0 "Unchecked" 1 "Checked" 
	label define crossings5___3_ 0 "Unchecked" 1 "Checked" 
	label define crossings5___4_ 0 "Unchecked" 1 "Checked" 
	label define crossings6_ 1 "Yes" 0 "No" 
	label define mapscrossings_complete_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 
	label values type type_
	label values side side_
	label values mapsadmin_variables_complete mapsadmin_variables_complete_
	label values land1 land1_
	label values land2___1 land2___1_
	label values land2___2 land2___2_
	label values land2___3 land2___3_
	label values land2___4 land2___4_
	label values land2___5 land2___5_
	label values land3a land3a_
	label values land3b land3b_
	label values land3c land3c_
	label values land3d land3d_
	label values land3e land3e_
	label values land3f land3f_
	label values land3g land3g_
	label values land3h land3h_
	label values land3i land3i_
	label values land3j land3j_
	label values land3k land3k_
	label values land3l land3l_
	label values land3m land3m_
	label values land3n land3n_
	label values land3o land3o_
	label values land3p land3p_
	label values land3q land3q_
	label values land3r land3r_
	label values land3s land3s_
	label values land3t land3t_
	label values land3u land3u_
	label values land3v land3v_
	label values land3w land3w_
	label values land3x land3x_
	label values land3y land3y_
	label values land3z land3z_
	label values land4___1 land4___1_
	label values land4___2 land4___2_
	label values land4___3 land4___3_
	label values land4___4 land4___4_
	label values street2b___1 street2b___1_
	label values street2b___2 street2b___2_
	label values street2b___3 street2b___3_
	label values street3___1 street3___1_
	label values street3___2 street3___2_
	label values street3___3 street3___3_
	label values street4 street4_
	label values street5 street5_
	label values street6___0 street6___0_
	label values street6___1 street6___1_
	label values street6___2 street6___2_
	label values street6___3 street6___3_
	label values street6___4 street6___4_
	label values street7 street7_
	label values street8 street8_
	label values street8a street8a_
	label values street8b street8b_
	label values aesthetics1 aesthetics1_
	label values aesthetics2 aesthetics2_
	label values aesthetics3 aesthetics3_
	label values aesthetics4 aesthetics4_
	label values aesthetics5 aesthetics5_
	label values aesthetics6 aesthetics6_
	label values aesthetics7 aesthetics7_
	label values maps_route_complete maps_route_complete_
	label values type_segment type_segment_
	label values segment1 segment1_
	label values segment2 segment2_
	label values segment3a segment3a_
	label values segment3b segment3b_
	label values segment4___0 segment4___0_
	label values segment4___1 segment4___1_
	label values segment4___2 segment4___2_
	label values segment4___3 segment4___3_
	label values segment4___4 segment4___4_
	label values segment5 segment5_
	label values segment6 segment6_
	label values segment7 segment7_
	label values segment8 segment8_
	label values segment9a segment9a_
	label values segment9b segment9b_
	label values segment10 segment10_
	label values segment11 segment11_
	label values segment12 segment12_
	label values segment13 segment13_
	label values segment14 segment14_
	label values segment15 segment15_
	label values maps_segment_complete maps_segment_complete_
	label values streetfrom streetfrom_
	label values streetto streetto_
	label values crossings1 crossings1_
	label values crossings2___1 crossings2___1_
	label values crossings2___2 crossings2___2_
	label values crossings2___3 crossings2___3_
	label values crossings2___4 crossings2___4_
	label values crossings3a crossings3a_
	label values crossings3b crossings3b_
	label values crossings4 crossings4_
	label values crossings5___1 crossings5___1_
	label values crossings5___2 crossings5___2_
	label values crossings5___3 crossings5___3_
	label values crossings5___4 crossings5___4_
	label values crossings6 crossings6_
	label values mapscrossings_complete mapscrossings_complete_



	label variable record_id "Record ID"
	label variable redcap_repeat_instrument "Repeat Instrument"
	label variable redcap_repeat_instance "Repeat Instance"
	label variable routeid "Route ID"
	label variable auditorid "Auditor ID"
	label variable type "Type"
	label variable side "Street Side"
	label variable crossstreet_s "Starting Cross-street"
	label variable crossstreet_e "Ending Cross-street"
	label variable starttime "Start Time"
	label variable endtime "End Time"
	label variable mapsadmin_variables_complete "Complete?"
	label variable land1 "How is the audit information collected?"
	label variable land2___1 "What types of residential uses? (check all that apply) (choice=Single family houses)"
	label variable land2___2 "What types of residential uses? (check all that apply) (choice=Multi-unit homes (duplex, 4-plex, row house))"
	label variable land2___3 "What types of residential uses? (check all that apply) (choice=Apartments or condominiums)"
	label variable land2___4 "What types of residential uses? (check all that apply) (choice=Apartments above street retail)"
	label variable land2___5 "What types of residential uses? (check all that apply) (choice=None of the above)"
	label variable land3a "Corporate Fast Food restaurant (e.g Chefette, Burger King, KFC, Subway)"
	label variable land3b "Informal/mobile food establishment (local foods, road side vendors etc)"
	label variable land3c "Sit down restaurant "
	label variable land3d "Grocery/Supermarket"
	label variable land3e "Convenience store (may also be a gas station)"
	label variable land3f "Cafe or coffee or tea shop"
	label variable land3g "Bakery"
	label variable land3h "Age-restricted bar/night club"
	label variable land3i "Rum shop"
	label variable land3j "Bank / Credit union / ATM"
	label variable land3k "Drugstore / Pharmacy"
	label variable land3l "Health-related professional (e.g. chiropractor, Doctors office, private health care facilities)"
	label variable land3m "Other service (e.g salon, accountant, dry cleaner)"
	label variable land3n "Other retail (e.g books, clothing, hardware)"
	label variable land3o "Place of worship (e.g temple, church, synagogue, convent, mosque, etc)"
	label variable land3p "School"
	label variable land3q "Private indoor recreation(e.g. commercial gyms, dance clubs)"
	label variable land3r "Public indoor recreation (e.g community center)"
	label variable land3s "Private outdoor recreation (e.g private gulf course)"
	label variable land3t "Public outdoor recreation (e.g public pool)"
	label variable land3u "Public park"
	label variable land3v "Trail"
	label variable land3w "Pedestrian Street or zone"
	label variable land3x "Bicycle Shop"
	label variable land3y "Access to beach"
	label variable land3z "Public outdoor sports facilities (e.g basketball courts, road tennis)"
	label variable land4___1 "Shopping Centers (check all that apply (choice=Shopping Mall or Arcade)"
	label variable land4___2 "Shopping Centers (check all that apply (choice=Strip Mall)"
	label variable land4___3 "Shopping Centers (check all that apply (choice=Open-Air market)"
	label variable land4___4 "Shopping Centers (check all that apply (choice=None of the above)"
	label variable street1 "Number of public bus stops ( if NO stops, skip to 3)"
	label variable street2a "Bus Route #"
	label variable street2b___1 "What is available at the first bus stop? Only count benches that users could easily identify by bus drivers as waiting to ride the bus. (Check all that apply) (choice=Bench)"
	label variable street2b___2 "What is available at the first bus stop? Only count benches that users could easily identify by bus drivers as waiting to ride the bus. (Check all that apply) (choice=Covered Shelter)"
	label variable street2b___3 "What is available at the first bus stop? Only count benches that users could easily identify by bus drivers as waiting to ride the bus. (Check all that apply) (choice=None of the above)"
	label variable street3___1 "What other street characteristics are present? (specify number of each type and check all that apply (choice=Traffic calming (e.g signs, pedestrian crossings, roundabouts, speed humps, speed tables))"
	label variable street3___2 "What other street characteristics are present? (specify number of each type and check all that apply (choice=Roll over curbs)"
	label variable street3___3 "What other street characteristics are present? (specify number of each type and check all that apply (choice=None of the above)"
	label variable street3a "Number of Traffic calming items"
	label variable street3b "Number of Roll-over curbs"
	label variable street4 "Are street lights installed?"
	label variable street5 "How many driveways or alleys are there? (Count only segment side of the street; Count only alleys that are wide enough to be used by cars or other vehicles that could impede pedestrian traffic)"
	label variable street6___0 "Presence of street amenities (Check all that apply) (choice=None)"
	label variable street6___1 "Presence of street amenities (Check all that apply) (choice=Building overhangs that provide shelter from inclement weather in public space (i.e sidewalks))"
	label variable street6___2 "Presence of street amenities (Check all that apply) (choice=Trash bins (public i.e non-removable bins))"
	label variable street6___3 "Presence of street amenities (Check all that apply) (choice=Benches or other places to sit)"
	label variable street6___4 "Presence of street amenities (Check all that apply) (choice=Bicycle racks)"
	label variable street7 "How many marked pedestrian crossings are there on the route?"
	label variable street8 "Is there a sign Present?"
	label variable street8a "Is the crossing visibly marked / painted"
	label variable street8b "Is there a slop present at curb/sidewalk"
	label variable aesthetics1 "Do you observe pleasant hardscape features, such as fountains, sculptures, or art (public or private)?"
	label variable aesthetics2 "Do you observe softscape features such as gardens or landscape (e.g Public bodies of water, designated view points, private retaining walls, bark or ponds)?"
	label variable aesthetics3 "Are the buildings well maintained? If in doubt, add pictures"
	label variable aesthetics4 "Is the landscaping/outdoor spaces well maintained?"
	label variable aesthetics5 "Is graffiti (not murals) present?"
	label variable aesthetics6 "Rate the extent of graffiti"
	label variable aesthetics7 "Presence of anyone walking?"
	label variable maps_route_complete "Complete?"
	label variable type_segment "Type"
	label variable segment1 "Is a sidewalk present?"
	label variable segment2 "What is the width of the majority of the sidewalk"
	label variable segment3a "Is there a buffer present?"
	label variable segment3b "How wide if the majority of the buffer?"
	label variable segment4___0 "Is the sidewalk continuous within the segment/ (check all that apply) (choice=No sidewalk)"
	label variable segment4___1 "Is the sidewalk continuous within the segment/ (check all that apply) (choice=Yes)"
	label variable segment4___2 "Is the sidewalk continuous within the segment/ (check all that apply) (choice=No (interrupted by driveway))"
	label variable segment4___3 "Is the sidewalk continuous within the segment/ (check all that apply) (choice=No (have to walk on street))"
	label variable segment4___4 "Is the sidewalk continuous within the segment/ (check all that apply) (choice=No (Change of surface))"
	label variable segment5 "Are there poorly maintained sections of the sidewalk that constitute major  trip hazards? (e.g. heaves,  misalignment, cracks, overgrowth)"
	label variable segment6 "Are there poorly maintained sections of the sidewalk that are obstructed by objects overhead? (e.g wires, foilage)"
	label variable segment7 "How many traffic lanes are present (include all lanes traffic can use; choose the most predominant)"
	label variable segment8 "Is there a marked bicycle lane marked with a line or a raised curb?"
	label variable segment9a "Is there an obvious informal path (shortcut), not on a cul-de-sac, which connects to something else?"
	label variable segment9b "Is there an informal path (shortcut), not on a cul-de-sac, which connects to an unknown destination?"
	label variable segment10 "How many trees exist within 5 feet of either of the sidewalk/pathway? (can be in buffer or setback; also count trees  that are more than 5 feet away if they provide shade for the sidewalk/pathway)"
	label variable segment11 "How are the trees generally spaced? "
	label variable segment12 "What percentage of the length of the sidewalk is covered by trees, awnings or other overhead coverage?"
	label variable segment13 "What is the smallest building setback from the sidewalk/walkway?"
	label variable segment14 "What is the largest building setback from the sidewalk/walkway?"
	label variable segment15 "What is the average height of the buildings? (Count both sides of the street)"
	label variable maps_segment_complete "Complete?"
	label variable intesection1 "Intersection of: "
	label variable intersection2 "Intersection of:"
	label variable streetfrom "Street side from "
	label variable streetto "Street side to"
	label variable crossings1 "Is there a roundabout/traffic circle?"
	label variable crossings2___1 "Signalization (check all that apply) (choice=Pedestrian walk signals)"
	label variable crossings2___2 "Signalization (check all that apply) (choice=Push Buttons)"
	label variable crossings2___3 "Signalization (check all that apply) (choice=Countdown signals)"
	label variable crossings2___4 "Signalization (check all that apply) (choice=None of the above)"
	label variable crossings3a "Pre-Crossing Curb"
	label variable crossings3b "Post-crossing curb"
	label variable crossings4 "Are crossing aids (e.g. flags or crossing guard) present?"
	label variable crossings5___1 "Crosswalk treatment (check all that apply)  (choice=Marked crosswalk)"
	label variable crossings5___2 "Crosswalk treatment (check all that apply)  (choice=High-visibility striping)"
	label variable crossings5___3 "Crosswalk treatment (check all that apply)  (choice=Different material than road)"
	label variable crossings5___4 "Crosswalk treatment (check all that apply)  (choice=None of the above)"
	label variable crossings6 "Is a curb extension present?"
	label variable mapscrossings_complete "Complete?"

	*Creating Crossing type variable 

	gen type_crossing = type_segment
	replace type_crossing = 1 if record_id==3 
	replace type_crossing = 1 if record_id==4 
	replace type_crossing = 1 if record_id==14 
	replace type_crossing = 1 if record_id==16 
	replace type_crossing = 1 if record_id==17 
	replace type_crossing = 1 if record_id==18 
	replace type_crossing = 1 if record_id==20 
	replace type_crossing = 1 if record_id==21 
	replace type_crossing = 1 if record_id==22 
	replace type_crossing = 1 if record_id==24 
	replace type_crossing = 1 if record_id==25 
	replace type_crossing = 1 if record_id==26 
	replace type_crossing = 1 if record_id==27 
	replace type_crossing = 1 if record_id==31 
	replace type_crossing = 1 if record_id==34 
	replace type_crossing = 1 if record_id==35 
	replace type_crossing = 1 if record_id==40 
	replace type_crossing = 1 if record_id==41 
	replace type_crossing = 1 if record_id==42 
	replace type_crossing = 1 if record_id==43 
	replace type_crossing = 1 if record_id==45 
	replace type_crossing = 1 if record_id==46 
	replace type_crossing = 1 if record_id==47 
	replace type_crossing = 1 if record_id==48 
	replace type_crossing = 1 if record_id==49 
	replace type_crossing = 1 if record_id==50 
	replace type_crossing = 1 if record_id==51 
	replace type_crossing = 1 if record_id==52 
	replace type_crossing = 1 if record_id==53 
	replace type_crossing = 1 if record_id==55 
	replace type_crossing = 1 if record_id==56 
	replace type_crossing = 1 if record_id==60

	replace type_crossing =2 if type_segment==2
	replace type_crossing =2 if type_segment==3

	recode type_crossing (.=2)
	label var type_crossing "Crossing type"
	label define type_crossing 1"Residenital" 2"Commercial"
	label value type_crossing type_crossing

	
	order record_id redcap_repeat_instrument redcap_repeat_instance routeid auditorid type side crossstreet_s crossstreet_e starttime endtime mapsadmin_variables_complete land1 land2___1 land2___2 land2___3 land2___4 land2___5 land3a land3b land3c land3d land3e land3f land3g land3h land3i land3j land3k land3l land3m land3n land3o land3p land3q land3r land3s land3t land3u land3v land3w land3x land3y land3z land4___1 land4___2 land4___3 land4___4 street1 street2a street2b___1 street2b___2 street2b___3 street3___1 street3___2 street3___3 street3a street3b street4 street5 street6___0 street6___1 street6___2 street6___3 street6___4 street7 street8 street8a street8b aesthetics1 aesthetics2 aesthetics3 aesthetics4 aesthetics5 aesthetics6 aesthetics7 maps_route_complete type_segment segment1 segment2 segment3a segment3b segment4___0 segment4___1 segment4___2 segment4___3 segment4___4 segment5 segment6 segment7 segment8 segment9a segment9b segment10 segment11 segment12 segment13 segment14 segment15 maps_segment_complete intesection1 intersection2 streetfrom streetto type_crossing crossings1 crossings2___1 crossings2___2 crossings2___3 crossings2___4 crossings3a crossings3b crossings4 crossings5___1 crossings5___2 crossings5___3 crossings5___4 crossings6 mapscrossings_complete 
	set more off
	describe

** DO-FILE SECTION 02- Data Cleaning

// Changing the time variables form string to numeric //

	gen double time_start = clock(starttime, "hm")
	format time_start %tcHH:MM

	gen double time_end = clock(endtime, "hm")
	format time_end %tcHH:MM

	gen time_diff = time_end - time_start
	format time_diff %tcHH:MM

	label var time_diff "Time difference (Start and End)Ó

*Note: Including the label maps route to the variable redcap_repeat_instrument

replace redcap_repeat_instrument = "maps_route" if redcap_repeat_instrument==""
encode redcap_repeat_instrument, gen(instrument_type)

//Renaming variables to match MAPS scoring manual 

*

*ROUTE

// Route and Land Use Section

rename land1 LU1
rename land2___1 LU3a
rename land2___2 LU3b
rename land2___3 LU3c
rename land2___4 LU3d
rename land2___5 LU3e
rename land3* LU6*
rename land4___1 LU7a
rename land4___2 LU7b
rename land4___3 LU7c


// Streetscape Section

rename street1 SS1a
rename street2a SS2_1a
rename street2b___1 SS2_1b
rename street2b___2 SS2_1c
rename street3___1 SS4a
rename street3___2 SS4b
*Note multiply street3a* SS4a and street3b*SS4b
replace SS4a = SS4a*street3a
replace SS4b = SS4b*street3b
rename street4 SS5
rename street5 SS6
rename street6___1 SS7a
rename street6___2 SS7b
rename street6___3 SS7c
rename street6___4 SS7d
rename street7 SS8
rename street8 SS9a
rename street8a SS9b
rename street8b SS9c


//Aesthetics and Social Section

rename aesthetics1 A1
rename aesthetics2 A2
rename aesthetics3 A4
rename aesthetics4 A5
rename aesthetics5 A6a
rename aesthetics6 A7
rename aesthetics7 A10

********************************************************************************

*Segments

rename segment1 S1_1
rename segment2 S1_2
rename segment3a S1_3a
rename segment3b S1_3b
*Note S1_3b (How wide is the majority of the buffer)
rename segment4___0 S1_4a
rename segment4___1 S1_4b
rename segment4___2 S1_4c
rename segment4___3 S1_4d
rename segment4___4 S1_4e
rename segment5 S1_5b
rename segment6 S1_5c
rename segment7 S1_10
rename segment8 S1_14
rename segment9a S1_17a
rename segment9b S1_17b
rename segment10 S1_23
rename segment11 S1_24
rename segment12 S1_25
rename segment13 S1_26
rename segment14 S1_27
rename segment15 S1_28

********************************************************************************

*Crossings

rename crossings1 C1_1d
rename crossings2___1 C1_3b
rename crossings2___2 C1_3c
rename crossings2___3 C1_3d
rename crossings3a C1_5a
rename crossings3b C1_5b
rename crossings4 C1_7c
rename crossings5___1 C1_8a
rename crossings5___2 C1_8b
rename crossings5___3 C1_8c
rename crossings6 C1_11e

********************************************************************************


*Labelling time variables

label var time_start "Route Start Time"
label var time_end "Route End Time"


save "MAPS_cleaned", replace

log close
