ods pdf file = "C:\Users\trb5511\Box\Tyler's Folder\Papers\Pain and Cognition - ACTIVE\ACTIVE\Preliminary Analysis\Output\ACTIVEPrelimOutput09232019.pdf"; 
libname ACTIVE "C:\Users\trb5511\Box\Tyler's Folder\Papers\Pain and Cognition - ACTIVE\ACTIVE\Data\Final SAS Data";
*Within Person Change in Pain;
PROC CORR data = ACTIVE.step15long spearman; 
where intgrpR = 4 and index1 = 1; 
var SF36BPScale SF3621 SF3622 age men rerace educlevl married CESDTOT MMSE AVLT HVLT IMMRAW LS_COR LT_COR WS_COR DS_COR  CRT1 CRT2 CRTTotal UFOV1 UFOV2 UFOV3;
RUN; 
proc freq data = ACTIVE.step15long; 
where intgrpR = 4 and index1 = 1; 
table SF36BPScale CESDTOT; 
run; 
ods pdf close; 
