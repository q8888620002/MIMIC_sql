
SELECT
  pvt.subject_id, pvt.hadm_id, pvt.icustay_id, pvt.intime,pvt.outtime, pvt.starttime, pvt.endtime
  , max(GCS) as gcs_max
  , min(GCS) as gcs_min
  , max(GCSMotor) as gcsmotor_max
  , min(GCSMotor) as gcsmotor_min
  , max(GCSVerbal) as gcsverbal_max
  , min(GCSVerbal) as gcsverbal_min
  , max(GCSEyes) as gcseyes_max
  , min(GCSEyes) as gcseyes_min
  , max(EndoTrachFlag) as endo_max
  , min(EndoTrachFlag) as endo_min  
  , max(HeartRate) as hr_max
  , min(HeartRate) as hr_min
  , max(SysBP) as sysbp_max
  ,	min(SysBP) as sysbp_min	
  , max(DiasBP) as diasbp_max	
  , min(DiasBP) as diasbp_min
  , max(MeanBP) as meanbp_max
  , min(MeanBP) as meanbp_min
  , max(RespRate) as rr_max
  , min(RespRate) as rr_min
  , max(TempC)	as tempc_max
  , min(TempC) as tempc_min	
  , max(SpO2) as spo2_max	
  , min(SpO2) as spo2_min
  , max(fio2) as fio2_max	
  , min(fio2) as fio2_min
  , min(CASE WHEN label = 'ANION GAP' THEN valuenum ELSE null END) as ANIONGAP_min
  , max(CASE WHEN label = 'ANION GAP' THEN valuenum ELSE null END) as ANIONGAP_max
  , min(CASE WHEN label = 'ALBUMIN' THEN valuenum ELSE null END) as ALBUMIN_min
  , max(CASE WHEN label = 'ALBUMIN' THEN valuenum ELSE null END) as ALBUMIN_max
  , min(CASE WHEN label = 'BANDS' THEN valuenum ELSE null END) as BANDS_min
  , max(CASE WHEN label = 'BANDS' THEN valuenum ELSE null END) as BANDS_max
  , min(CASE WHEN label = 'BICARBONATE' THEN valuenum ELSE null END) as BICARBONATE_min
  , max(CASE WHEN label = 'BICARBONATE' THEN valuenum ELSE null END) as BICARBONATE_max
  , min(CASE WHEN label = 'BILIRUBIN' THEN valuenum ELSE null END) as BILIRUBIN_min
  , max(CASE WHEN label = 'BILIRUBIN' THEN valuenum ELSE null END) as BILIRUBIN_max
  , min(CASE WHEN label = 'CREATININE' THEN valuenum ELSE null END) as CREATININE_min
  , max(CASE WHEN label = 'CREATININE' THEN valuenum ELSE null END) as CREATININE_max
  , min(CASE WHEN label = 'CHLORIDE' THEN valuenum ELSE null END) as CHLORIDE_min
  , max(CASE WHEN label = 'CHLORIDE' THEN valuenum ELSE null END) as CHLORIDE_max
  , min(CASE WHEN label = 'GLUCOSE' THEN valuenum ELSE null END) as GLUCOSE_min
  , max(CASE WHEN label = 'GLUCOSE' THEN valuenum ELSE null END) as GLUCOSE_max
  , min(CASE WHEN label = 'HEMATOCRIT' THEN valuenum ELSE null END) as HEMATOCRIT_min
  , max(CASE WHEN label = 'HEMATOCRIT' THEN valuenum ELSE null END) as HEMATOCRIT_max
  , min(CASE WHEN label = 'HEMOGLOBIN' THEN valuenum ELSE null END) as HEMOGLOBIN_min
  , max(CASE WHEN label = 'HEMOGLOBIN' THEN valuenum ELSE null END) as HEMOGLOBIN_max
  , min(CASE WHEN label = 'LACTATE' THEN valuenum ELSE null END) as LACTATE_min
  , max(CASE WHEN label = 'LACTATE' THEN valuenum ELSE null END) as LACTATE_max
  , min(CASE WHEN label = 'PLATELET' THEN valuenum ELSE null END) as PLATELET_min
  , max(CASE WHEN label = 'PLATELET' THEN valuenum ELSE null END) as PLATELET_max
  , min(CASE WHEN label = 'POTASSIUM' THEN valuenum ELSE null END) as POTASSIUM_min
  , max(CASE WHEN label = 'POTASSIUM' THEN valuenum ELSE null END) as POTASSIUM_max
  , min(CASE WHEN label = 'PTT' THEN valuenum ELSE null END) as PTT_min
  , max(CASE WHEN label = 'PTT' THEN valuenum ELSE null END) as PTT_max
  , min(CASE WHEN label = 'INR' THEN valuenum ELSE null END) as INR_min
  , max(CASE WHEN label = 'INR' THEN valuenum ELSE null END) as INR_max
  , min(CASE WHEN label = 'PT' THEN valuenum ELSE null END) as PT_min
  , max(CASE WHEN label = 'PT' THEN valuenum ELSE null END) as PT_max
  , min(CASE WHEN label = 'SODIUM' THEN valuenum ELSE null END) as SODIUM_min
  , max(CASE WHEN label = 'SODIUM' THEN valuenum ELSE null end) as SODIUM_max
  , min(CASE WHEN label = 'BUN' THEN valuenum ELSE null end) as BUN_min
  , max(CASE WHEN label = 'BUN' THEN valuenum ELSE null end) as BUN_max
  , min(CASE WHEN label = 'WBC' THEN valuenum ELSE null end) as WBC_min
  , max(CASE WHEN label = 'WBC' THEN valuenum ELSE null end) as WBC_max
  , min(CASE WHEN label = 'alt' THEN valuenum ELSE null end) as alt_min
  , max(CASE WHEN label = 'alt' THEN valuenum ELSE null end) as alt_max
  , min(CASE WHEN label = 'ast' THEN valuenum ELSE null end) as ast_min
  , max(CASE WHEN label = 'ast' THEN valuenum ELSE null end) as ast_max
  , min(CASE WHEN label = 'crp' THEN valuenum ELSE null end) as crp_min
  , max(CASE WHEN label = 'crp' THEN valuenum ELSE null end) as crp_max

FROM
( -- begin query that extracts the data
  SELECT ie.subject_id, ie.hadm_id, ie.icustay_id, d.intime, d.outtime, d.starttime, d.endtime
  -- here we assign labels to ITEMIDs
  -- this also fuses together multiple ITEMIDs containing the same data
  , CASE
        WHEN itemid = 50868 THEN 'ANION GAP'
        WHEN itemid = 50862 THEN 'ALBUMIN'
        WHEN itemid = 51144 THEN 'BANDS'
        WHEN itemid = 50882 THEN 'BICARBONATE'
        WHEN itemid = 50885 THEN 'BILIRUBIN'
        WHEN itemid = 50912 THEN 'CREATININE'
        WHEN itemid = 50806 THEN 'CHLORIDE'
        WHEN itemid = 50902 THEN 'CHLORIDE'
        WHEN itemid = 50809 THEN 'GLUCOSE'
        WHEN itemid = 50931 THEN 'GLUCOSE'
        WHEN itemid = 50810 THEN 'HEMATOCRIT'
        WHEN itemid = 51221 THEN 'HEMATOCRIT'
        WHEN itemid = 50811 THEN 'HEMOGLOBIN'
        WHEN itemid = 51222 THEN 'HEMOGLOBIN'
        WHEN itemid = 50813 THEN 'LACTATE'
        WHEN itemid = 51265 THEN 'PLATELET'
        WHEN itemid = 50822 THEN 'POTASSIUM'
        WHEN itemid = 50971 THEN 'POTASSIUM'
        WHEN itemid = 51275 THEN 'PTT'
        WHEN itemid = 51237 THEN 'INR'
        WHEN itemid = 51274 THEN 'PT'
        WHEN itemid = 50824 THEN 'SODIUM'
        WHEN itemid = 50983 THEN 'SODIUM'
        WHEN itemid = 51006 THEN 'BUN'
        WHEN itemid = 51300 THEN 'WBC'
        WHEN itemid = 51301 THEN 'WBC'
        when itemid = 50861 then 'alt'
        when itemid = 50878 then 'ast'
        when itemid = 50889 then 'crp'
      ELSE null
    END AS label
  , -- add in some sanity checks on the values
  -- the where clause below requires all valuenum to be > 0, so these are only upper limit checks
    CASE
      WHEN itemid = 50862 and valuenum >    10 THEN null -- g/dL 'ALBUMIN'
      WHEN itemid = 50868 and valuenum > 10000 THEN null -- mEq/L 'ANION GAP'
      WHEN itemid = 51144 and valuenum <     0 THEN null -- immature band forms, %
      WHEN itemid = 51144 and valuenum >   100 THEN null -- immature band forms, %
      WHEN itemid = 50882 and valuenum > 10000 THEN null -- mEq/L 'BICARBONATE'
      WHEN itemid = 50885 and valuenum >   150 THEN null -- mg/dL 'BILIRUBIN'
      WHEN itemid = 50806 and valuenum > 10000 THEN null -- mEq/L 'CHLORIDE'
      WHEN itemid = 50902 and valuenum > 10000 THEN null -- mEq/L 'CHLORIDE'
      WHEN itemid = 50912 and valuenum >   150 THEN null -- mg/dL 'CREATININE'
      WHEN itemid = 50809 and valuenum > 10000 THEN null -- mg/dL 'GLUCOSE'
      WHEN itemid = 50931 and valuenum > 10000 THEN null -- mg/dL 'GLUCOSE'
      WHEN itemid = 50810 and valuenum >   100 THEN null -- % 'HEMATOCRIT'
      WHEN itemid = 51221 and valuenum >   100 THEN null -- % 'HEMATOCRIT'
      WHEN itemid = 50811 and valuenum >    50 THEN null -- g/dL 'HEMOGLOBIN'
      WHEN itemid = 51222 and valuenum >    50 THEN null -- g/dL 'HEMOGLOBIN'
      WHEN itemid = 50813 and valuenum >    50 THEN null -- mmol/L 'LACTATE'
      WHEN itemid = 51265 and valuenum > 10000 THEN null -- K/uL 'PLATELET'
      WHEN itemid = 50822 and valuenum >    30 THEN null -- mEq/L 'POTASSIUM'
      WHEN itemid = 50971 and valuenum >    30 THEN null -- mEq/L 'POTASSIUM'
      WHEN itemid = 51275 and valuenum >   150 THEN null -- sec 'PTT'
      WHEN itemid = 51237 and valuenum >    50 THEN null -- 'INR'
      WHEN itemid = 51274 and valuenum >   150 THEN null -- sec 'PT'
      WHEN itemid = 50824 and valuenum >   200 THEN null -- mEq/L == mmol/L 'SODIUM'
      WHEN itemid = 50983 and valuenum >   200 THEN null -- mEq/L == mmol/L 'SODIUM'
      WHEN itemid = 51006 and valuenum >   300 THEN null -- 'BUN'
      WHEN itemid = 51300 and valuenum >  1000 THEN null -- 'WBC'
      WHEN itemid = 51301 and valuenum >  1000 THEN null -- 'WBC'
      WHEN itemid = 50889 and valuenum >  1000 THEN null -- 'crp'
      WHEN itemid = 50878 and valuenum >  1000 THEN null -- 'ast'
      WHEN itemid = 50861 and valuenum >  1000 THEN null -- 'alt'
    ELSE le.valuenum
    END AS valuenum

  FROM `mimic-dqn.dribing_pressure.1hour_duration` d
  LEFT JOIN `physionet-data.mimiciii_clinical.icustays` ie
  ON  d.icustay_id = ie.icustay_id
  LEFT JOIN `physionet-data.mimiciii_clinical.labevents` le
    ON le.subject_id = ie.subject_id AND le.hadm_id = ie.hadm_id
    AND le.charttime BETWEEN d.starttime AND d.endtime
    AND le.ITEMID in
    (
      -- comment is: LABEL | CATEGORY | FLUID | NUMBER OF ROWS IN LABEVENTS
      50868, -- ANION GAP | CHEMISTRY | BLOOD | 769895
      50862, -- ALBUMIN | CHEMISTRY | BLOOD | 146697
      51144, -- BANDS - hematology
      50882, -- BICARBONATE | CHEMISTRY | BLOOD | 780733
      50885, -- BILIRUBIN, TOTAL | CHEMISTRY | BLOOD | 238277
      50912, -- CREATININE | CHEMISTRY | BLOOD | 797476
      50902, -- CHLORIDE | CHEMISTRY | BLOOD | 795568
      50806, -- CHLORIDE, WHOLE BLOOD | BLOOD GAS | BLOOD | 48187
      50931, -- GLUCOSE | CHEMISTRY | BLOOD | 748981
      50809, -- GLUCOSE | BLOOD GAS | BLOOD | 196734
      51221, -- HEMATOCRIT | HEMATOLOGY | BLOOD | 881846
      50810, -- HEMATOCRIT, CALCULATED | BLOOD GAS | BLOOD | 89715
      51222, -- HEMOGLOBIN | HEMATOLOGY | BLOOD | 752523
      50811, -- HEMOGLOBIN | BLOOD GAS | BLOOD | 89712
      50813, -- LACTATE | BLOOD GAS | BLOOD | 187124
      51265, -- PLATELET COUNT | HEMATOLOGY | BLOOD | 778444
      50971, -- POTASSIUM | CHEMISTRY | BLOOD | 845825
      50822, -- POTASSIUM, WHOLE BLOOD | BLOOD GAS | BLOOD | 192946
      51275, -- PTT | HEMATOLOGY | BLOOD | 474937
      51237, -- INR(PT) | HEMATOLOGY | BLOOD | 471183
      51274, -- PT | HEMATOLOGY | BLOOD | 469090
      50983, -- SODIUM | CHEMISTRY | BLOOD | 808489
      50824, -- SODIUM, WHOLE BLOOD | BLOOD GAS | BLOOD | 71503
      51006, -- UREA NITROGEN | CHEMISTRY | BLOOD | 791925
      51301, -- WHITE BLOOD CELLS | HEMATOLOGY | BLOOD | 753301
      51300,  -- WBC COUNT | HEMATOLOGY | BLOOD | 2371
      50861,
      50878,
      50889
    )
    AND valuenum IS NOT null AND valuenum > 0 -- lab values cannot be 0 and cannot be negative
) pvt
left join `physionet-data.mimiciii_derived.pivoted_vital` as v
on pvt.icustay_id = v.icustay_id
left join `physionet-data.mimiciii_derived.pivoted_gcs` as g
on pvt.icustay_id =g.icustay_id
left join `physionet-data.mimiciii_derived.pivoted_fio2` as f
on pvt.icustay_id =f.icustay_id
where g.charttime between pvt.starttime and pvt.endtime and 
      v.charttime between pvt.starttime and pvt.endtime and 
      f.charttime between pvt.starttime and pvt.endtime
GROUP BY pvt.subject_id, pvt.hadm_id, pvt.icustay_id ,pvt.intime,pvt.outtime, pvt.starttime, pvt.endtime
ORDER BY pvt.subject_id, pvt.hadm_id, pvt.icustay_id, pvt.starttime
