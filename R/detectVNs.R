#=========================================================================================================================================
#' Detects vulnerable nodes (VNs) based on five-point summary of boxplot
#'
#' This function detects vulnerable nodes (VNs) based on five-point summary of boxplot.
#' It takes first input a numeric vector of topological values for all nodes; whereas, second input is a keyword for topological property 
#' based on which users want to identify VNs.
#'
#' Different keywords for fourteen topological properties implemented in NetVA current version are as follows: 
#' ANC (Average node connectivity), NDE (Network density), NCE (Network centralization), APL (Average path length), ABC (Average 
#' betweenness), ACC (Average closeness), APN (Articulation point), NDI (Network diameter), CCO (Clustering coefficient), GEF (Global 
#' efficiency), COH (Cohesiveness), COM (Compactness), AEC (Average eccentricity), and HET (Heterogeneity).
#'
#' @param v Character vector containing names for all nodes of the given network.
#' @param t Numeric vector containing values of one topological property for all nodes of the given network. Where, the length of 
#' v and t should be equal. Note: v and t should be in the same order i.e. position of one particular node in v and position of value of 
#' topological property for that node in t should be the same.
#' @param p Case sensitive. Keyword for topological property based on which users want to identify VNs. Keyword should be one from the 
#' following keywords: ACC (Average closeness), ANC (Average node connectivity), NDE (Network density), NCE (Network centralization), APL 
#' (Average path length), ABC (Average betweenness), APN (Articulation point), NDI (Network diameter), CCO (Clustering coefficient), GEF 
#' (Global efficiency), COH (Cohesiveness), COM (Compactness), AEC (Average eccentricity), and HET (Heterogeneity).
#' @return A character vector containing all possible VNs.
#' @export
detectVNs <- function(v, t, p){
	n <- length(t)
	Q2 <- stats::median(t)
	if((n%%2) == 0){
		Q1 <- stats::median(sort(t, decreasing=F)[1:(n/2)])
		Q3 <- stats::median(sort(t, decreasing=F)[((n/2)+1):n])
	}else{
		Q1 <- stats::median(sort(t, decreasing=F)[1:((n-1)/2)])
		Q3 <- stats::median(sort(t, decreasing=F)[(((n-1)/2)+2):n])
	}
	IQR <- Q3 - Q1
	
	if(p == "ANC"){
		lower.limit <- Q1 - 1.5*IQR
		out <- which(t < lower.limit)
	}else if(p == "NDE"){
		lower.limit <- Q1 - 1.5*IQR
		out <- which(t < lower.limit)
	}else if(p == "NCE"){
		lower.limit <- Q1 - 1.5*IQR
		out <- which(t < lower.limit)
	}else if(p == "APL"){
		upper.limit <- Q3 + 1.5*IQR
		out <- which(t > upper.limit)
	}else if(p == "ABC"){
		lower.limit <- Q1 - 1.5*IQR
		out <- which(t < lower.limit)
	}else if(p == "APN"){
		upper.limit <- Q3 + 1.5*IQR
		out <- which(t > upper.limit)
	}else if(p == "NDI"){
		upper.limit <- Q3 + 1.5*IQR
		out <- which(t > upper.limit)
	}else if(p == "CCO"){
		lower.limit <- Q1 - 1.5*IQR
		out <- which(t < lower.limit)
	}else if(p == "HET"){
		lower.limit <- Q1 - 1.5*IQR
		out <- which(t < lower.limit)
	}else if(p == "ACC"){
		lower.limit <- Q1 - 1.5*IQR
		out <- which(t < lower.limit)
	}else if(p == "GEF"){
		lower.limit <- Q1 - 1.5*IQR
		out <- which(t < lower.limit)
	}else if(p == "AEC"){
		lower.limit <- Q1 - 1.5*IQR
		out <- which(t < lower.limit)
	}else if(p == "COH"){
		lower.limit <- Q1 - 1.5*IQR
		out <- which(t < lower.limit)
	}else if(p == "COM"){
		lower.limit <- Q1 - 1.5*IQR
		out <- which(t < lower.limit)
	}else{
		cat("Invalid value for p!\n")
	}
	vn = v[out]
	return(vn)
}

