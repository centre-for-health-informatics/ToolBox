/* Determines the number of unique covariate combinations in the database.*/
/* This particular SAS pgm used an example with three covariates, fchf, */
/* fcreat and male. You obviously need to modify the pgm to accomodate a */
/* larger number of variables. In our original work, we used a pgm like */
/* this with about 20 variables, which yielded a very large number of */
/* covariate combinations (about 2,400). This pgm with 3 variables will */
/* only yield 8 combinations. */

 

libname www ‘c:\project\approach\new’;

data one;
set www.sample;

matrix= ‘1000’;

/* Note: the number of zeroes after the first 1 corresponds to the number */
/* of covariates in the final Cox Model. In this example, there are 3 */
/* covariates. */

if fchf=1 then
substr(matrix,2,1)=’1′;
if fcreat=1 then
substr(matrix,3,1)=’1′;
if male=1 then
substr(matrix,4,1)=’1′;

/* If there are more than 3 covariates, add if .. then .., */
/* subtr(matrix,.., 1)=’1′ here. */

run;

proc freq data=one noprint;
tables matrix/out=d;
run;

/* Covariate combinations in the dataset duplicated for diabetics */
/* and non-diabetics */

data d0;
set d;
fdiab=0;
run;

data d1;
set d;
fdiab=1;
run;

data dd;
set d1 d0;
drop percent;

if substr(matrix,2,1)=’1′ then fchf=1; else fchf=0;
if substr(matrix,3,1)=’1′ then fcreat=1; else fcreat=0;
if substr(matrix,4,1)=’1′ then male=1; else male=0;
run;

 

proc phreg data=one noprint;
model cathtime*censored(1)=
fdiab fchf fcreat male;
baseline covariates=dd out=m survival=sur/ nomean;
run;

 

data m;
set m;
matrix= ‘1000’;

/* Note: the number of zeroes after the first 1 corresponds to the number */
/* of covariates in the final Cox Model. In this example, there are 3 */
/* covariates. */

if fchf=1 then
substr(matrix,2,1)=’1′;
if fcreat=1 then
substr(matrix,3,1)=’1′;
if male=1 then
substr(matrix,4,1)=’1′;

/* If there are more than 3 covariates, add if .. then .., */
/* subtr(matrix,.., 1)=’1′ here. */
keep matrix fdiab cathtime sur;
run;

proc sort data=m;
by matrix;
run;

data dd;
set dd (keep=matrix count);
run;

proc sort data=dd;
by matrix;
run;

data dm;
merge dd m;
by matrix;
drop matrix;
run;

proc sort data=dm;
by fdiab cathtime;
run;

data final;
set dm;
by fdiab cathtime;
if first.cathtime then frqsum=0;
frqsum+count;
if first.cathtime then sursum=0;
sursum+sur*count;
if last.cathtime;
surf=sursum/frqsum;
keep fdiab cathtime surf;
run;

data surwt1;
set final;
if fdiab=1;
rename surf=surwt1;
drop fdiab;
run;

proc sort data=surwt1;
by cathtime;
run;

data surwt0;
set final;
if fdiab=0;
rename surf=surwt0;
drop fdiab;
run;

proc sort data=surwt0;
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

data sur;
merge surwt1 surwt0 surcrd1 surcrd0;
by cathtime;
run;

title1 ‘Survival Rates by the Corrected Group Prognosis Method’;
title2 ‘When Diabetics=1 (Surwt1) and Diabetics=0 (Surwt0)’;
title3 ‘Compared with Unadjusted Survival Rates’;
title4 ‘When Diabetics=1 (Surcrd1) and Diabetics=0 (Surcrd0)’;

proc print data=sur; run;

options pagesize=40 linesize=76;

proc plot data=sur nolegend;
plot
surcrd1*cathtime=’*’ surcrd0*cathtime=’*’
surwt1*cathtime=’-‘ surwt0*cathtime=’-‘/overlay;

title1 ‘Survival Curves by Corrected Group Prognosis Method’;
title2 ‘Symbol Used Is -‘;
title3 ‘Compared with Unadjusted Survival Curves’;
title4 ‘Symbol Used Is *’;

label Surcrd1=’Survival Rate’
cathtime=’Length of Survive after Catherization’;
run;