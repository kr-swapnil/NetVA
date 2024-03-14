#' Output of netva function for all VIPs in the breast cancer PPIN from three nodes approach
#'
#' 
#' An dataframe with 251270 rows (protein triplets) and 14 columns (topological properties).
#'
#' 
#' @name netva_res_3n
#' @docType data
#' @title Output of netva function as dataframe for all VIPs in the breast cancer PPIN from three nodes approach.
#'
#' @keywords datasets
#' @references netva_res_3n = netva(vl, bc.net, ncore = 30).

#Making binary data available for the demonstration of NetVA
netva_res_3n = read.table("data-raw/netva_result_3node_approach.txt", head = TRUE, row.names = 1, sep = "\t")
usethis::use_data(netva_res_3n)

