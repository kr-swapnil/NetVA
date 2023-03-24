#=========================================================================================================================================
#' Perform network vulnerability analysis for a given network
#'
#' This internal function performs deletion of one or more than one nodes at once and calculates nine different topological properties 
#' such as average node connectivity, average path length, articulation point, network centralization, network density, network diameter,  
#' transitivity (clustering coefficient), betweenness, and heterogeneity for the resultant network.
#'
#' @param v Name of any one node/protein to be deleted, or a character vector of names to delete more than one nodes or proteins.
#' @param net An igraph graph object.
#' @return A numeric vector of nine elements corresponding to nine different topological properties.
#' @noRd
nva <- function(v, net){
	nva.res <- vector(mode = "numeric", length = 9)
	names(nva.res) <- c("averagenodeconnectivity", "networkdensity", "centralization", "averagepathlength", "betweenness", "articulationpoint", "networkdiameter", "clusteringcoefficient", "heterogeneity")
	
  	g <- igraph::delete.vertices(net, v)
  	
  	d <- igraph::degree(g)
  	
  	nva.res[1] <- mean(d)
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

#' Perform network vulnerability analysis for a given set of nodes one by one
#'
#' This function performs deletion of nodes one by one and calculation of average node connectivity, average path length, articulation 
#' point, network centralization, network density, network diameter, transitivity (clustering coefficient), betweenness, and heterogeneity 
#' of resultant networks using multiple cores on Linux/macOS based machines. For Windows based machine the parallel computing feature is 
#' not available and hence, it works in normal mode only despite providing ncore value more than one and may take more computing time.
#'
#' @param vl A character vector of node or protein names or list of vectors having two nodes (node pairs/edges) or more than two nodes. If 
#' input is vector, only one node will be deleted at once. However, if the input is list, n nodes will be deleted at once, where n is the 
#' length of each element of the list.
#' @param net An igraph graph object.
#' @param ncore Number of cores users want to use for the computation.
#' @return A dataframe having number of rows equal to length(vl) with nine columns.
#' @export
netva <- function(vl, net, ncore = 1){
	
	if(class(vl) %in% c("vector", "list")){
		
		if(ncore > 1){
			cat("*** NetVA v1.0 with parallel mode ***\n")
			cat("Number of cores assigned:", ncore, "\n")
	
			res <- parallel::mclapply(vl, nva, net, mc.cores = ncore)
		}else{
			cat("*** NetVA v1.0 with normal mode ***\n")

			res <- lapply(vl, nva, net)
		}
		nva.df <- data.frame(matrix(unlist(res), byrow=T, nrow=length(res), ncol=9))
		paste(vl[[i]], sep = "", collapse = " ")
		rownames(nva.df) <- vl
		colnames(nva.df) <- c("averagenodeconnectivity", "networkdensity", "centralization", "averagepathlength", "betweenness", "articulationpoint", "networkdiameter", "clusteringcoefficient", "heterogeneity")
		return(nva.df)
	}else{
		cat("Wrong type of input: vl\n")
	}
}

#' Calculates value of heterogeneity for a given network
#'
#' @param net An igraph graph object.
#' @return A single numeric value.
#' @export
heterogeneity <- function(net){
	d <- igraph::degree(net)
	het <- sqrt(var(d))/mean(d)
	return(het)
}

