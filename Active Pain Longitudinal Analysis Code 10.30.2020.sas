*Creating grand mean centered variable and lagged variables;
*DATA active.step15long;
*set active.step15long;
*SF36BPScale_gmc = SF36BP_Mean - 26.03;
*RUN;
*proc sort data=active.step15long;
*by id;
*run;
*data active.step15long;
*set active.step15long;
*by id;
/*analysis variables for baseline centered lagged models*/
DATA Step910302020LONG2;
SET ACTIVE.Step910302020LONG;
SOP_COMP2 = SOP_COMP*-1;
MEMCOMP_CI = .;
IF MEMCOMP <-1 THEN MEMCOMP_CI = 1;
IF MEMCOMP >=-1 THEN MEMCOMP_CI = 0;
REASCOMP_CI = .;
IF REASCOMP <-1 THEN REASCOMP_CI = 1;
IF REASCOMP >=-1 THEN REASCOMP_CI = 0;
SOP_COMP_CI = .;
IF SOP_COMP2 <-1 THEN SOP_COMP_CI = 1;
IF SOP_COMP2 >=-1 THEN SOP_COMP_CI = 0;
SPEEDCOMP_CI = .;
IF SPEEDCOMP <-1 THEN SPEEDCOMP_CI = 1;
IF SPEEDCOMP >=-1 THEN SPEEDCOMP_CI = 0;
SF36BPSCALEC = SF36BPSCALE/10;
CLINICPAIN = .;
IF SF36BPSCALEC <4 THEN CLINICPAIN=0;
IF SF36BPSCALEC >=4 THEN CLINICPAIN=1;
SF36BP_Lagc=lag(SF36BPScalec);
SF36BP_Lag=lag(SF36BPScale_WP);
SF36BPScale_gmc = SF36BP_Mean - 26.03;
index1c = .;
if index1 =1 then
run;

ods pdf file = "C:\Users\trb5511\Box\Tyler's Folder\Papers\Pain and Cognition - ACTIVE\ACTIVE\LAnalysis_Full09252019.pdf";
libname ACTIVE "L:\ACTIVE\ACTIVE\ACTIVE\Data\Final SAS Data";

PROC MIXED data=Step910302020LONG2 method=reml noclprint covtest noitprint;
class id men rerace(ref="0") married (ref="1");
where intgrpR = 4 and index1;
model  MMSE= SF36BPScalec time educlevl men rerace married CESDTOT/s ddfm = bw;
random intercept /subject=id type=un;
RUN;

PROC MIXED data=Step910302020LONG2 method=reml noclprint covtest noitprint;
class id men rerace(ref="0") married (ref="1");
where intgrpR = 4 and index1;
model  MEMCOMP = SF36BPScalec reage educlevl men rerace married CESDTOT/s ddfm = bw;
random intercept /subject=id type=un;
RUN;

PROC MIXED data=Step910302020LONG2 method=reml noclprint covtest noitprint;
class id men rerace(ref="0") married (ref="1");
where intgrpR = 4 and index1;
model  REASCOMP = SF36BPScalec reage  educlevl men rerace married CESDTOT/s ddfm = bw;
random intercept /subject=id type=un;
RUN;
PROC MIXED data=Step910302020LONG2 method=reml noclprint covtest noitprint;
class id men rerace(ref="0") married (ref="1");
where intgrpR = 4 and index1;
model  SOP_COMP2 = SF36BPScalec reage  reage educlevl men rerace married CESDTOT/s ddfm = bw;
random intercept /subject=id type=un;
RUN;

PROC MIXED data=Step910302020LONG2 method=reml noclprint covtest noitprint;
class id men rerace(ref="0") married (ref="1");
where intgrpR = 4 and index1;
model  SPEEDCOMP = SF36BPScalec reage educlevl men rerace married CESDTOT/s ddfm = bw;
random intercept /subject=id type=un;
RUN;



*Substantive MLM Models;
Title "Bodily Pain";

PROC MIXED data=Step910302020LONG2 method=reml noclprint covtest noitprint;
class id men rerace(ref="0") married (ref="1");
where intgrpR = 4 and index1>2;
model  MMSE= SF36BPScalec SF36BP_Lagc index1 educlevl men rerace married CESDTOT/s ddfm = bw;
random intercept /subject=id type=un;
RUN;
PROC MIXED data=Step910302020LONG2 method=reml noclprint covtest noitprint;
class id men rerace(ref="0") married (ref="1");
where intgrpR = 4 and index1>2;
model  MEMCOMP = SF36BPScalec SF36BP_Lagc index1 educlevl men rerace married CESDTOT/s ddfm = bw;
random intercept /subject=id type=un;
RUN;

PROC MIXED data=Step910302020LONG2 method=reml noclprint covtest noitprint;
class id men rerace(ref="0") married (ref="1");
where intgrpR = 4 and index1>2;
model  REASCOMP = SF36BPScalec SF36BP_Lagc index1 educlevl men rerace married CESDTOT/s ddfm = bw;
random intercept /subject=id type=un;
RUN;
PROC MIXED data=Step910302020LONG2 method=reml noclprint covtest noitprint;
class id men rerace(ref="0") married (ref="1");
where intgrpR = 4 and index1>2;
model  SOP_COMP2 = SF36BPScalec SF36BP_Lagc index1 reage educlevl men rerace married CESDTOT/s ddfm = bw;
random intercept /subject=id type=un;
RUN;

PROC MIXED data=Step910302020LONG2 method=reml noclprint covtest noitprint;
class id men rerace(ref="0") married (ref="1");
where intgrpR = 4 and index1>2;
model  SPEEDCOMP = SF36BPScalec men  SF36BP_Lagc reage educlevl men rerace married CESDTOT/s ddfm = bw;
random intercept /subject=id type=un;
RUN;


*Substantive MLM Models;
Title "Bodily Pain";
PROC MIXED data=Step910302020LONG2 method=reml noclprint covtest noitprint;
class id men rerace(ref="0") married (ref="1");
where intgrpR = 4 and index1>2;
model  MEMCOMP = SF36BPScale_gmc SF36BPScale_wp SF36BP_lag  reage educlevl men rerace married CESDTOT/s ddfm = bw;
random intercept /subject=id type=un;
RUN;

PROC MIXED data=Step910302020LONG2 method=reml noclprint covtest noitprint;
class id men rerace(ref="0") married (ref="1");
where intgrpR = 4 and index1>2;
model  REASCOMP = SF36BPScale_gmc SF36BPScale_wp SF36BP_lag  educlevl men rerace married CESDTOT/s ddfm = bw;
random intercept /subject=id type=un;
RUN;
PROC MIXED data=Step910302020LONG2 method=reml noclprint covtest noitprint;
class id men rerace(ref="0") married (ref="1");
where intgrpR = 4 and index1>2;
model  SOP_COMP2 = SF36BPScale_gmc SF36BPScale_wp SF36BP_lag  reage educlevl men rerace married CESDTOT/s ddfm = bw;
random intercept /subject=id type=un;
RUN;

PROC MIXED data=Step910302020LONG2 method=reml noclprint covtest noitprint;
class id men rerace(ref="0") married (ref="1");
where intgrpR = 4 and index1>2;
model  SPEEDCOMP = SF36BPScale_gmc SF36BPScale_wp SF36BP_lag reage educlevl men rerace married CESDTOT/s ddfm = bw;
random intercept /subject=id type=un;
RUN;

PROC FREQ;
TABLE SF36BPSCALE;
RUN;

TITLE "ACCUMULATED PAIN INTENSITY ON AMNESTIC CI RISK";
PROC GLIMMIX DATA = Step910302020LONG2  NOCLPRINT MAXLMMUPDATE=1000 MAXOPT=1000 ABSPCONV=.0000001;
class id men rerace(ref="0") married (ref="1");
MODEL MEMCOMP_CI (REF="0") = CLINICPAIN educlevl  reage educlevl men rerace married CESDTOT/SOLUTION DDFM=BETWITHIN DIST =
 BINARY;
RANDOM INTERCEPT SF36BPScale /SUB=ID;
NLOPTIONS TECHNIQUE=NRRIDG MAXITER=1000 GCONV=1E-4;
*ESTIMATE "SF36BPScale " SF36BPScale 1 / EXP CL;
RUN;


TITLE "ACCUMULATED PAIN INTENSITY ON AMNESTIC CI RISK";
PROC GLIMMIX DATA = Step910302020LONG2  NOCLPRINT MAXLMMUPDATE=1000 MAXOPT=1000 ABSPCONV=.0000001;
class id men rerace(ref="0") married (ref="1");
MODEL REASCOMP_CI (REF="0") = SF36BPScale educlevl  reage educlevl men rerace married CESDTOT/SOLUTION DDFM=BETWITHIN DIST =
 BINARY;
RANDOM INTERCEPT SF36BPScale /SUB=ID;
NLOPTIONS TECHNIQUE=NRRIDG MAXITER=1000 GCONV=1E-4;
ESTIMATE "SF36BPScale " SF36BPScale 1 / EXP CL;
RUN;


where intgrpR = 4;
model  AVLT = SF36BPScale_WP SF36BPScale_gmc SF36BP_Lag reage educlevl men rerace  married CESDTOT/s ddfm = bw;
random intercept /subject=id type=un;
estimate "Lagged Within-Person Pain" SF36BP_Lag 1/cl;
RUN;
PROC MIXED data=Step910302020LONG2  method=reml noclprint covtest noitprint;
class id men rerace(ref="0") married (ref="1");
where intgrpR = 4 and index1 >2;
model  IMMRAW  = SF36BPScale_WP|reage   SF36BPScale_gmc|reage  SF36BP_Lag|reage  reage educlevl men rerace  married CESDTOT/s ddfm = bw;
run;



PROC MIXED data=Step910302020LONG2  method=reml noclprint covtest noitprint;
class id men rerace(ref="0") married (ref="1");
where intgrpR = 4 and index1 >2;
model  = SF36BPScale_WP|reage   SF36BPScale_gmc|reage  SF36BP_Lag|reage  reage educlevl men rerace  married CESDTOT/s ddfm = bw;
run;

