#=========================================================================================================================================
#' Detects vulnerable nodes (VNs) based on five-point summary of boxplot
#'
#' This function detects vulnerable nodes (VNs) based on five-point summary of boxplot.
#' It takes first input a numeric vector of topological values for all nodes; whereas,
#' second a keyword for topological property based on which users want to identify VNs.
#' Different keywords for nine topological properties implemented in NetVA current version 
#' are as follows: ANC (Average node connectivity), ND (Network density), NC (Network 
#' centralization), APL (Average path length), BET (Betweenness), AP (Articulation 
#' point), NDR (Network diameter), CC (Clustering coefficient), and HET (Heterogeneity).
#'
#' @param v Character vector containing names for all nodes of the given network.
#' @param x Numeric vector containing values of one topological property for all nodes of the given network. Where, the length of 
#' v and x should be equal. Note: v and x should be in the same order i.e. position of one particular node in v and position of value of 
#' topological property for that node in x should be the same.
#' @param p Case sensitive. Keyword for topological property based on which users want to identify VNs. Keyword should be one from the 
#' following keywords: ANC (Average node connectivity), ND (Network density), NC (Network centralization), APL (Average path length), BET 
#' (Betweenness), AP (Articulation point), NDR (Network diameter), CC (Clustering coefficient), and HET (Heterogeneity).
#' @return A character vector containing all possible VNs.
#' @export
detectVNs <- function(v, x, p){
	n <- length(x)
	Q2 <- median(x)
	if((n%%2) == 0){
		Q1 <- median(sort(x, decreasing=F)[1:(n/2)])
		Q3 <- median(sort(x, decreasing=F)[((n/2)+1):n])
	}else{
		Q1 <- median(sort(x, decreasing=F)[1:((n-1)/2)])
		Q3 <- median(sort(x, decreasing=F)[(((n-1)/2)+2):n])
	}
	IQR <- Q3 - Q1
	
	if(p == "ANC"){
		lower.limit <- Q1 - 1.5*IQR
		out <- which(x < lower.limit)
	}else if(p == "ND"){
		lower.limit <- Q1 - 1.5*IQR
		out <- which(x < lower.limit)
	}else if(p == "NC"){
		lower.limit <- Q1 - 1.5*IQR
		out <- which(x < lower.limit)
	}else if(p == "APL"){
		upper.limit <- Q3 + 1.5*IQR
		out <- which(x > upper.limit)
	}else if(p == "BET"){
		lower.limit <- Q1 - 1.5*IQR
		out <- which(x < lower.limit)
	}else if(p == "AP"){
		upper.limit <- Q3 + 1.5*IQR
		out <- which(x > upper.limit)
	}else if(p == "NDR"){
		upper.limit <- Q3 + 1.5*IQR
		out <- which(x > upper.limit)
	}else if(p == "CC"){
		lower.limit <- Q1 - 1.5*IQR
		out <- which(x < lower.limit)
	}else if(p == "HET"){
		lower.limit <- Q1 - 1.5*IQR
		out <- which(x < lower.limit)
	}else{
		cat("Invalid value for p!\n")
	}
	vn = v[out]
	return(vn)
}


