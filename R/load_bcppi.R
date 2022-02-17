#' Loads protein-protein interactions data of breast cancer
#'
#' Source: CancerNet database (http://bis.zju.edu.cn/CancerNet)
#' Reference: Meng, X., Wang, J., Yuan, C. et al. CancerNet: a database for decoding multilevel molecular interactions across diverse cancer types. Oncogenesis 4, e177 (2015). https://doi.org/10.1038/oncsis.2015.40
#' @return A dataframe containing protein-protein interactions data of breast cancer.
#'
#' @export
load_bcppi <- function(){
	fn <- system.file("extdata", "BRCA_ppi.txt", package = "NetVA")
	bc.ppi <- read.table(fn, head = T)
	bc.ppi
}


