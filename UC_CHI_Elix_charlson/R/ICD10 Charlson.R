#The program is to define Charlson comorbidities based on ICD-10 diagnosis codes
#programmed by Zhaoyu(Mani) Liu. Email:zhaoyu.liu@ucalgary.ca

#Change the variable name and total number of diagnosis codes if necessary.
#In this program, the first diagnosis(main diagnosis) is DXCODE1, the second DXCODE2, third DXCODE3... 
#And there are 25 diagnosis codes(DXCODE1-DXCODE25).

df <- read.csv("C:/Users/zhaoyu.liu/OneDrive - University of Calgary/chi survival/ManiSample.csv")
#change to your own library

ICD10_CH <- data.frame(ID = 1:nrow(df))
column_name <- c()  

  #Myocardial Infarction
  DIS1 <- 'MI'
  DC1 <- c('I21','I22','I252')
  LBL1 <- 'Myocardial Infarction'
  
  #Congestive Heart Failure
  DIS2 <- 'CHF'
  DC2 <- c('I43','I50','I099','I110','I130','I132',
           'I255','I420','I425','I426','I427','I428','I429','P290')
  LBL2 <- 'Congestive Heart Failure'
  
  #Periphral Vascular Disease
  DIS3 <- 'PVD'
  DC3 <- c('I70','I71', 'I731','I738','I739','I771',
           'I790','I792','K551','K558','K559','Z958','Z959')
  LBL3 <- 'Periphral Vascular Disease'  

  #Cerebrovascular Disease
  DIS4 <- 'CEVD'
  DC4 <- c('G45','G46','I60','I61','I62','I63','I64','I65','I66','I67','I68','I69','H340')
  LBL4 <- 'Cerebrovascular Disease'  
  
  #Dementia
  DIS5 <- 'DEM'
  DC5 <- c('F00','F01','F02','F03','G30','F051','G311')
  LBL5 <- 'Dementia' 
  
  #Chronic Pulmonary Disease
  DIS6 <- 'COPD'
  DC6 <- c('J40','J41','J42','J43','J44','J45','J46','J47',
           'J60','J61','J62','J63','J64','J65','J66','J67',
           'I278','I279','J684','J701','J703')
  LBL6 <- 'Chronic Pulmonary Disease' 
  
  #Connective Tissue Disease-Rheumatic Disease
  DIS7 <- 'Rheum'
  DC7 <- c('M05','M32','M33','M34','M06','M315','M351','M353','M360')
  LBL7 <- 'Rheumatic Disease'

  #Peptic Ulcer Disease
  DIS8 <- 'PUD'
  DC8 <- c('K25','K26','K27','K28')
  LBL8 <- 'Peptic Ulcer Disease' 
  
  #Mild Liver Disease
  DIS9 <- 'MILDLD'
  DC9 <- c('B18','K73','K74','K700','K701','K702','K703','K709',
           'K717','K713','K714','K715','K760','K762','K763','K764','K768','K769','Z944')
  LBL9 <- 'Mild Liver Disease'   
  
  #Diabetes without complications
  DIS10 <- 'DIAB_UC'
  DC10 <- c('E100','E101','E106','E108','E109','E110','E111','E116','E118','E119',
            'E120','E121','E126','E128','E129',
            'E130','E131','E136','E138','E139',
            'E140','E141','E146','E148','E149')
  LBL10 <- 'Diabetes without complications'     

  #Diabetes with complications
  DIS11 <- 'DIAB_C'
  DC11 <- c('E102','E103','E104','E105','E107',
            'E112','E113','E114','E115','E117',
            'E122','E123','E124','E125','E127',
            'E132','E133','E134','E135','E137',
            'E142','E143','E144','E145','E147')
  LBL11 <- 'Diabetes with complications'    
  
  #Paraplegia and Hemiplegia
  DIS12 <- 'PARA'
  DC12 <- c('G81','G82','G041','G114','G801','G802',
            'G830','G831','G832','G833','G834','G839')
  LBL12 <- 'Paraplegia and Hemiplegia' 
  
  #Renal Disease
  DIS13 <- 'RD'
  DC13 <- c('N18','N19','N052','N053','N054','N055','N056','N057',
            'N250','I120','I131','N032','N033','N034','N035','N036','N037',
            'Z490','Z491','Z492','Z940','Z992')
  LBL13 <- 'Renal Disease'   
  
  #Cancer
  DIS14 <- 'CANCER'
  DC14 <- c('C00','C01','C02','C03','C04','C05','C06','C07','C08','C09',
            'C10','C11','C12','C13','C14','C15','C16','C17','C18','C19',
            'C20','C21','C22','C23','C24','C25','C26',
            'C30','C31','C32','C33','C34','C37','C38','C39',
            'C40','C41','C43','C45','C46','C47','C48','C49',
            'C50','C51','C52','C53','C54','C55','C56','C57','C58',
            'C60','C61','C62','C63','C64','C65','C66','C67','C68','C69',
            'C70','C71','C72','C73','C74','C75','C76',
            'C81','C82','C83','C84','C85','C88',
            'C90','C91','C92','C93','C94','C95','C96','C97')
  LBL14 <- 'Cancer'   
  
  #Moderate or Severe Liver Disease
  DIS15 <- 'MSLD'
  DC15 <- c('K704','K711','K721','K729','K765','K766','K767','I850','I859','I864','I982')
  LBL15 <- 'Moderate or Severe Liver Disease' 
  
  #Metastatic Carcinoma
  DIS16 <- 'METS'
  DC16 <- c('C77','C78','C79','C80')
  LBL16 <- 'Metastatic Carcinoma'   
  
  #AIDS/HIV
  DIS17 <- 'HIV'
  DC17 <- c('B20','B21','B22','B24')
  LBL17 <- 'AIDS/HIV'     
  
  cols <- paste("DXCODE",1:25,sep="") # DAD has 25 dxcodes
  
  icd10 <- df[cols]
  
  for(i in 1:17){
    v <- vector(length = nrow(icd10))
    for(s in 3:5){
      test <- data.frame(apply(icd10,1,function(x) any(substr(x,1,s)%in% get(paste("DC",i,sep=""))))==TRUE)
      v <- cbind(v,test)
    }
    v <- data.frame(apply(v,1,function(x) any(x)==TRUE))
    one <- get(paste("DIS",i,sep=""))
    two <- paste("ICD10_", one, sep="")
    ICD10_CH <- cbind(ICD10_CH,v)
    column_name <- c(column_name, two)
  }

#Changing column names
column <- c("ID",column_name)
colnames(ICD10_CH) = column


#Calculating Charlson index
ICD10_CH$Charlson_index <- data.frame(apply(ICD10_CH,1,function(x) sum(x[2:11])*1+sum(x[12:15])*2+x[16]*3+x[17]*6+x[18]*6))

