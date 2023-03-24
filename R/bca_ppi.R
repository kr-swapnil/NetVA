#' A protein-protein interactions dataset of breast cancer
#'
#' 
#' An igraph graph object containing 143751 edges (interactions) among 10597 nodes (proteins).
#'
#' 
#' @name bca_ppi
#' @docType data
#' @title A protein-protein interactions dataset of breast cancer from CancerNet database.
#' 
#'
#' @keywords datasets
#' @references Meng X, Wang J, Yuan C. et al. CancerNet: a database for decoding multilevel molecular interactions across diverse cancer types. Oncogenesis 4, e177 (2015).

#Making binary data available for the demonstration of NetVA
bca_ppi = read.table("data-raw/BRCA_ppi.txt", head=T)
bca_ppi = igraph::graph.data.frame(bca_ppi, directed=F)
usethis::use_data(bca_ppi)
