#' A protein-protein interactions dataset of breast cancer
#'
#'
#' An igraph graph object containing 143751 edges (interactions) among 10597 nodes (proteins).
#'
#'
#' @name bca_ppi
#' @docType data
#' @title A protein-protein interactions (PPIs) dataset of breast cancer from CancerNet database. This PPIs dataset contains 143751 edges (interactions) among 10597 nodes (proteins).
#' @keywords input-datasets
#' @references Meng X, Wang J, Yuan C. et al. CancerNet: a database for decoding multilevel molecular interactions across diverse cancer types. Oncogenesis 4, e177 (2015).
NULL

#' Output of netva function for all proteins in the breast cancer PPIN from single node approach
#'
#' 
#' An dataframe with 10597 rows (proteins) and 14 columns (topological properties).
#'
#' 
#' @name netva_res_1n
#' @docType data
#' @title Output of netva function as dataframe for all proteins in the breast cancer PPIN from single node approach.
#'
#' @keywords output-datasets
#' @references netva_res_1n = netva(vl, bc.net, ncore = 30).
NULL

#' Output of netva function for all VIPs in the breast cancer PPIN from two nodes approach
#'
#' 
#' An dataframe with 25838 rows (proteins pairs) and 14 columns (topological properties).
#'
#' 
#' @name netva_res_2n
#' @docType data
#' @title Output of netva function as dataframe for all VIPs in the breast cancer PPIN from two nodes approach.
#'
#' @keywords output-datasets
#' @references netva_res_2n = netva(vl, bc.net, ncore = 30).
NULL

