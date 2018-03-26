#We employ multiple hypothesis correction over all coefficient results,
#to correct for false positives, using the Benjamini-Hochberg step-down procedure.
pvec_model_1 = summary(model_1)$coefficients[,5]
pvec_model_2 = summary(model_2)$coefficients[,5]
pvec_model_3 = summary(model_3)$coefficients[,5]
pvec_model_4 = summary(model_4)$coefficients[,5]

pvec_all = c(pvec_model_1,pvec_model_2,pvec_model_3,pvec_model_4)
pvec_corrected = p.adjust(pvec_all, "BH")
pvec_corrected
