#=================================================================================================================
#' Identify all possible hubs based on the pareto principle of Eighty-twenty rule (by default) for a given network
#'
#' @param net An igraph graph object.
#' @param method Method to identify hub nodes. Currently this function supports only the method of Eighty-twenty principle (ETP).
#' @param p Value of percent of nodes/proteins to be considered for the determination of degree cutoff. By default value is 20%. It is an optional parameter.
#' @param validate Logical, TRUE or FALSE, whether to validate identified hubs by rewiring of a given percentage of edges.
#' @param perturb Percentage value to rewire edges.
#' @param iter Number of iterations to perform rewiring and construction of new rewired networks. The default value is round(100/perturb).
#' @param ng Number of new graphs/networks to be constructed. The default value is the value of iter.
#' @return A numeric vector containing all possible hubs with hub proteins' names and corresponding degree values as identified in the given network.
#' @export
detectHubs <- function(net, method = "ETP", p = 20, validate = TRUE, perturb = 5, iter = round(100/perturb), ng = iter){
	d <- igraph::degree(net)
	if(method == "ETP"){
		hubs <- detectkn(g = net, t = d, p)
	}else{
		print("Wrong method value!\n")
	}
	
	if(validate == TRUE){
		kn.vec = c()
		pg <- perturbNet(g = net, p = perturb, iter)
		for(i in 1:length(pg)){
			kn <- detectkn(g = pg[[i]], t = degree(pg[[i]]), p)
			kn.vec = c(kn.vec, names(kn))
		}
		kn.pg = kn.vec[which(table(kn.vec) == ng)]
	}
	hubs2 <- intersect(names(hubs), kn.pg)
	hub.list <- list(hubs.bp = hubs, hubs.ap = hubs[hubs2])
	return(hub.list)
}

#' Identify all possible bottlenecks based on the pareto principle of Eighty-twenty rule (by default) for a given network
#'
#' @param net An igraph graph object.
#' @param method Method to identify bottleneck nodes. Currently this function supports only the method of Eighty-twenty principle (ETP).
#' @param p Value of percent of nodes/proteins to be considered for the determination of degree cutoff. By default value is 20%. It is an optional parameter.
#' @param validate Logical, TRUE or FALSE, whether to validate identified bottlenecks by rewiring of a given percentage of edges.
#' @param perturb Percentage value to rewire edges.
#' @param iter Number of iterations to perform rewiring and construction of new rewired networks. The default value is round(100/perturb).
#' @param ng Number of new graphs/networks to be constructed. The default value is the value of iter.
#' @return A numeric vector containing all possible bottlenecks with bottleneck proteins' names and corresponding betweenness values as identified in the given network.
#' @export
detectBottlenecks <- function(net, method = "ETP", p = 20, validate = TRUE, perturb = 5, iter = round(100/perturb), ng = iter){
	b <- igraph::betweenness(net)
	if(method == "ETP"){
		bottlenecks <- detectkn(g = net, t = b, p)
	}else{
		print("Wrong method value!\n")
	}
	
	if(validate == TRUE){
		kn.vec = c()
		pg <- perturbNet(g = net, p = perturb, iter)
		for(i in 1:length(pg)){
			kn <- detectkn(g = pg[[i]], t = betweenness(pg[[i]]), p)
			kn.vec = c(kn.vec, names(kn))
		}
		kn.pg = kn.vec[which(table(kn.vec) == ng)]
	}
	bottlenecks2 <- intersect(names(bottlenecks), kn.pg)
	bot.list <- list(bottlenecks.bp = bottlenecks, bottlenecks.ap = bottlenecks[bottlenecks2])
	return(bot.list)
}

#' Identify key nodes for a given network based on either degree or betweenness values
#'
#' This internal function performs key nodes identification based on the well-known "Eighty-twenty principle (ETP)" utilizing node degree 
#' or betweenness values from a given network.
#'
#' @param g Network for which key nodes will be identified based on degree or betweenness values.
#' @param t Vectror of node degree or betweenness values.
#' @return A named numeric vector of hubs or bottlenecks depending on the values of t, if t is degree values then a vector of hubs with 
#' corresponding degree values and if t is betweenness values then a vector of bottlenecks with corresponding betweenness values.
#' @noRd
detectkn <- function(g, t, p){
	t.sorted <- sort(t, decreasing = T)
	num.v <- igraph::vcount(g)
	tp <- round((num.v * p)/100)
	tpn.av <- mean(t.sorted[1:tp])
	kng <- t[which(t > tpn.av)]
	return(kng)
}

#' Rewire a given percentage of edges from a network and construct a new network containing rewired edges
#'
#' This internal function performs rewiring of a given percentage of edges and construct new networks with rewired edges.
#'
#' @param g Network from which a given percentage of edges will be reshuffled or rewired to construct a new network.
#' @param p Percentage value for edges to be rewired or reshuffled.
#' @param iter Number of iterations to be performed to reshuffle or rewire a given percentage of edges and to construct new network for each iteration.
#' @return A list of newly constructed graphs and there will be n graphs in this list, where n is equal to the value of iter.
#' @noRd
perturbNet <- function(g, p, iter){
	n = round(ecount(g)*(p/100))
	on.el = as_edgelist(g)
	temp.el = on.el
	on.el = as.data.frame(on.el)
	gl = vector("list", iter)
	for(i in 1:iter){
		if(n <= nrow(temp.el)){
			j = sample(nrow(temp.el), n)
		}else{
			j = sample(nrow(temp.el))
		}
		br.el = as.data.frame(temp.el[j,])
		ar.el = transform(br.el, V1 = sample(V1))
		rem.el = setdiff(on.el, br.el)
		mut.el = rbind(rem.el, ar.el)
		mut.net = graph.data.frame(mut.el, directed=F)
		gl[[i]] = mut.net
		temp.el = temp.el[-j,]
	}
	return(gl)
}

