###Libraries
library(lme4)
library(lmerTest)
library(MuMIn)

###Model-4: Build latency model

Table<-read.csv('model_4.csv')

#remove top 1% outliers
outliers<-quantile(Table$avgBuildLatency,0.99)
Table_final<-subset(Table,Table$avgBuildLatency<outliers)

#We used effect coding to set the contrasts of this three-way factor, 
#i.e., comparing each level to the grand mean of all three levels.
#In practice, we change the order of the three levels and run 
#the model twice to get the coefficients of all three workflows.
Table_final$workflow<-factor(Table_final$workflow,levels = c("Circle","Travis","Docker"))
#Table_final$workflow<-factor(Table_final$workflow,levels = c("Circle","Docker","Travis"))


#run modeling
model_4<- lmer(scale(log(avgBuildLatency))~ 
                  scale(totalCommits)
                 +scale(ageAtCD)
                 +scale(totalBuilds)
                 +timeFlag
                 +scale(nIssuesOfDockerfile)
                 +scale(nLinesOfDockerfile)
                 +factor(workflow)
                 +(1 | baseImage), data=Table_final,REML=FALSE)

#Results
summary(model_4)
anova(model_4)
r.squaredGLMM(model_4)

#We employ multiple hypothesis correction over all coefficient results,
#to correct for false positives, using the Benjamini-Hochberg step-down procedure.
pvec_all = summary(model_4)$coefficients[,5]
pvec_corrected = p.adjust(pvec_all, "BH")
pvec_corrected
