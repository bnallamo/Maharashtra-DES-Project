/* NEED TO IMPORT DE-IDENTIFIED DATA FILE */

/* Recoding variables - key variable of stent_type of 1 equals DES and price_cap of 1 equals 2015 */

gen stent_type=0
replace stent_type=1 if STENT_TYPE=="DES"
tab stent_type

gen price_cap=0
replace price_cap=1 if PRICE_CAP==2
tab price_cap

tab stent_type price_cap, row col chi

/* Simple 3-way descriptive tables for key variables */

gen elderly=0
replace elderly=1 if Age_tmnt>=65
tab elderly
tab3way elderly stent_type price_cap, rowp

gen woman=0
replace woman=1 if Sex_tmnt=="Female"
tab3way woman stent_type price_cap, rowp

gen high_education_level=0
replace high_education_level=1 if Education_level=="Some_Higher"
gen low_education_level=0
replace low_education_level=1 if high_education_level==0
tab3way low_education_level stent_type price_cap, rowp

gen diabetes=0
replace diabetes=1 if Diabetes=="Yes"
tab3way diabetes stent_type price_cap, rowp

gen public_private=0
replace public_private=1 if PUBLIC_PRIVATE==2
tab3way public_private stent_type price_cap, rowp

/* Simple description of stent type categories used: USFDA=0 if BMS, 1 if India DES, 2 if US DES (and multiple) */
gen USFDAstent=0
replace USFDAstent=1 if US_CE_FDA==2
replace USFDAstent=2 if US_CE_FDA==1 | US_CE_FDA==3
tab USFDAstent price_cap, row col chi

/* Final set description to get the number of unique hospitals */
xtset hospitals_code Subject_ID
xtdes, patterns(0)
