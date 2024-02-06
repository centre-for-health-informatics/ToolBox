# Elixhauser_charlson

# ICD10 – ICD9 Elixhauser/Charlson coding

Abstract

Objectives: Implementation of the International Statistical Classification of Disease and Related Health Problems, 10th Revision (ICD- 10) coding system presents challenges for using administrative data. Recognizing this, we conducted a multistep process to develop ICD-10 coding algorithms to define Charlson and Elixhauser comorbidities in administrative data and assess the performance of the resulting algorithms.

Methods: ICD-10 coding algorithms were developed by " translation” of the ICD-9-CM codes constituting Deyo’s (for Charlson comorbidities) and Elixhauser’s coding algorithms and by physicians’ assessment of the face-validity of selected ICD-10 codes. The process of carefully developing ICD-10 algorithms also produced modified and enhanced ICD-9-CM coding algorithms for the Charlson and Elixhauser comorbidities. We then used data on in-patients aged 18-years and older in ICD-9-CM and ICD-10 administrative hospital discharge data from a Canadian health region to assess the comorbidity frequencies and the mortality prediction achieve by the original ICD-9-CM algorithms, the enhanced ICD-9-CM algorithms, and the new ICD-10 coding algorithms.

Results: Among 56,585 patients in the ICD-9-CM data and 58,805 patients in the ICD-10 data, frequencies of the 17 Charlson comorbidities and the 30 Elixhauser comorbidities remailed generally similar across algorithms. The new ICD-10 and enhanced ICD-9-CM coding algorithms either matched or outperformed the original Deyo and Elixhauser ICD-9-CM coding algorithms in predicting in-hospital mortality. The C-statistic was 0.842 for Deyo’s ICD-9-CM coding algorithm, 0.860 for the ICD-10 coding algorithm, and 0.859 for the enhanced ICD-9-CM coding algorithm, 0.868 for the original Elixhauser ICD-9-CM coding algorithm, 0.870 for the ICD-10 coding algorithm and 0.878 for the enhanced ICD-9-CM cording algorithm.

Conclusions: These newly developed ICD-10 and ICD-9-CM comorbidity coding algorithms produce similar estimates of comorbidity prevalence in administrative data, and may outperform existing ICD-9-CM coding algorithms.

There are 4 codes documents:

1. ICD10_charlson - This is simple translation of ICD-9-CM codes to ICD-10 for Charlson
2. ICD10_Elix - This is simple translation of ICD-9-CM codes to ICD-10 for Elixhauser
3. ICD10_enhanced_charlson - New enhanced version of Charlson algorithm
4. ICD10_enhanced_elix - New enhanced version of Elixhauser algorithm
