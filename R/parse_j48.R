#' Parse text of j48 output
#'
#' @description Uses simple regex to extract the most valuable information from
#' the j48 classifier output.
#'
#' @param model
#' Output of j48()
#' @example
#' # Not Run
#' # output <- j48(cmd)
#' # models <- parse_j48(output)
#' @export
parse_j48 <- function(model){
  result <- list(); res <- list()
  for(i in seq_along(as.vector(sapply(model, length)))){
    correct <- grep("Correctly Classified Instances", model[[i]], val=T)
    ii = 1; ii2 = 2
    t1 <- read.table(text = gsub(";$", "", gsub(" %|[[:space:]]{2,}", ";", correct[[ii]])), sep = ";")
    t2 <- read.table(text = gsub(";$", "", gsub(" %|[[:space:]]{2,}", ";", correct[[ii2]])), sep = ";")
    correct <- rbind(t1, t2)[,-4]
    names(correct) <- c("Desc", "Instances Amount", "Percentage")
    
    number_leaves <- as.numeric(
      gsub("[^[:digit:]]*", "", grep("Number of Leaves", model[[i]], value = TRUE))
    )
    tree_size <- as.numeric(
      gsub("[^[:digit:]]*", "", grep("Size of the tree", model[[i]], value = TRUE))
    )
    mean_absolute_error <- as.numeric(
      gsub("[[A-Za-z]]*", "", grep("Mean absolute error", model[[i]], value = TRUE))
    )
    number_instances <- as.numeric(
      gsub("[^[:digit:]]*", "", grep("Total Number of Instances", model[[i]], value = TRUE))
    )
    
    options <- gsub("Options: | $", "", grep("Options.*", model[[i]], value = TRUE))
    
    tree_st <- grep("J48 pruned tree", model[[i]])
    tree_end <- grep("Number of Leaves", model[[i]]); tree_end <- (tree_end - 1)
    tree <- list(tree=model[[i]][tree_st:tree_end])
    
    result <- list(options=options, tree=tree, correct=correct, 
                   number_leaves=number_leaves, tree_size=tree_size,
                   mean_absolute_error=mean_absolute_error, 
                   number_instances=number_instances)
    res[[i]] <- result
  }
  res
}