# NetVA
<i> An R package for network vulnerability and influence analysis </i>

<b>General information</b>:

Version: 1.0

Date: 2022-02-04

Depends: R (>= 3.6.0), igraph (>= 1.2.5)

Imports: parallel (>= 0.1)

<b>Description</b>: The NetVA assists in network analysis with two approaches: (1) Performs network vulnerability analysis and help to identify vulnerable or critical proteins (VPs) for a given protein-protein interaction (PPI) network. Hence, network vulnerability analysis is an approach to identify VPs by assessing networks based on its topological properties. The VPs are identified based on nine different topological properties calculated for networks as constructed by deleting all nodes/proteins, one by one, from the original network under investigation. This package provides the capabilities to use multiple cores on Linux/macOS to parallelize the process using parallel package. (2) Performs network influence analysis to identify key nodes with ranking by calculating escape velocity centrality (EVC) and extended escape velocity centrality (EVC+). It also helps to identify hubs and bottlenecks present in the given network based on the well-known pareto-principle of 80:20 rule. An illustrative tutorial on how to use various functions of this package for network vulnerability analysis has been provided in <b>Tutorial_Rscript</b>.

<b>Installation</b>: The NetVA package can be installed on R console using:

> devtools::install_github("kr-swapnil/NetVA")

<b>Available functions</b>: netva.mc(): Performs vulnerability analysis with parallel processing (only compatible on Linux/macOS machine).
	
  netva.sc(): Performs vulnerability analysis without parallel processing (compatible on any Linux, macOS or Windows based machines.
  
  detectVPs(): Detects VPs based on the five-point summary of boxplot for each topological properties included in the package.
  
  detectHubs(): Identify hub proteins in the given network based on the Pareto-principle of 80:20 rule.
  
  detectBottlenecks(): Identify bottleneck proteins in the given network based on the Pareto-principle of 80:20 rule.
	
  heterogeneity(): Calculates the value of heterogeneity for a given network.
  
  evc(): Calculates EVC and EVC+ values of each nodes present in a given network. <b>[Currently not available]</b>

<b>How to cite</b>

If you find NetVA useful, please cite the following publication:
<i>Kumar S, D GP, Vindal V (2022). NetVA: An R package for network vulnerability analysis. R package version 1.0.</i>
