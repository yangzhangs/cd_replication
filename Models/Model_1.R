###Libraries
library(lme4)
library(lmerTest)
library(MuMIn)

###Model-1: Release frequency model

Table<-read.csv('model_1.csv')

#remove top 1% outliers
outliers<-quantile(Table$nSuccessBuild,0.99)
Table_final<-subset(Table,Table$nSuccessBuild<outliers)

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
