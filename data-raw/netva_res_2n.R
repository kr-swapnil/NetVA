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
#' @keywords datasets
#' @references netva_res_2n = netva(vl, bc.net, ncore = 30).

#Making binary data available for the demonstration of NetVA
netva_res_2n = read.table("data-raw/netva_result_2node_approach.txt", head = TRUE, row.names = 1, sep = "\t")
usethis::use_data(netva_res_2n)

