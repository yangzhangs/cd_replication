#We employ multiple hypothesis correction over all coefficient results,
#to correct for false positives, using the Benjamini-Hochberg step-down procedure.
pvec_modle_1 = summary(model_1)$coefficients[,5]
pvec_modle_2 = summary(model_2)$coefficients[,5]
pvec_modle_3 = summary(model_3)$coefficients[,5]
pvec_modle_4 = summary(model_4)$coefficients[,5]

pvec_all = c(pvec_modle_1,pvec_modle_2,pvec_modle_3,pvec_modle_4)
pvec_corrected = p.adjust(pvec_all, "BH")
pvec_corrected
