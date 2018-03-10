###Libraries
library(lme4)
library(lmerTest)
library(MuMIn)

###Model-1: Release frequency model

Table<-read.csv('model_1.csv')

#remove top 1% outliers
outliers<-quantile(Table$nSuccessBuild,0.99)
Table_final<-subset(Table,Table$nSuccessBuild<outliers)

#We used effect coding to set the contrasts of this three-way factor, 
#i.e., comparing each level to the grand mean of all three levels.
#In practice, we change the order of the three levels and run 
#the model twice to get the coefficients of all three workflows.
Table_final$workflow<-factor(Table_final$workflow,levels = c("Circle","Travis","Docker"))
#Table_final$workflow<-factor(Table_final$workflow,levels = c("Circle","Docker","Travis"))


#run modeling
model_1<- lmer(scale(log(nSuccessBuild))~ 
                  scale(totalCommits)
                 +scale(ageAtCD)
                 +scale(totalBuilds)
                 +timeFlag
                 +scale(nIssuesOfDockerfile)
                 +scale(nLinesOfDockerfile)
                 +factor(workflow)
                 +(1 | baseImage), data=Table_final,REML=FALSE)

#Results
summary(model_1)
anova(model_1)
r.squaredGLMM(model_1)

#We employ multiple hypothesis correction over all coefficient results,
#to correct for false positives, using the Benjamini-Hochberg step-down procedure.
pvec_all = summary(model_1)$coefficients[,5]
pvec_corrected = p.adjust(pvec_all, "BH")
pvec_corrected
