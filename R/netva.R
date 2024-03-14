#=========================================================================================================================================
#' Perform network vulnerability analysis for a given network
#'
#' This internal function performs deletion of one or more than one nodes at once and calculates fourteen different topological 
#' properties such as average betweenness, average closeness, average node connectivity, average path length, articulation point, 
#' centralization, clustering coefficient (transitivity), global efficiency, heterogeneity, network density, and network diameter for the 
#' resultant network.
#'
#' @param v Name of any one node/protein to be deleted, or a character vector of names to delete more than one nodes or proteins.
#' @param net An igraph graph object.
#' @return A numeric vector of fourteen elements corresponding to fourteen different topological properties.
#' @noRd
nva <- function(v, net){
	nva.res <- vector(mode = "numeric", length = 14)
	names(nva.res) <- c("averagebetweenness", "averagecloseness", "averageeccentricity", "averagenodeconnectivity", "averagepathlength", "articulationpoint", "clusteringcoefficient", "cohesiveness", "compactness", "globalefficiency", "heterogeneity", "networkcentralization", "networkdensity", "networkdiameter")
	
	g <- igraph::delete.vertices(net, v)
  	
	nva.res[1] <- mean(igraph::betweenness(g))
	nva.res[2] <- mean(igraph::closeness(g), na.rm=T)
	nva.res[3] <- mean(igraph::eccentricity(g))
	nva.res[4] <- mean(igraph::degree(g))
	nva.res[5] <- igraph::average.path.length(g)
	nva.res[6] <- igraph::components(g)$no
	nva.res[7] <- igraph::transitivity(g)
	nva.res[8] <- cohesiveness(v, net)
	nva.res[9] <- compactness(v, net)
	nva.res[10] <- igraph::global_efficiency(g)
	nva.res[11] <- heterogeneity(g)
	nva.res[12] <- igraph::centr_degree(g)$centralization
	nva.res[13] <- igraph::graph.density(g)
	nva.res[14] <- igraph::diameter(g)
	
	return(nva.res)
}

#' Perform network vulnerability analysis for a given set of nodes one by one
#'
#' This function performs deletion of nodes one by one and calculation of average betweenness, average closeness, average eccentricity, 
#' average node connectivity, average path length, articulation point, clustering coefficient (transitivity), cohesiveness, compactness, 
#' globalefficiency, heterogeneity, network centralization, network density, and network diameter of resultant networks using multiple 
#' cores on Linux/macOS based machines. For Windows based machine the parallel computing feature is not available and hence, it works in 
#' normal mode only despite providing ncore value more than one and may take more computing time.
#'
#' @param vl A character vector of node or protein names or list of vectors having two nodes (node pairs/edges) or more than two nodes. 
#' If input is vector, only one node will be deleted at once. However, if the input is list, n nodes will be deleted at once, where n is 
#' the length of each element of the list.
#' @param net An igraph graph object.
#' @param ncore Number of cores users want to use for the computation.
#' @return A dataframe having number of rows equal to length(vl) with fourteen columns.
#' @export
netva <- function(vl, net, ncore = 1){
	
	if(class(vl) %in% c("character", "list")){
		
		if(ncore > 1){
			cat("*** NetVA v1.0.0 with parallel mode ***\n")
			cat("Number of cores assigned:", ncore, "\n")
	
			res <- parallel::mclapply(vl, nva, net, mc.cores = ncore)
		}else{
			cat("*** NetVA v1.0.0 with normal mode ***\n")

			res <- lapply(vl, nva, net)
		}
		nva.df <- data.frame(matrix(unlist(res), byrow=T, nrow=length(res), ncol=14))
		
		vl2 <- c()
		for(i in 1:length(vl)){
			if(class(vl[[i]]) == "igraph.vs"){
				j <- paste(igraph::as_ids(vl[[i]]), sep = "", collapse = " ")
			}else{
				j <- paste(vl[[i]], sep = "", collapse = " ")
			}
			vl2 <- c(vl2, j)
		}
		
		rownames(nva.df) <- vl2
		colnames(nva.df) <- c("averagebetweenness", "averagecloseness", "averageeccentricity", "averagenodeconnectivity", "averagepathlength", "articulationpoint", "clusteringcoefficient", "cohesiveness", "compactness", "globalefficiency", "heterogeneity", "networkcentralization", "networkdensity", "networkdiameter")
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

#' Calculates cohesiveness of complete network based on total edge weight of all proteins
#' Or
#' Determine network cohesiveness after removal of a node of interest
#'
#' @param v A node/protein name which will be removed (by default NULL, i.e., none of nodes will be removed and the cohesiveness value 
#' will be of complete network).
#' @param net An igraph graph object.
#' @param p A penalty term which measures the inaccuracy of the network interaction. The default value of p is set to 0.1.
#' @return A single numeric value.
#' @export
cohesiveness <- function(v = NULL, net, p = 0.1){
	if(length(v) == 0){
		#Calculating cohesiveness of complete network (default)
		subnet <- net
		twe.wisubnet <- sum(igraph::strength(subnet))
		twe.wosubnet <- sum(igraph::strength(net, vids = igraph::vertex_attr(subnet)$name))
	}else{
		#Calculating cohesiveness of subnetwork after removal of v
		cl <- igraph::components(net)
		if(class(v) == "igraph.vs"){
			v <- igraph::as_ids(v)
			i <- which(names(cl$membership) %in% v)
		}else{
			i <- which(names(cl$membership) %in% v)
		}
		#i <- which(names(cl$membership) %in% v)
		subnet <- igraph::subgraph(net, which(cl$membership %in% cl$membership[i]))
		subnet <- igraph::delete.vertices(subnet, v)
		twe.wisubnet <- sum(igraph::strength(subnet))
		twe.wosubnet <- sum(igraph::strength(igraph::delete.vertices(net, v), vids = igraph::vertex_attr(subnet)$name))
	}
	cohe.cent <- twe.wisubnet/(twe.wosubnet + p)
	return(cohe.cent)
}

#' Calculates compactness of network based on the presence of all maximal 3-node cliques in complete network
#' Or
#' Determine network compactness after removal of a node of interest
#' @param v A node/protein name which will be removed (by default NULL, i.e., none of nodes will be removed and the compactness value 
#' will be of complete network).
#' @param net An igraph graph object.
#' @param p A penalty term which measures the inaccuracy of the network interaction. The default value of p is set to 0.1.
#' @return A single numeric value.
#' @export
compactness <- function(v = NULL, net, p = 0.1){
	if(length(v) == 0){
		#Calculating compactness of complete network (default)
		subnet <- net
		tnc.wisubnet <- length(igraph::max_cliques(subnet, 3, 3))
		tnc.wosubnet <- length(igraph::max_cliques(net, 3, 3, igraph::vertex_attr(subnet)$name))
	}else{
		#Calculating compactness of subnetwork after removal of v
		cl <- igraph::components(net)
		if(class(v) == "igraph.vs"){
			v <- igraph::as_ids(v)
			i <- which(names(cl$membership) %in% v)
		}else{
			i <- which(names(cl$membership) %in% v)
		}
		#i <- which(names(cl$membership) %in% v)
		subnet <- igraph::subgraph(net, which(cl$membership %in% cl$membership[i]))
		subnet <- igraph::delete.vertices(subnet, v)
		tnc.wisubnet <- length(igraph::max_cliques(subnet, 3, 3))
		#vnc.subnet <- length(max_cliques(subnet, 3, 3, v))
		tnc.wosubnet <- length(igraph::max_cliques(igraph::delete.vertices(net, v), 3, 3, igraph::vertex_attr(subnet)$name))
	}
	comp.cent <- tnc.wisubnet/(tnc.wosubnet + p)
	return(comp.cent)
}

