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
#' @keywords datasets
#' @references netva_res_1n = netva(vl, bc.net, ncore = 30).

#Making binary data available for the demonstration of NetVA
netva_res_1n = read.table("data-raw/netva_result_1node_approach.txt", head = TRUE, row.names = 1)
usethis::use_data(netva_res_1n)

