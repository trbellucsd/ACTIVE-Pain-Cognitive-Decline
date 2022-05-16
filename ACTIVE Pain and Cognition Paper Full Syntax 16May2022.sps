* Encoding: UTF-8.

*Retrieve wide file. 

GET
  FILE='C:\Users\tyler\Data\Original\ACTIVE_Wide.sav'.

DATASET NAME DataSet1 WINDOW=FRONT.

*Recode demographics. 
RECODE race (1=1) (2=2) (3=3) (4=3) (5=3) (6=3) (7=3) INTO race_cat.
EXECUTE.

RECODE gender (1=1) (2=0) INTO gender_cat.
EXECUTE.

RECODE marstat (1=1) (2=1) (3 thru Highest=0) INTO marstat_cat.
EXECUTE.

*Code Bodily Pain as Pain Intensity >3. 
RECODE SF3621_1 SF3621_2 SF3621_3 SF3621_4 SF3621_5 SF3621_6 SF3621_7 SF3621_b (0 thru 3=0) (4 thru 
    Highest=1) INTO BP_1 BP_2 BP_3 BP_4 BP_5 BP_6 BP_7 BP_8.
EXECUTE.

*Code Pain Persistence. 
COMPUTE BP_SUM_1=BP_1.
EXECUTE.
COMPUTE BP_SUM_2=SUM(BP_1,BP_2).
EXECUTE.
COMPUTE BP_SUM_3=SUM(BP_1,BP_2,BP_3).
EXECUTE.
COMPUTE BP_SUM_4=SUM(BP_1,BP_2,BP_3, BP_4).
EXECUTE.
COMPUTE BP_SUM_5=SUM(BP_1,BP_2,BP_3,BP_4, BP_5).
EXECUTE.
COMPUTE BP_SUM_6= SUM(BP_1,BP_2,BP_3,BP_4, BP_5, BP_6).
EXECUTE.
COMPUTE BP_SUM_7= SUM(BP_1,BP_2,BP_3,BP_4, BP_5, BP_6,BP_7).
EXECUTE.

*Ensure missing values are where they should be for pain persistence. 
IF(NVALID(BP_1)=0) BP_SUM_1 = $SYSMIS .
EXECUTE. 
IF(NVALID(BP_2)=0) BP_SUM_2 = $SYSMIS .
EXECUTE. 
IF(NVALID(BP_3)=0) BP_SUM_3 = $SYSMIS .
EXECUTE. 
IF(NVALID(BP_4)=0) BP_SUM_4 = $SYSMIS .
EXECUTE. 
IF(NVALID(BP_5)=0) BP_SUM_5 = $SYSMIS .
EXECUTE. 
IF(NVALID(BP_6)=0) BP_SUM_6 = $SYSMIS .
EXECUTE. 
IF(NVALID(BP_7)=0) BP_SUM_7 = $SYSMIS .
EXECUTE. 

*Set baseline variables. 
COMPUTE SF3621_b = SF3621_1. 
COMPUTE BP_b = BP_1. 
COMPUTE BP_b = BP_1.
COMPUTE ageb = AGE.  
COMPUTE mmse_b = mmse_1.	
COMPUTE crt1_b =  crt1_1.	
COMPUTE crt2_b = crt2_1.	
COMPUTE immraw_b = immraw_1.	
COMPUTE ws_cor_b = ws_cor_1.	
COMPUTE lt_cor_b = lt_cor_1.	
COMPUTE ls_cor_b = ls_cor_1. 
COMPUTE hvltt_b = hvltt_1.
COMPUTE avltt_b = avltt_1.
COMPUTE ds_cor_b = ds_cor_1.	
COMPUTE dc_cor_b = dc_cor_1.	
COMPUTE ufov1_b = ufov1_1.	
COMPUTE ufov2_b = ufov2_1.	
COMPUTE ufov3_b = ufov3_1.	
COMPUTE ufov4_b = ufov4_1. 
COMPUTE SF3622_b =SF3622_1. 
COMPUTE cesd_b=CESDT_1.
EXECUTE.  
*Create follow-up age variables. 
COMPUTE AGE_V3=AGE+(Time_3/12).
COMPUTE AGE_V4=AGE+(Time_4/12).
COMPUTE AGE_V5=AGE+(Time_5/12).
COMPUTE AGE_V6=AGE+(Time_6/12).
COMPUTE AGE_V7=AGE+(Time_7/12).
EXECUTE.  
*Calculate number of completed waves for each participant. 
COMPUTE valid_sum = nvalid(BP_1, BP_3, BP_4, BP_5, BP_6, BP_7).
EXECUTE.  

*Convert Wide File to Long File. 
 VARSTOCASES
  /MAKE CRT1 FROM crt1_1 crt1_3 crt1_4 crt1_5 crt1_6 crt1_7
  /MAKE CRT2 FROM crt2_1 crt2_3 crt2_4 crt2_5 crt2_6 crt2_7
  /MAKE immraw FROM immraw_1 immraw_3 immraw_4 immraw_5 immraw_6 immraw_7
  /MAKE ws_cor FROM ws_cor_1 ws_cor_3 ws_cor_4 ws_cor_5 ws_cor_6 
    ws_cor_7
  /MAKE lt_cor FROM lt_cor_1 lt_cor_3 lt_cor_4 lt_cor_5 lt_cor_6 
    lt_cor_7
     /MAKE ls_cor FROM ls_cor_1 ls_cor_3 ls_cor_4 ls_cor_5 ls_cor_6 
    ls_cor_7
  /MAKE hvltt FROM hvltt_1 hvltt_3 hvltt_4 hvltt_5 hvltt_6 hvltt_7
  /MAKE avltt FROM avltt_1 avltt_3 avltt_4 avltt_5 avltt_6 avltt_7
  /MAKE ds_cor FROM ds_cor_1 ds_cor_3 ds_cor_4 ds_cor_5 ds_cor_6 ds_cor_7
  /MAKE dc_cor FROM dc_cor_1 dc_cor_3 dc_cor_4 dc_cor_5 dc_cor_6 dc_cor_7
  /MAKE ds_acc FROM ds_acc_1 ds_acc_3 ds_acc_4 ds_acc_5 ds_acc_6 
    ds_acc_7
  /MAKE dc_corr FROM dc_acc_1 dc_acc_3 dc_acc_4 dc_acc_5 dc_acc_6 
    dc_acc_7
  /MAKE ufov1 FROM ufov1_1 ufov1_3 ufov1_4 ufov1_5 ufov1_6 ufov1_7
  /MAKE ufov2 FROM ufov2_1 ufov2_3 ufov2_4 ufov2_5 ufov2_6 ufov2_7
  /MAKE ufov3 FROM ufov3_1 ufov3_3 ufov3_4 ufov3_5 ufov3_6 ufov3_7
  /MAKE ufov4 FROM ufov4_1 ufov4_3 ufov4_4 ufov4_5 ufov4_6 ufov4_7
  /MAKE SF36BPRaw FROM SF36BPRaw_1 SF36BPRaw_3 SF36BPRaw_4 SF36BPRaw_5 SF36BPRaw_6 SF36BPRaw_7
  /MAKE SF36BPScale FROM SF36BPScale_1 SF36BPScale_3 SF36BPScale_5 SF36BPScale_5 SF36BPScale_6 SF36BPScale_7
  /MAKE MMSE FROM mmse_1 mmse_3 mmse_4 mmse_5 mmse_6 mmse_7
  /MAKE CESDTot FROM  CESDT_1  CESDT_3 CESDT_4 CESDT_5 CESDT_6 CESDT_7
  /MAKE SF3621 FROM SF3621_1 SF3621_3 SF3621_4 SF3621_5 SF3621_6 SF3621_7 
  /MAKE SF3622 FROM    SF3622_1 SF3622_3 SF3622_4 SF3622_5 SF3622_6 SF3622_7
    /MAKE age_long FROM age age_v3 age_v4 age_v5 age_v6 age_v7
  /MAKE BP FROM BP_1 BP_3 BP_4 BP_5 BP_6 BP_7 
  /MAKE BP_SUM FROM BP_SUM_1 BP_SUM_3 BP_SUM_4 BP_SUM_5 BP_SUM_6 BP_SUM_7
       /INDEX=Index1(6) 
  /KEEP=id BP_B gender_cat marstat_cat race_cat gender marstat educlevl 
race hispanic intgrpR ageb mmse_b	crt1_b	crt2_b	immraw_b	ws_cor_b	lt_cor_b	ls_cor_b hvltt_b
avltt_b	ds_cor_b	dc_cor_b	ufov1_b	ufov2_b	ufov3_b	ufov4_b valid_sum SF3621_b SF3622_b cesd_b Hispanic_R
BP_SUM_7  /NULL=KEEP.


*Calculate longitudinal age variable of time since baseline. 
COMPUTE AGE_LONG_TIMESINCE=age_long-ageb.
EXECUTE.

*Merge CRT subtests. 
COMPUTE CRT=MEAN(CRT1,CRT2).
EXECUTE.

*Reverse score time-based measures. 
COMPUTE CRTR = 15.63-CRT.
COMPUTE UFOV1R = 500-UFOV1.
COMPUTE UFOV2R = 500-UFOV2.
COMPUTE UFOV3R = 500-UFOV3.
COMPUTE UFOV4R = 500-UFOV4.
EXECUTE.

*Create Z-score for comparable outcome scales. 
DESCRIPTIVES VARIABLES=CRT1 CRT2 immraw ws_cor lt_cor ls_cor hvltt avltt ds_cor dc_cor ds_acc 
    dc_corr ufov1r ufov2r ufov3r ufov4r MMSE CRTR
  /SAVE
  /STATISTICS=MEAN STDDEV MIN MAX.

*Code for incident pain. 
*Create the variable. 
*Set incident pain to 1 if they have accumualted more than 1 year of pain in the study. 
*Set incident to 0 if they have not accumulated any years of pain.
*Set incident pain to 0 for baseline (do not want to make colinear with baseline pain). 
*Set missing to missing in the new variable. 
COMPUTE BP_NEW4=0. 
IF ((BP_SUM-BP_B) > 0) BP_NEW4 = 1.
IF (BP_SUM =0) BP_NEW4 = 0.
IF (INDEX1=1) BP_NEW4 = 0.
IF(NVALID(BP)=0) BP_NEW4 = $SYSMIS. 
EXECUTE. 

*Save long file. 
SAVE OUTFILE='C:\tyler\ACTIVE\Data\Original\ACTIVE_Long.sav'
  /COMPRESSED.



*Descriptive analyses. 
USE ALL.
COMPUTE filter_$=(intgrpR=4 and index1=1).
VARIABLE LABELS filter_$ 'intgrpR=4 and index1=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

DESCRIPTIVES VARIABLES= AGEB educlvl race_cat gender_cat marstat_cat CESD_B MMSE DS_COR CRT UFOV2 UFOV3
    UFOV4 HVLTT AVLTT PRT LS_COR WS_COR 
  /STATISTICS=MEAN STDDEV MIN MAX.

FREQUENCIES VARIABLES=gender_cat marstat_cat race_cat
  /ORDER=ANALYSIS.

NONPAR CORR
  /VARIABLES=BP_b ageb educlevl race_cat gender_cat marstat_cat mmse_b crt1_b crt2_b immraw_b ws_cor_b 
    lt_cor_b ls_cor_b hvltt_b avltt_b ds_cor_b dc_cor_b ufov1_b ufov2_b ufov3_b ufov4_b CRT
  /PRINT=SPEARMAN KENDALL TWOTAIL NOSIG
  /MISSING=PAIRWISE.

*Aim 1. 

LOGISTIC REGRESSION VARIABLES BP_B
  /METHOD=ENTER gender_cat marstat_cat race_cat  AGEB educlevl CESD_B 
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5). 



USE ALL.
COMPUTE filter_$=(intgrpR=4).
VARIABLE LABELS filter_$ 'intgrpR=4 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

GENLINMIXED
  /FIELDS TARGET=BP_NEW
  /TARGET_OPTIONS DISTRIBUTION=BINOMIAL LINK=LOGIT
  /FIXED EFFECTS=gender_cat marstat_cat race_cat  AGE_LONG_TIMESINCE AGEB educlevl CESDTot CESD_B. 
  

MIXED BP_SUM by gender_cat marstat_cat race_cat  with  AGE_LONG_TIMESINCE AGEB  educlevl   CESDTot CESD_B 
  /FIXED gender_cat marstat_cat race_cat AGE_LONG_TIMESINCE AGEB  educlevl   CESDTot CESD_B  
    /RANDOM intercept  | subject(id) covtype(CS)    /print = solution.

MIXED UFOV2 by gender_cat marstat_cat race_cat  with AGEB AGE_LONG  educlevl   CESDTot SF36BPRAW CESD_B 
  /FIXED AGEB gender_cat marstat_cat race_cat CESD_B AGE_LONG  educlevl   SF36BPRAW CESDTot  
 RACE_CAT*AGE_LONG MARSTAT_CAT*AGE_LONG GENDER_CAT*AGE_LONG EDUCLEVL*AGE_LONG CESD_B*AGE_LONG  
CESDTot*AGE_LONG SF36BPRAW*AGE_LONG 
    /RANDOM intercept  | subject(id) covtype(CS)    /print = solution.

*Aim 2-3 (done in RStudio V 1.1.383). 
require(OpenMx)   #Loads OpenMx
require(psych)   #Loads Psych package

library(devtools)
library(umx)
library (OpenMx)
library (haven)
library (dplyr)
library(car)
library(psych)
library(lme4)
library(nlme)
library(lmerTest)
library(ggplot2)
library(tidyverse)
library(lme4)
library(car)
library(multilevelTools)
source("GenEpiHelperFunctions.R")
source("polychoricMeansMatrix3.R")
library(haven)
library(JWileymisc)
library(effects)
library(sjPlot)
library(sjmisc)

#READ IN DATA; 
setwd("C:/Users/tyler/ACTIVE/Data/Original")

ACTIVE <- read_sav("ACTIVE_Long.sav.sav")
names(ACTIVE)
names(ACTIVE)<- toupper(names(ACTIVE))

#DATA DESCRIPTION;
#COGNITIVE VARIABLES ARE STANDARDIZED AND FOLLOW-UP SCORES ARE ADJUSTED FOR BASELINE SCORES SO THAT FOLLOW-UP SCORES REPRESENT DECLINE
#GENDER: MEN =1 AND WOMEN =2
#MARSTATE:  MARRIED/PARTNERED = 1 SINGLE/DIVORCED/WIDOWED = 0;
#EDUCLEVL
#CESD - 20 ITEM CENTER OF EPIDEMIOLOGICAL STUDIES - DEPRESSION SCALE
#BP = SF36 BODILY PAIN SCORE (ITEM 21) GREATER THAN 3 = 1, LESS THAN 4 = 0 (>3 = CLINICAL LEVELS OF PAIN); _B MEANS BASELINE; _NEW = INCIDENT PAIN AFTER BASELINE; 
#PBP = PERSISTENT BODILY PAIN DEFINED AS CLINICALLY SIGNIFICANT PAIN OCCURING AT TWO TIMEPOINTS CONSECUTIVELY (1 = YES; 0 = NO)

#DATA SELECTION; WE SELECTED THE CONTROL GROUP OF ACTIVE;  
ACTIVE.sub <- subset(ACTIVE, ACTIVE$INTGRPR==4)

#MLM MODELS;
#OTHER RANDOM EFFECTS (GENDER_CAT | ID) + (MARSTAT_CAT | ID) + (RACE_CAT | ID) + (EDUCLEVL | ID) + (CESD_B | ID) ;
#ACTIVE.sub$PBP <- to_factor(ACTIVE.sub$PBP) # conversion
#ACTIVE.sub$BP_NEW <- to_factor(ACTIVE.sub$BP_NEW) # conversion
#ACTIVE.sub$AGE_LONG <- to_numeric(ACTIVE.sub$AGE_LONG)


model.MMSE <- lmer(ZMMSE ~   AGEB + RACE_CAT + GENDER_CAT + EDUCLEVL + MARSTAT_CAT +  CESD_B + BP_B + 
                      + AGE_LONG_TIMESINCE + BP_NEW +  BP_SUM + CESDTOT + 
                      + RACE_CAT*AGE_LONG_TIMESINCE + GENDER_CAT*AGE_LONG_TIMESINCE + EDUCLEVL*AGE_LONG_TIMESINCE + CESD_B*AGE_LONG_TIMESINCE 
                    + BP_B*AGE_LONG_TIMESINCE + MARSTAT_CAT*AGE_LONG_TIMESINCE +
                      CESDTOT*AGE_LONG_TIMESINCE + BP_NEW*AGE_LONG_TIMESINCE + BP_SUM*AGE_LONG_TIMESINCE +  (1| AGE_LONG_TIMESINCE )  
                      + (1| ID ), ACTIVE.sub, REML=FALSE) 
summary(model.MMSE)

MMSE.mt<-modelTest(model.MMSE); MMSE.mt

model.AVLTT <- lmer(ZAVLTT ~   AGEB + RACE_CAT + GENDER_CAT + EDUCLEVL + MARSTAT_CAT +  CESD_B + BP_B + 
                      + AGE_LONG_TIMESINCE + BP_NEW +  BP_SUM + CESDTOT + 
                      + RACE_CAT*AGE_LONG_TIMESINCE + GENDER_CAT*AGE_LONG_TIMESINCE + EDUCLEVL*AGE_LONG_TIMESINCE + CESD_B*AGE_LONG_TIMESINCE 
                    + BP_B*AGE_LONG_TIMESINCE + MARSTAT_CAT*AGE_LONG_TIMESINCE +
                      CESDTOT*AGE_LONG_TIMESINCE + BP_NEW*AGE_LONG_TIMESINCE + BP_SUM*AGE_LONG_TIMESINCE +  (1| AGE_LONG_TIMESINCE )  
                      + (1| ID ), ACTIVE.sub, REML=FALSE) 
summary(model.AVLTT)

AVLTT.mt<-modelTest(model.AVLTT); AVLTT.mt


model.HVLTT <- lmer(ZHVLTT ~   AGEB + RACE_CAT + GENDER_CAT + EDUCLEVL + MARSTAT_CAT +  CESD_B + BP_B + 
                      + AGE_LONG_TIMESINCE + BP_NEW +  BP_SUM + CESDTOT + 
                      + RACE_CAT*AGE_LONG_TIMESINCE + GENDER_CAT*AGE_LONG_TIMESINCE + EDUCLEVL*AGE_LONG_TIMESINCE + CESD_B*AGE_LONG_TIMESINCE 
                    + BP_B*AGE_LONG_TIMESINCE + MARSTAT_CAT*AGE_LONG_TIMESINCE +
                      CESDTOT*AGE_LONG_TIMESINCE + BP_NEW*AGE_LONG_TIMESINCE + BP_SUM*AGE_LONG_TIMESINCE  +  (1| AGE_LONG_TIMESINCE ) 
                      + (1| ID ), ACTIVE.sub, REML=FALSE) 
summary(model.HVLTT)

model.IMMRAW <- lmer(ZIMMRAW ~   AGEB + RACE_CAT + GENDER_CAT + EDUCLEVL + MARSTAT_CAT +  CESD_B + BP_B + 
                      + AGE_LONG_TIMESINCE + BP_NEW +  BP_SUM + CESDTOT + 
                      + RACE_CAT*AGE_LONG_TIMESINCE + GENDER_CAT*AGE_LONG_TIMESINCE + EDUCLEVL*AGE_LONG_TIMESINCE + CESD_B*AGE_LONG_TIMESINCE 
                    + BP_B*AGE_LONG_TIMESINCE + MARSTAT_CAT*AGE_LONG_TIMESINCE +
                      CESDTOT*AGE_LONG_TIMESINCE + BP_NEW*AGE_LONG_TIMESINCE + BP_SUM*AGE_LONG_TIMESINCE  +  (1| AGE_LONG_TIMESINCE ) 
                      + (1| ID ), ACTIVE.sub, REML=FALSE) 
summary(model.IMMRAW)

IMMRAW.mt<-modelTest(model.IMMRAW); IMMRAW.mt


model.DS_COR <- lmer(ZDS_COR ~   AGEB + RACE_CAT + GENDER_CAT + EDUCLEVL + MARSTAT_CAT +  CESD_B + BP_B + 
                      + AGE_LONG_TIMESINCE + BP_NEW +  BP_SUM + CESDTOT + 
                      + RACE_CAT*AGE_LONG_TIMESINCE + GENDER_CAT*AGE_LONG_TIMESINCE + EDUCLEVL*AGE_LONG_TIMESINCE + CESD_B*AGE_LONG_TIMESINCE 
                    + BP_B*AGE_LONG_TIMESINCE + MARSTAT_CAT*AGE_LONG_TIMESINCE +
                      CESDTOT*AGE_LONG_TIMESINCE + BP_NEW*AGE_LONG_TIMESINCE + BP_SUM*AGE_LONG_TIMESINCE  +  (1| AGE_LONG_TIMESINCE ) 
                      + (1| ID ), ACTIVE.sub, REML=FALSE) 
summary(model.DS_COR)

DS_COR.mt<-modelTest(model.DS_COR); DS_COR.mt

model.WS_COR <- lmer(ZWS_COR ~   AGEB + RACE_CAT + GENDER_CAT + EDUCLEVL + MARSTAT_CAT +  CESD_B + BP_B + 
                      + AGE_LONG_TIMESINCE + BP_NEW +  BP_SUM + CESDTOT + 
                      + RACE_CAT*AGE_LONG_TIMESINCE + GENDER_CAT*AGE_LONG_TIMESINCE + EDUCLEVL*AGE_LONG_TIMESINCE + CESD_B*AGE_LONG_TIMESINCE 
                    + BP_B*AGE_LONG_TIMESINCE + MARSTAT_CAT*AGE_LONG_TIMESINCE +
                      CESDTOT*AGE_LONG_TIMESINCE + BP_NEW*AGE_LONG_TIMESINCE + BP_SUM*AGE_LONG_TIMESINCE  +  (1| AGE_LONG_TIMESINCE ) 
                      + (1| ID ), ACTIVE.sub, REML=FALSE) 
summary(model.WS_COR)

WS_COR.mt<-modelTest(model.WS_COR); WS_COR.mt


model.LS_COR <- lmer(ZWS_COR ~   AGEB + RACE_CAT + GENDER_CAT + EDUCLEVL + MARSTAT_CAT +  CESD_B + BP_B + 
                      + AGE_LONG_TIMESINCE + BP_NEW +  BP_SUM + CESDTOT + 
                      + RACE_CAT*AGE_LONG_TIMESINCE + GENDER_CAT*AGE_LONG_TIMESINCE + EDUCLEVL*AGE_LONG_TIMESINCE + CESD_B*AGE_LONG_TIMESINCE 
                    + BP_B*AGE_LONG_TIMESINCE + MARSTAT_CAT*AGE_LONG_TIMESINCE +
                      CESDTOT*AGE_LONG_TIMESINCE + BP_NEW*AGE_LONG_TIMESINCE + BP_SUM*AGE_LONG_TIMESINCE  +  (1| AGE_LONG_TIMESINCE ) 
                      + (1| ID ), ACTIVE.sub, REML=FALSE) 
summary(model.LS_COR)

LS_COR.mt<-modelTest(model.LS_COR); LS_COR.mt


model.UFOV2 <- lmer(ZUFOV2 ~   AGEB + RACE_CAT + GENDER_CAT + EDUCLEVL + MARSTAT_CAT +  CESD_B + BP_B + 
                      + AGE_LONG_TIMESINCE + BP_NEW +  BP_SUM + CESDTOT + 
                      + RACE_CAT*AGE_LONG_TIMESINCE + GENDER_CAT*AGE_LONG_TIMESINCE + EDUCLEVL*AGE_LONG_TIMESINCE + CESD_B*AGE_LONG_TIMESINCE 
                    + BP_B*AGE_LONG_TIMESINCE + MARSTAT_CAT*AGE_LONG_TIMESINCE +
                      CESDTOT*AGE_LONG_TIMESINCE + BP_NEW*AGE_LONG_TIMESINCE + BP_SUM*AGE_LONG_TIMESINCE  +  (1| AGE_LONG_TIMESINCE ) 
                      + (1| ID ), ACTIVE.sub, REML=FALSE) 
summary(model.UFOV2)

UFOV2.mt<-modelTest(model.UFOV2); UFOV2.mt

model.UFOV3 <- lmer(ZUFOV3 ~   AGEB + RACE_CAT + GENDER_CAT + EDUCLEVL + MARSTAT_CAT +  CESD_B + BP_B + 
                      + AGE_LONG_TIMESINCE + BP_NEW +  BP_SUM + CESDTOT + 
                      + RACE_CAT*AGE_LONG_TIMESINCE + GENDER_CAT*AGE_LONG_TIMESINCE + EDUCLEVL*AGE_LONG_TIMESINCE + CESD_B*AGE_LONG_TIMESINCE 
                    + BP_B*AGE_LONG_TIMESINCE + MARSTAT_CAT*AGE_LONG_TIMESINCE + 
                      CESDTOT*AGE_LONG_TIMESINCE + BP_NEW*AGE_LONG_TIMESINCE + BP_SUM*AGE_LONG_TIMESINCE  +  (1| AGE_LONG_TIMESINCE ) 
                      + (1| ID ), ACTIVE.sub, REML=FALSE) 
summary(model.UFOV3)

UFOV3.mt<-modelTest(model.UFOV3); UFOV3.mt

model.UFOV4 <- lmer(ZUFOV4 ~   AGEB + RACE_CAT + GENDER_CAT + EDUCLEVL + MARSTAT_CAT +  CESD_B + BP_B + 
                      + AGE_LONG_TIMESINCE + BP_NEW +  BP_SUM + CESDTOT + 
                      + RACE_CAT*AGE_LONG_TIMESINCE + GENDER_CAT*AGE_LONG_TIMESINCE + EDUCLEVL*AGE_LONG_TIMESINCE + CESD_B*AGE_LONG_TIMESINCE 
                    + BP_B*AGE_LONG_TIMESINCE + MARSTAT_CAT*AGE_LONG_TIMESINCE +  (1| AGE_LONG_TIMESINCE ) 
                      CESDTOT*AGE_LONG_TIMESINCE + BP_NEW*AGE_LONG_TIMESINCE + BP_SUM*AGE_LONG_TIMESINCE  
                      + (1| ID ), ACTIVE.sub, REML=FALSE) 
summary(model.UFOV4)

UFOV4.mt<-modelTest(model.UFOV4); UFOV4.mt




