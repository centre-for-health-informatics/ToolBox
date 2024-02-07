#Determines the number of unique covariate combinations in the database
#This pgm with 3 variables will only yield 8 combinations.

library(survival)
library(survminer)
library(ggplot2)

data <- read.csv("C:/Users/zhaoyu.liu/OneDrive - University of Calgary/chi survival/data.csv", header = T,sep = " ")

#Note: the number of zeroes after the first 1 corresponds to the number
#of covariates in the final Cox Model. In this example, there are 3 covariates.
for(i in 1:nrow(data)){data$matrix[i]= "1000"}


#If there are more than 3 covariates, add if .. 
for(i in 1:nrow(data)){
  if(data$FCHF[i]==1){substr(data$matrix[i],2,2)='1'}
  if(data$FCREAT[i]==1) {substr(data$matrix[i],3,3)='1'}
  if(data$MALE[i]==1) {substr(data$matrix[i],4,4)='1'}
}

d <- data.frame(table(data$matrix))

#Covariate combinations in the dataset duplicated for diabetics and non-diabetics

d0 <- d
for(i in 1:nrow(d)){d0$FDIAB[i] <- 0}
d1 <- d
for(i in 1:nrow(d)){d1$FDIAB[i] <- 1}

dd <- rbind(d0,d1)

for(i in 1:nrow(dd)){
  if(substr(dd$Var1[i],2,2)=='1'){
    dd$FCHF[i]=1}
    else
      dd$FCHF[i]=0
  if(substr(dd$Var1[i],3,3)=='1'){
    dd$FCREAT[i]=1}
    else
      dd$FCREAT[i]=0
  if(substr(dd$Var1[i],4,4)=='1'){
      dd$MALE[i]=1}
    else
      dd$MALE[i]=0
}


res.cox <- coxph(Surv(CATHTIME,CENSORED==0)~ FCREAT+FCHF+FDIAB+MALE,data=data)
fit <- survfit(res.cox, newdata = dd)

sur_0 <- fit$surv[,1]*d0$Freq[1]/nrow(data)

for (i in 2:nrow(d0)) {
  sur_0 <- sur_0+fit$surv[,i]*dd$Freq[i]/nrow(data)
}
sur_0 <- data.frame(sur_0)

n <- nrow(d0)+2
m <- nrow(d0)+1
sur_1 <- fit$surv[,m]*d1$Freq[1]/nrow(data)
for (i in n:nrow(dd)) {
  sur_1 <- sur_1+fit$surv[,i]*dd$Freq[i]/nrow(data)
}
sur_1 <- data.frame(sur_1)


res.cox_unadjusted <- coxph(Surv(CATHTIME,CENSORED==0)~ FDIAB,data=data)

inrisk <- data.frame(FDIAB = c(0,1))
inrisk

fit_unadjusted <- survfit(res.cox_unadjusted, newdata = inrisk)

#plot
time <- data.frame(fit$time)
surwt0 <- data.frame(sur_0)
surwt1 <- data.frame(sur_1)
surcrd0 <- data.frame(fit_unadjusted$surv[,1])
surcrd1 <- data.frame(fit_unadjusted$surv[,2])
sur <- cbind(time,surwt0,surwt1,surcrd0,surcrd1)

Length_of_survival <- fit$time

g <- ggplot(sur,aes(x=Length_of_survival))+ geom_line(aes(y=sur_0,color="2")) + geom_line(aes(y=sur_1,color="3"))+geom_line(aes(y=fit_unadjusted.surv...1.,color="4"))+geom_line(aes(y=fit_unadjusted.surv...2.,color="5"))  
g + ggtitle("Corrected Group Prognosis Method") + scale_colour_discrete(labels=c("no diabetes-Adjusted", "diabetes-Adjusted","no diabetes", "diabetes"))

