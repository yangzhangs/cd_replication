###Libraries
library(lme4)
library(lmerTest)
library(MuMIn)

###Model-2: Build results model

Table<-read.csv('model_2.csv')

#remove top 1% outliers
outliers<-quantile(Table$nErrorBuild,0.99)
Table_final<-subset(Table,Table$nErrorBuild<outliers)

#We used effect coding to set the contrasts of this three-way factor, 
#i.e., comparing each level to the grand mean of all three levels.
#In practice, we change the order of the three levels and run 
#the model twice to get the coefficients of all three workflows.
Table_final$workflow<-factor(Table_final$workflow,levels = c("Circle","Travis","Docker"))
#Table_final$workflow<-factor(Table_final$workflow,levels = c("Circle","Docker","Travis"))


#run modeling
model_2<- lmer(scale(log(nErrorBuild))~ 
                  scale(totalCommits)
                 +scale(ageAtCD)
                 +scale(totalBuilds)
                 +timeFlag
                 +scale(nIssuesOfDockerfile)
                 +scale(nLinesOfDockerfile)
                 +factor(workflow)
                 +(1 | baseImage), data=Table_final,REML=FALSE)

#Results
summary(model_2)
anova(model_2)
r.squaredGLMM(model_2)

#We employ multiple hypothesis correction over all coefficient results,
#to correct for false positives, using the Benjamini-Hochberg step-down procedure.
pvec_all = summary(model_2)$coefficients[,5]
pvec_corrected = p.adjust(pvec_all, "BH")
pvec_corrected
