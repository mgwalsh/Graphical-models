# Wine dataframe from gRbase package

library(gRim)
library(Rgraphviz)

data(wine, package="gRbase")
head(wine)
dim(wine)

wine <- cbind(Cult=wine[,1],
              as.data.frame(lapply(wine[-1], cut, 2, labels=c('L','H'))))
head(wine)
dim(xtabs(~.,wine))
wine <- wine[,1:4]
dim(xtabs(~.,wine))

mm <- dmod(~Cult:Alch+Alch:Mlca:Ash, data=wine)
mm <- dmod(list(c("Cult","Alch"), c("Alch","Mlca","Ash")), data=wine)
mm <- dmod(~C:Alc+Alc:M:As, data=wine)
mm
formula(mm)

plot(mm, fillcolor="white")

DG <- ugList(terms(mm))
DG
plot(DG)
ugList(terms(mm), result="matrix")

x11()
par(mfrow=c(1,1), mar=c(4,4,1,1))
plot(DG)
dev.copy(pdf, 'graph.pdf')
dev.off()
