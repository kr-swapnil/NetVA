#=========================================================================================
#' Perform network vulnerability analysis for a given network
#'
#' This function performs deletion of nodes one by one and calculation of average node connectivity, average path length, articulation 
#' point, network centralization, network density, network diameter, transitivity (clustering coefficient), betweenness and heterogeneity 
#' of resultant networks.
#'
#' @param net Takes input an igraph graph object
#' @param v Name of one node or protein to be deleted
#' @param type A keyword either "full" or "cluster" for consideration of complete network or only the largest cluster
#' @return A dataframe of one row and ten columns
#' @export
netva <- function(v, net, type){
	nva.df <- as.data.frame(matrix(ncol = 10, nrow = 1))
	colnames(nva.df) <- c("node", "averagenodeconnectivity", "density", "centralization", "averagepathlength", "betweenness", "articulationpoint", "diameter", "clusteringcoefficient", "heterogeneity")
	
  	node_deleted_graph <- igraph::delete.vertices(net, v)
  	if(type == "cluster"){
  		clust <- igraph::clusters(node_deleted_graph)
  		g <- igraph::induced.subgraph(node_deleted_graph, which(clust$membership == which.max(clust$csize)))
  	}else if(type == "full"){
  		g <- node_deleted_graph
  	}else{
  		cat("Error: Wrong 'type' value, input either 'cluster' or 'full'!\n")
  	}
  	d <- igraph::degree(g)
  	n <- igraph::vcount(g)
  	nva.df[1,1] <- v
  	nva.df[1,2] <- mean(d)	#averagenodeconnectivity
  	nva.df[1,3] <- igraph::graph.density(g)
  	nva.df[1,4] <- igraph::centr_degree(g)$centralization
  	nva.df[1,5] <- igraph::average.path.length(g)
  	nva.df[1,6] <- mean(igraph::betweenness(g))
  	nva.df[1,7] <- igraph::clusters(node_deleted_graph)$no
  	nva.df[1,8] <- igraph::diameter(g)
  	nva.df[1,9] <- igraph::transitivity(g)
  	nva.df[1,10] <- heterogeneity(g)

	return(nva.df)
}

#' Perform network vulnerability analysis on multiple cores
#'
#' This function performs deletion of nodes one by one and calculation of average node connectivity, average path length, articulation 
#' point, network centralization, network density, network diameter, transitivity (clustering coefficient), betweenness and heterogeneity 
#' of resultant networks using multiple cores. It is a wrapper around netva() utilizing parallel computing features of R. It is only Linux/
#' macOS based machine compatible.
#'
#' @param net Takes input an igraph graph object
#' @param vl A vector of node or protein names
#' @param type A keyword either "full" or "cluster" for consideration of complete network or only the largest cluster
#' @param ncore Number of cores users want to use for the computation
#' @return A dataframe having number of rows equal to the number of proteins in consideration and ten columns
#' @export
netva.mc <- function(vl, net, type, ncore){
	cat("*** NetVA v1.0 with multicores ***\n")
	cat("Number of cores assigned:", ncore, "\n")
	res <- parallel::mclapply(vl, netva, net, type, mc.cores = ncore)
	nva.df <- data.frame(matrix(unlist(res), byrow=T, nrow=length(res), ncol=10))
	return(nva.df)
}

#' Perform network vulnerability analysis using single core only
#'
#' This function performs deletion of nodes one by one and calculation of average node connectivity, average path length, articulation 
#' point, network centralization, network density, network diameter, transitivity (clustering coefficient), betweenness and heterogeneity 
#' of resultant networks. It is a wrapper around netva() for performing network vulnerability analysis on any machines such as Linux,  
#' macOS or Windows utilizing single core.
#'
#' @param net Takes input an igraph graph object
#' @param vl A vector of node or protein names
#' @param type A keyword either "full" or "cluster" for consideration of complete network or only the largest cluster
#' @return A dataframe having number of rows equal to the number of proteins in consideration and ten columns
#' @export
netva.sc <- function(vl, net, type){
	cat("*** NetVA v1.0 with single cores ***\n")
	nva.df <- as.data.frame(matrix(ncol = 10, nrow = length(vl)))
	for(i in 1:length(vl)){
		nva.df[i, ] <- netva(vl[i], net, type)[1, ]
	}
	return(nva.df)
}


#' Calculates value of heterogeneity for a given network
#'
#' @param Takes input an igraph graph object
#' @return A single numeric value
#' @export
heterogeneity <- function(net){
	d <- igraph::degree(net)
	het <- sqrt(var(d))/mean(d)
	return(het)
}


