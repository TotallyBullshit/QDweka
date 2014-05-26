#' Create bash command for weka's J48
#'
#' @param C
#' Cofidence Factor
#' @param M
#' Amount of observations per leaf
#' @param data
#' data/zaraza.arff
#' @param CLASSPATH
#' export CLASSPATH=/pathtoweka/weka-3-7-11/weka.jar
#' @export
cmd_j48 <- function(C, M, data = "data/glass.arff", CLASSPATH = "export CLASSPATH=/Users/mbtangotan/Desktop/weka-3-7-11/weka.jar"){
  id <- seq_along(C)
  CP <- CLASSPATH
  cmd <- sprintf("java weka.classifiers.trees.J48 -C %s -M %s -t data/glass.arff -x 10 > results%s.txt", 
                 C, M, id)
  cmd <- paste(CP, cmd, sep = ";")
  cm <- list(id=id, cmd=cmd)
  cm
}