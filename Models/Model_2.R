###Libraries
library(lme4)
library(lmerTest)
library(MuMIn)

###Model-2: Build results model

Table<-read.csv('model_2.csv')

#remove top 1% outliers
outliers<-quantile(Table$nErrorBuild,0.99)
Table_final<-subset(Table,Table$nErrorBuild<outliers)

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
