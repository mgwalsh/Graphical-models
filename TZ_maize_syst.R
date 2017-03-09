#' log-linear interaction models of Tanzania MobileSurvey "maize system" data, 2016
#' M. Walsh, March 2017
 
# install.packages(c("downloader","gRim","statnet"), dependencies=T)
suppressPackageStartupMessages({
  require(downloader)
  require(gRim)
  require(statnet)
})

# Data setup --------------------------------------------------------------
# Create a data folder in your current working directory
dir.create("MS_data", showWarnings=F)
setwd("./MS_data")

# Download 
download("https://www.dropbox.com/s/3sx5m2cu4cyi37g/maize_system.csv?raw=1", "maize_system.csv", mode="wb")
maize <- read.table("maize_system.csv", header=T, sep=",")
maize <- maize[,4:11]
dim(maize)

gm1 <- dmod(~.^., data = maize)
gm2 <- stepwise(gm1)

dag <- ugList(terms(gm2), result="matrix")
net <- as.network(x = dag, directed = FALSE, loops = FALSE, matrix.type = "adjacency")
plot.network(net, vertex.col = "white", vertex.cex = 8, displaylabels = T, label.pos = 5, mode = "circle")
