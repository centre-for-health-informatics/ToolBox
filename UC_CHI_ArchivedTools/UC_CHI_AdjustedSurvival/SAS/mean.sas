/* Generates adjusted survival curves by the Mean of Covariates Method */
/* also generates unadjusted survival curves for comparison */

options pagesize=1000 linesize=76;
libname www ‘c:\project\approach\www’;

data one;
set www.sample;
run;

/* input proportions of these three variables in the dataset */

data mean;
input fdiab fchf fcreat male;
cards;

0 0.136 0.022 0.711
1 0.136 0.022 0.711
run;

proc phreg data=one noprint;
model cathtime*censored(1)=
fdiab fchf fcreat male;
baseline covariates=mean out=surmn survival=surmn / nomean;
run;

data surmn1;
set surmn (keep=fdiab cathtime surmn);
if fdiab=1;
rename surmn=surmn1;
drop fdiab;
run;

proc sort data=surmn1;
by cathtime;
run;

data surmn0;
set surmn (keep=fdiab cathtime surmn);
if fdiab=0;
rename surmn=surmn0;
drop fdiab;
run;

proc sort data=surmn0;
by cathtime;
run;

 

data inrisk;
input
fdiab;
cards;

0
1
;
run;

 

proc phreg data=one noprint;
model cathtime*censored(1)=fdiab;
baseline covariates=inrisk out=crud survival=surcrd / nomean;
run;

 

data surcrd1;
set crud (keep=fdiab cathtime surcrd);
if fdiab=1;
rename surcrd=surcrd1;
drop fdiab;
run;

proc sort data=surcrd1;
by cathtime;
run;

data surcrd0;
set crud (keep=fdiab cathtime surcrd);
if fdiab=0;
rename surcrd=surcrd0;
drop fdiab;
run;

proc sort data=surcrd0;
by cathtime;
run;

data surcrdmn;
merge surmn1 surmn0 surcrd1 surcrd0;
by cathtime;
run;

title1 ‘Survival Rates by the Mean of Covariates Method’;
title2 ‘When Diabetics=1 (Surmn1) and Diabetics=0 (Surmn0)’;
title3 ‘Compared with Unadjusted Survival Rates’;
title4 ‘When Diabetics=1 (Surcrd1) and Diabetics=0 (Surcrd0)’;

proc print data=surcrdmn; run;

options pagesize=40 linesize=76;

proc plot data=surcrdmn nolegend;
plot
surcrd1*cathtime=’*’ surcrd0*cathtime=’*’
surmn1*cathtime=’-‘ surmn0*cathtime=’-‘/overlay;

title1 ‘Survival Curves by Mean of Covariates Method’;
title2 ‘Symbol Used Is -‘;
title3 ‘Compared with Unadjusted Survival Curves’;
title4 ‘Symbol Used Is *’;

label Surcrd1=’Survival Rate’
cathtime=’Length of Survive after Catherization’;
run;