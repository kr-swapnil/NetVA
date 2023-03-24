#======================================================================================================
#' Identify all possible hubs based on pareto principle of 80:20 rule (by default) for a given network
#'
#' @param net An igraph graph object.
#' @param p Value of percent of nodes/proteins to be considered for the determination of degree cutoff. By default value is 20%. It is an optional parameter.
#' @return A numeric vector containing all possible hubs with hub proteins' names and corresponding degree values as identified in the given network.
#' @export
detectHubs <- function(net, p = 20){
	d <- igraph::degree(net)
	d.sorted <- sort(d, decreasing = T)
	num.v <- igraph::vcount(net)
	t20 <- round((num.v * p)/100)
	t20n.ad <- mean(d.sorted[1:t20])
	hubs <- d[which(d > t20n.ad)]
	return(hubs)
}

#' Identify all possible bottlenecks based on pareto principle of 80:20 rule (by default) for a given network
#'
#' @param net An igraph graph object.
#' @param p Value of percent of nodes/proteins to be considered for the determination of betweenness cutoff. By default value is 20%. It is an optional parameter.
#' @return A numeric vector containing all possible bottlenecks with bottleneck proteins' names and corresponding betweenness values as identified in the given network.
#' @export
detectBottlenecks <- function(net, p = 20){
	b <- igraph::betweenness(net)
	b.sorted <- sort(b, decreasing = T)
	num.v <- igraph::vcount(net)
	t20 <- round((num.v * p)/100)
	t20n.ab <- mean(b.sorted[1:t20])
	bottlenecks <- b[which(b > t20n.ab)]
	return(bottlenecks)
}


