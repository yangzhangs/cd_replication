###Libraries
library(lme4)
library(lmerTest)
library(MuMIn)

###Model-4: Build latency model

Table<-read.csv('model_4.csv')

#remove top 1% outliers
outliers<-quantile(Table$avgBuildLatency,0.99)
Table_final<-subset(Table,Table$avgBuildLatency<outliers)

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
