# NetVA
<i> An R package for network vulnerability and influence analysis </i>

<b>General information</b>:

Version: 1.0.0

Date: 2022-02-04

Depends: R (>= 3.0.0), igraph

Imports: parallel

Vignette: Available

<b>Description</b>: The NetVA assists in network analysis with two approaches: (1) Performs network vulnerability analysis and helps to identify vulnerable nodes (VNs) or proteins (VPs) for a given protein-protein interaction (PPI) network. Hence, network vulnerability analysis is an approach for identifying VPs by assessing networks based on their topological properties. The VPs are identified based on fourteen different topological properties calculated for networks as constructed by deleting all nodes/proteins, one by one, from the original network under investigation. This package provides the capability to use multiple cores on Linux/macOS to parallelize the process using the parallel package. (2) Performs network influence analysis to identify influential nodes (INs) i.e. key nodes with ranking by calculating escape velocity centrality (EVC) and extended escape velocity centrality (EVC+). It also helps to identify hubs and bottlenecks present in the given network based on the well-known Pareto principle of the 80:20 rule followed by tuning and validation of identified hubs and bottlenecks against PPI data noise by perturbing/rewiring a percentage of edges (as per user's choice) from the network under study. An illustrative tutorial on how to use various functions of this package for network vulnerability and influence analysis has been provided in <b>Tutorial_Rscript</b>. Further, the package also provides a vignette to assist users with network vulnerability and influence analysis for their research implementation.

<b>Installation</b>: The NetVA package can be installed in two ways on the R console using:

Installation without the vignette
> devtools::install_github("kr-swapnil/NetVA")

or, with the vignette
> devtools::install_github("kr-swapnil/NetVA", build_vignettes = TRUE)

<b>How to access/browse vignettes</b>: 
> vignette("NetVA")

<b>or</b>
> browseVignettes("NetVA")

<b>Available functions</b>:
	
  netva(): Performs vulnerability analysis with or without parallel processing. Parallel processing works only on Linux/macOS machines but not on Windows-based machines.
  
  detectVNs(): Detects VPs based on the five-point summary of the boxplot for each topological property included in the package.
  
  evc(): Calculates EVC and EVC+ values of each node present in a given network.
  
  detectINs(): Detects influential nodes i.e. proteins based on the values of EVC and EVC+ for a given network.
  
  detectHubs(): Identify hub proteins in the given network based on the Pareto-principle of 80:20 rule followed by tuning of identified hubs against PPI data noise using rewiring of a given percentage of edges as per the user's choice in the network.
  
  detectBottlenecks(): Identify bottleneck proteins in the given network based on the Pareto-principle of 80:20 rule followed by tuning of identified bottlenecks against PPI data noise using rewiring of a given percentage of edges as per the user's choice in the network.
	
  heterogeneity(): Calculates the value of heterogeneity for a given network.
  
  cohesiveness(): Calculates the cohesiveness of a given network as it is or after the removal of a node of interest.

  compactness(): Calculates the compactness of a given network as it is or after the removal of a node of interest.

<b>Issues/Bug reports</b> 
Report any issues or bugs to https://github.com/kr-swapnil/NetVA/issues.

<b>How to cite</b>

If you find NetVA useful, please cite the following publication:
1. <i>Kumar S, Pauline G, Vindal V. NetVA: an R package for network vulnerability and influence analysis. bioRxiv. 2023 July 31. doi: https://doi.org/10.1101/2023.07.31.551200.</i>

2. <i>Kumar S, Pauline G, Vindal V. NetVA: an R package for network vulnerability and influence analysis. J Biomol Struct Dyn. 2024 Jan 17:1-12. doi: 10.1080/07391102.2024.2303607. PMID: 38234040.</i>
