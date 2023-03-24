#==========================================================================================================================================
#' Identify all possible Influential nodes (INs) based on pareto principle of 80:20 rule (by default) for a given network
#'
#' @param net An igraph graph object.
#' @param p Value of percent of nodes to be considered for the determination of EVC/EVC+ cutoff. By default value is 20%.
#' @return A list containing two vectors: (1) ins.evc - all possible Influential nodes based on EVC, (2) ins.evcplus - all possible 
#' Influential nodes based on EVC+ as identified in the given network.
#' @export
detectINs <- function(net, p = 20){
	ig <- evc(net)$evc
	ig2 <- evc(net)$evc.plus
	ig.sorted <- sort(ig, decreasing = T)
	ig.sorted2 <- sort(ig2, decreasing = T)
	num.v <- igraph::vcount(net)
	t20 <- round((num.v * p)/100)
	t20n.aevc <- mean(ig.sorted[1:t20])
	t20n.aevc2 <- mean(ig.sorted2[1:t20])
	igene <- ig[which(ig > t20n.aevc)]
	igene2 <- ig2[which(ig2 > t20n.aevc2)]
	return(list(ins.evc = igene, ins.evcplus = igene2))
}

