#' Parse j48 text output 
#' 
#' @description
#' Uses regex to convert a j48() output to a list() with most important information
#' 
#' @param model
#' output of j48(cmd)
#' 
#' @export
parse_j48 <- function (model){
    correct <- grep("Correctly Classified Instances", model, val = T)
    t1 <- read.table(text = gsub(";$", "", 
                                 gsub(" %|[[:space:]]{2,}", ";", correct[[1]])), sep = ";")
    t2 <- read.table(text = gsub(";$", "", 
                                 gsub(" %|[[:space:]]{2,}", ";", correct[[2]])), sep = ";")
    correct <- rbind(t1, t2)[,-4]
    names(correct) <- c("Desc", "Instances Amount", "Percentage")
    number_leaves <- as.numeric(gsub("[^[:digit:]]*", "", 
                                     grep("Number of Leaves", model[[i]], value = TRUE)))
    tree_size <- as.numeric(gsub("[^[:digit:]]*", "", grep("Size of the tree", 
                                                           model, value = TRUE)))
    mean_absolute_error <- 
      as.numeric(gsub("[[A-Za-z]]*","", grep("Mean absolute error", model, value = TRUE)))
    number_instances <- 
      as.numeric(gsub("[^[:digit:]]*", "", grep("Total Number of Instances", model, value = TRUE)))
    
    options <- gsub("Options: | $", "", grep("Options.*", model))
    
    tree_st <- grep("J48 pruned tree", model)
    tree_end <- grep("Number of Leaves", model); tree_end <- (tree_end - 1)
    tree <- model[tree_st:tree_end]
      
    result <- list(correct = correct, number_leaves = number_leaves, 
                   tree_size = tree_size, mean_absolute_error = mean_absolute_error, 
                   number_instances = number_instances, options=options, tree=tree)
    result
}