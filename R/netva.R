#=========================================================================================
#' Perform network vulnerability analysis for a given network
#'
#' This function performs deletion of one or more than one nodes and calculates nine different topological properties such as average node 
#' connectivity, average path length, articulation point, network centralization, network density, network diameter, transitivity 
#' (clustering coefficient), betweenness and heterogeneity for the resultant network.
#'
#' @param net An igraph graph object.
#' @param v Name of any one node/protein to be deleted, or a character vector of names to delete more than one nodes or proteins.
#' @param type A keyword either "full" or "cluster" for consideration of complete network or only the largest cluster.
#' @return A numeric vector of nine elements corresponding to nine different topological properties.
#' @export
netva <- function(v, net, type){
	nva.res <- vector(mode = "numeric", length = 9)
	names(nva.res) <- c("averagenodeconnectivity", "networkdensity", "centralization", "averagepathlength", "betweenness", "articulationpoint", "networkdiameter", "clusteringcoefficient", "heterogeneity")
	
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
  	#n <- igraph::vcount(g)
  	
  	nva.res[1] <- mean(d)	#averagenodeconnectivity
  	nva.res[2] <- igraph::graph.density(g)
  	nva.res[3] <- igraph::centr_degree(g)$centralization
  	nva.res[4] <- igraph::average.path.length(g)
  	nva.res[5] <- mean(igraph::betweenness(g))
  	nva.res[6] <- igraph::clusters(node_deleted_graph)$no
  	nva.res[7] <- igraph::diameter(g)
  	nva.res[8] <- igraph::transitivity(g)
  	nva.res[9] <- heterogeneity(g)

	return(nva.res)
}

#' Perform network vulnerability analysis on multiple cores
#'
#' This function performs deletion of nodes one by one and calculation of average node connectivity, average path length, articulation 
#' point, network centralization, network density, network diameter, transitivity (clustering coefficient), betweenness and heterogeneity 
#' of resultant networks using multiple cores. It is a wrapper around netva() utilizing parallel computing features of R. It is only Linux/
#' macOS based machine compatible.
#'
#' @param net An igraph graph object.
#' @param vl A character vector of node or protein names.
#' @param type A keyword either "full" or "cluster" for consideration of complete network or only the largest cluster.
#' @param ncore Number of cores users want to use for the computation.
#' @return A dataframe having number of rows equal to the number of proteins in consideration and nine columns.
#' @export
netva.mc <- function(vl, net, type, ncore){
	cat("*** NetVA v1.0 with multicores ***\n")
	cat("Number of cores assigned:", ncore, "\n")
	res <- parallel::mclapply(vl, netva, net, type, mc.cores = ncore)
	nva.df <- data.frame(matrix(unlist(res), byrow=T, nrow=length(res), ncol=9))
	rownames(nva.df) <- vl
	colnames(nva.df) <- c("averagenodeconnectivity", "networkdensity", "centralization", "averagepathlength", "betweenness", "articulationpoint", "networkdiameter", "clusteringcoefficient", "heterogeneity")
	return(nva.df)
}

#' Perform network vulnerability analysis using single core only
#'
#' This function performs deletion of nodes one by one and calculation of average node connectivity, average path length, articulation 
#' point, network centralization, network density, network diameter, transitivity (clustering coefficient), betweenness and heterogeneity 
#' of resultant networks. It is a wrapper around netva() for performing network vulnerability analysis on any machines such as Linux,  
#' macOS or Windows utilizing single core.
#'
#' @param net An igraph graph object.
#' @param vl A vector of node or protein names.
#' @param type A keyword either "full" or "cluster" for consideration of complete network or only the largest cluster.
#' @return A dataframe having number of rows equal to the number of proteins in consideration and nine columns.
#' @export
netva.sc <- function(vl, net, type){
	cat("*** NetVA v1.0 with single core ***\n")
	
	res <- lapply(vl, netva, net, type)
	nva.df <- data.frame(matrix(unlist(res), byrow=T, nrow=length(res), ncol=9))
	rownames(nva.df) <- vl
	colnames(nva.df) <- c("averagenodeconnectivity", "networkdensity", "centralization", "averagepathlength", "betweenness", "articulationpoint", "networkdiameter", "clusteringcoefficient", "heterogeneity")
	return(nva.df)
}


#' Calculates value of heterogeneity for a given network
#'
#' @param Takes input an igraph graph object.
#' @return Returns a single numeric value.
#' @export
heterogeneity <- function(net){
	d <- igraph::degree(net)
	het <- sqrt(var(d))/mean(d)
	return(het)
}


