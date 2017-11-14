###Libraries
library(lme4)
library(lmerTest)
library(MuMIn)

###Model-3: Configuration stability model

Table<-read.csv('model_3.csv')

#remove top 1% outliers
outliers<-quantile(Table$nDockerfileChanges,0.99)
Table_final<-subset(Table,Table$nDockerfileChanges<outliers)

#run modeling
model_3<- lmer(scale(log(nDockerfileChanges))~ 
                  scale(totalCommits)
                 +scale(ageAtCD)
                 +scale(totalBuilds)
                 +timeFlag
                 +scale(nIssuesOfDockerfile)
                 +scale(nLinesOfDockerfile)
                 +factor(workflow)
                 +(1 | baseImage), data=Table_final,REML=FALSE)

#Results
summary(model_3)
anova(model_3)
r.squaredGLMM(model_3)
