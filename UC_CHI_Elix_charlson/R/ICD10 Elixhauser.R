#The program is to define Elixhauser comorbidities based on ICD-10 diagnosis codes
#programmed by Zhaoyu(Mani) Liu. Email:zhaoyu.liu@ucalgary.ca

#Change the variable name and total number of diagnosis codes if necessary.
#In this program, the first diagnosis(main diagnosis) is DXCODE1, the second DXCODE2, third DXCODE3... 
#And there are 25 diagnosis codes(DXCODE1-DXCODE25).

df <- read.csv("C:/Users/zhaoyu.liu/OneDrive - University of Calgary/chi survival/ManiSample.csv")
#change to your own library

ICD10_EX <- data.frame(ID = 1:nrow(df))
column_name <- c()  

#Congestive Heart Failure
DIS1 <- 'CHF'
DC1 <- c('I43','I50','I099','I110','I130','I132',
         'I255','I420','I425','I426','I427','I428','I429','P290')
LBL1 <- 'Congestive Heart Failure'

#Caridiac Arrhythmia
DIS2 <- 'Arrhy'
DC2 <- c('I441','I442','I443','I456','I459','I47','I48','I49','R000','R001','R008','T821','Z450','Z950')
LBL2 <- 'Caridiac Arrhythmia'

#Valvular Disease
DIS3 <- 'VD'
DC3 <- c('A520','I05','I06','I07','I08','I091','I098','I34','I35','I36','I37','I38','I39','Q230','Q231','Q232','Q233','Z952','Z953','Z954')
LBL3 <- 'Valvular Disease'  

#Pulmonary Circulation Disorders
DIS4 <- 'PCD'
DC4 <- c('I26','I27','I280','I288','I289')
LBL4 <- 'Pulmonary Circulation Disorders'  

#Periphral Vascular Disease
DIS5 <- 'PVD'
DC5 <- c('I70','I71', 'I731','I738','I739','I771',
         'I790','I792','K551','K558','K559','Z958','Z959')
LBL5 <- 'Periphral Vascular Disease' 

#Hypertension Uncomlicated
DIS6 <- 'HPTN_UC'
DC6 <- c('I10')
LBL6 <- 'Hypertension Uncomlicated'    

#Hypertension comlicated
DIS7 <- 'HPTN_C'
DC7 <- c('I11','I12','I13','I15')
LBL7 <- 'Hypertension comlicated'

#Paralysis
DIS8 <- 'Para'
DC8 <- c('G041','G114','G801','G802','G81','G82','G830','G831','G832','G833','G834','G839')
LBL8 <- 'Paralysis'

#Other Neurological Disorders
DIS9 <- 'OthND'
DC9 <- c('G10','G11','G12','G13','G20','G21','G22','G254','G255','G312','G318','G319','G32','G35','G36','G37','G40','G41','G931','G934','R470','R56')
LBL9 <- 'Other Neurological Disorders' 

#Chronic Pulmonary Disease
DIS10 <- 'COPD'
DC10 <- c('I278','I279','J40','J41','J42','J43','J44','J45','J46','J47','J60','J61','J62','J63','J64','J65','J66','J67','J684','J701','J703')
LBL10 <- 'Chronic Pulmonary Disease'

#Diabetes Uncomplicated
DIS11 <- 'DIAB_UC'
DC11 <- c('E100','E101','E109','E110','E111','E119','E120','E121','E129','E130','E131','E139','E140','E141','E149')
LBL11 <- 'Diabetes Uncomplicated'     

#Diabetes Complicated
DIS12 <- 'DIAB_C'
DC12 <- c('E102','E103','E104','E105','E106','E107','E108','E112','E113','E114','E115','E116','E117','E118','E122','E123','E124','E125','E126','E127','E128','E132','E133','E134','E135','E136','E137','E138','E142','E143','E144','E145','E146','E147','E148')
LBL12 <- 'Diabetes Complicated'

#Hypothyroidism
DIS13 <- 'Hptothy'
DC13 <- c('E00','E01','E02','E03','E890')
LBL13 <- 'Hypothyroidism'

#Renal Failure
DIS14 <- 'RF'
DC14 <- c('I120','I131','N18','N19','N250','Z490','Z491','Z492','Z940','Z992')
LBL14 <- 'Renal Failure'

#Liver Disease
DIS15 <- 'LD'
DC15 <- c('B18','I85','I864','I982','K70','K711','K713','K714','K715','K717','K72','K73','K74','K760','K762','K763','K764','K765','K766','K767','K768','K769','Z944')
LBL15 <- 'Liver Disease'

#Peptic Ulcer Disease excluding bleeding
DIS16 <- 'PUD_NB'
DC16 <- c('K257','K259','K267','K269','K277','K279','K287','K289')
LBL16 <- 'Peptic Ulcer Disease excluding bleeding' 

#AIDS/HIV
DIS17 <- 'HIV'
DC17 <- c('B20','B21','B22','B24')
LBL17 <- 'AIDS/HIV' 

#Lymphoma
DIS18 <- 'Lymp'
DC18 <- c('C81','C82','C83','C84','C85','C88','C96','C900','C902')
LBL18 <- 'Lymphoma' 

#Metastatic Carcinoma
DIS19 <- 'METS'
DC19 <- c('C77','C78','C79','C80')
LBL19 <- 'Metastatic Carcinoma'

#Solid Tumor without Metastasis
DIS20 <- 'Tumor'
DC20 <- c('C00','C01','C02','C03','C04','C05','C06','C07','C08','C09','C10','C11','C12','C13','C14','C15','C16','C17','C18','C19','C20','C21','C22','C23','C24','C25','C26','C30','C31','C32','C33','C34','C37','C38','C39','C40','C41','C43','C45','C46','C47','C48','C49','C50','C51','C52','C53','C54','C55','C56','C57','C58','C60','C61','C62','C63','C64','C65','C66','C67','C68','C69','C70','C71','C72','C73','C74','C75','C76','C97')
LBL20 <- 'Solid Tumor without Metastasis'

#Rheumatoid Arthsitis/collagen
DIS21 <- 'Rheum_A'
DC21 <- c('L940','L941','L943','M05','M06','M08','M120','M123','M30','M310','M311','M312','M313','M32','M33','M34','M35','M45','M461','M468','M469')
LBL21 <- 'Rheumatoid Arthsitis/collagen'

#Coagulopathy
DIS22 <- 'Coag'
DC22 <- c('D65','D66','D67','D68','D691','D693','D694','D695','D696')
LBL22 <- 'Coagulopathy'

#Obesity
DIS23 <- 'Obesity'
DC23 <- c('E66')
LBL23 <- 'Obesity'

#Weight Loss
DIS24 <- 'WL'
DC24 <- c('E40','E41','E42','E43','E44','E45','E46','R634','R64')
LBL24 <- 'Weight Loss'

#Fluid and Ecletrolyte Disorders
DIS25 <- 'Fluid'
DC25 <- c('E222','E86','E87')
LBL25 <- 'Fluid and Ecletrolyte Disorders'

#Blood Loss Anemia
DIS26 <- 'BLA'
DC26 <- c('D500')
LBL26 <- 'Blood Loss Anemia'

#Deficiency Anemia
DIS27 <- 'DA'
DC27 <- c('D508','D509','D51','D52','D53')
LBL27 <- 'Deficiency Anemia'

#Alcohol Abuse
DIS28 <- 'Alcohol'
DC28 <- c('F10','E52','G621','I426','K292','K700','K703','K709','T51','Z502','Z714','Z721')
LBL28 <- 'Alcohol Abuse'

#Drug Abuse
DIS29 <- 'Drug'
DC29 <- c('F11','F12','F13','F14','F15','F16','F18','F19','Z715','Z722')
LBL29 <- 'Drug Abuse'

#Psychoses
DIS30 <- 'Psycho'
DC30 <- c('F20','F22','F23','F24','F25','F28','F29','F302','F312','F315')
LBL30 <- 'Psychoses'

#Depression
DIS31 <- 'Dep'
DC31 <- c('F204','F313','F314','F315','F32','F33','F341','F412','F432')
LBL31 <- 'Depression'

cols <- paste("DXCODE",1:25,sep="") # DAD has 25 dxcodes

icd10 <- df[cols]

for(i in 1:31){ #ICD10 Elixhauser: 31 groups
  v <- vector(length = nrow(icd10))
  for(s in 3:5){
    test <- data.frame(apply(icd10,1,function(x) any(substr(x,1,s)%in% get(paste("DC",i,sep=""))))==TRUE)
    v <- cbind(v,test)
  }
  v <- data.frame(apply(v,1,function(x) any(x)==TRUE))
  one <- get(paste("DIS",i,sep=""))
  two <- paste("ICD10_", one, sep="")
  ICD10_EX <- cbind(ICD10_EX,v)
  column_name <- c(column_name, two)
}

#Changing column names
column <- c("ID",column_name)
colnames(ICD10_EX) = column

