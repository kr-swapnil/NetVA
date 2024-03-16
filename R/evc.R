#========================================================================================================================================
#' Calculates escape velocity centrality (normal and extended version)
#'
#' Calculates escape velocity centrality (EVC/evc) and extended escape velocity centrality (EVC+/evc.plus)
#' of all vertices in the network under study.
#'
#' @param g An igraph graph object.
#' @param alpha A tunable factor with value between 0.1 to 1. The default value of alpha is 1.
#' @param mode The type of the core in a graph. Character constant with possible values - ‘in’: in-cores are computed, ‘out’:
#'          out-cores are computed, ‘all’: the corresponding undirected graph is considered. This argument is only for directed
#'          graphs. 
#' @return A list of two vectors: (1) evc, containing the values of EVC and 
#'                                (2) evc.plus, the values of EVC+ of each vertex in the network.
#' @references Ullah A. et al. (2022). Escape velocity centrality: escape influence-based key nodes identification in complex networks, Applied Intelligence, 1-19.
#'
#' @export
evc <- function(g, alpha = 1, mode = "all"){
	a <- alpha
	evc.vec <- c()
	evc.vec2 <- c()
	n <- c()
	dv <- igraph::degree(g)
	s.paths <- igraph::shortest.paths(g, algorithm = "dijkstra")
	nv <- igraph::vcount(g)
	ks <- igraph::coreness(g, mode)
	v <- igraph::vertex_attr(g)$name
	
	pb <- utils::txtProgressBar(min = 0, max = nv, style = 3, width = 50, char = "=")
	
	for(i in 1:nv){
		r1 <- 0
		r2 <- 0
		for(j in 1:nv){
			if(i != j){
				sp <- s.paths[v[i],v[j]]
				dvi <- dv[[v[i]]]
				ksi <- ks[[v[i]]]
				ksj <- ks[[v[j]]]
				evc <- sqrt((2*a*dvi)/sp)
				r1 <- sum(r1, evc)
				
				evc.p <- sqrt((2*a*dvi*(ksi + ksj))/sp)
				r2 <- sum(r2, evc.p)
			}
		}
		evc.vec <- c(evc.vec, r1)
		evc.vec2 <- c(evc.vec2, r2)
		n <- c(n, v[i])
		
		utils::setTxtProgressBar(pb, i)
	}
	close(pb)
	
	names(evc.vec) <- n
	names(evc.vec2) <- n
	evc.list <- list(evc = evc.vec, evc.plus = evc.vec2)
	return(evc.list)
}

