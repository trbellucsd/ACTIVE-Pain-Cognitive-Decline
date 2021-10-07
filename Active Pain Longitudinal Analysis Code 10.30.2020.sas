libname ACTIVE "L:\ACTIVE\ACTIVE\ACTIVE\Data\Final SAS Data";

*Creating baseline and within-person change in pain measures;
*DATA active.step15long;
*set active.step15long;
*SF36BPScale_bgmc = SF36BPScale_b - 26.03;
SF36BPScale_WP = SF36BPScale - SF36BPScale_b 
*RUN;


PROC MIXED data=Step910302020LONG2 method=reml noclprint covtest noitprint;
class id gender race(ref="0") married (ref="1");
where intgrpR = 4;
model  MMSE= SF36BPScale_gmc SF36BPScale_wp agec educlevl gender race married CESDTOT/s ddfm = bw;
random intercept /subject=id type=un;
RUN;
PROC MIXED data=Step910302020LONG2 method=reml noclprint covtest noitprint;
class id gender race(ref="0") married (ref="1");
where intgrpR = 4;
model  HVLT = SF36BPScale_gmc SF36BPScale_wp agec educlevl gender race married CESDTOT/s ddfm = bw;
random intercept /subject=id type=un;
RUN;
PROC MIXED data=Step910302020LONG2 method=reml noclprint covtest noitprint;
class id gender race(ref="0") married (ref="1");
where intgrpR = 4;
model  AVLT = SF36BPScale_gmc SF36BPScale_wp agec educlevl gender race married CESDTOT/s ddfm = bw;
random intercept /subject=id type=un;
RUN;
PROC MIXED data=Step910302020LONG2 method=reml noclprint covtest noitprint;
class id gender race(ref="0") married (ref="1");
where intgrpR = 4;
model  IMMRAW = SF36BPScale_gmc SF36BPScale_wp agec educlevl gender race married CESDTOT/s ddfm = bw;
random intercept /subject=id type=un;
RUN;
PROC MIXED data=Step910302020LONG2 method=reml noclprint covtest noitprint;
class id gender race(ref="0") married (ref="1");
where intgrpR = 4;
model  DS_COR = SF36BPScale_gmc SF36BPScale_wp agec educlevl gender race married CESDTOT/s ddfm = bw;
random intercept /subject=id type=un;
RUN;

PROC MIXED data=Step910302020LONG2 method=reml noclprint covtest noitprint;
class id gender race(ref="0") married (ref="1");
where intgrpR = 4;
model  DC_COR = SF36BPScale_gmc SF36BPScale_wp agec educlevl gender race married CESDTOT/s ddfm = bw;
random intercept /subject=id type=un;
RUN

PROC MIXED data=Step910302020LONG2 method=reml noclprint covtest noitprint;
class id gender race(ref="0") married (ref="1");
where intgrpR = 4;
model  UFOV2 = SF36BPScale_gmc SF36BPScale_wp agec educlevl gender race married CESDTOT/s ddfm = bw;
random intercept /subject=id type=un;
RUN

PROC MIXED data=Step910302020LONG2 method=reml noclprint covtest noitprint;
class id gender race(ref="0") married (ref="1");
where intgrpR = 4;
model  UFOV3 = SF36BPScale_gmc SF36BPScale_wp agec educlevl gender race married CESDTOT/s ddfm = bw;
random intercept /subject=id type=un;
RUN

PROC MIXED data=Step910302020LONG2 method=reml noclprint covtest noitprint;
class id gender race(ref="0") married (ref="1");
where intgrpR = 4;
model  UFOV4 = SF36BPScale_gmc SF36BPScale_wp agec educlevl gender race married CESDTOT/s ddfm = bw;
random intercept /subject=id type=un;
RUN

PROC MIXED data=Step910302020LONG2 method=reml noclprint covtest noitprint;
class id gender race(ref="0") married (ref="1");
where intgrpR = 4;
model  LT_COR = SF36BPScale_gmc SF36BPScale_wp agec educlevl gender race married CESDTOT/s ddfm = bw;
random intercept /subject=id type=un;
RUN

PROC MIXED data=Step910302020LONG2 method=reml noclprint covtest noitprint;
class id gender race(ref="0") married (ref="1");
where intgrpR = 4;
model  LS_COR = SF36BPScale_gmc SF36BPScale_wp agec educlevl gender race married CESDTOT/s ddfm = bw;
random intercept /subject=id type=un;
RUN

PROC MIXED data=Step910302020LONG2 method=reml noclprint covtest noitprint;
class id gender race(ref="0") married (ref="1");
where intgrpR = 4;
model  WS_COR = SF36BPScale_gmc SF36BPScale_wp agec educlevl gender race married CESDTOT/s ddfm = bw;
random intercept /subject=id type=un;
RUN
