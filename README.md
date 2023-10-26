# NetVA
<i> An R package for network vulnerability and influence analysis </i>

<b>General information</b>:

Version: 1.0.0

Date: 2022-02-04

Depends: R (>= 3.0.0), igraph

Imports: parallel

<b>Description</b>: The NetVA assists in network analysis with two approaches: (1) Performs network vulnerability analysis and help to identify vulnerable nodes (VNs) or proteins (VPs) for a given protein-protein interaction (PPI) network. Hence, network vulnerability analysis is an approach to identify VPs by assessing networks based on its topological properties. The VPs are identified based on nine different topological properties calculated for networks as constructed by deleting all nodes/proteins, one by one, from the original network under investigation. This package provides the capabilities to use multiple cores on Linux/macOS to parallelize the process using parallel package. (2) Performs network influence analysis to identify influential nodes (INs) i.e. key nodes with ranking by calculating escape velocity centrality (EVC) and extended escape velocity centrality (EVC+). It also helps to identify hubs and bottlenecks present in the given network based on the well-known pareto-principle of 80:20 rule. An illustrative tutorial on how to use various functions of this package for network vulnerability and influence analysis has been provided in <b>Tutorial_Rscript</b>.

<b>Installation</b>: The NetVA package can be installed on R console using:

> devtools::install_github("kr-swapnil/NetVA")

<b>Available functions</b>:
	
  netva(): Performs vulnerability analysis with or without parallel processing. Parallel processing works only on Linux/macOS machines but not on Windows based machines.
  
  detectVNs(): Detects VPs based on the five-point summary of boxplot for each topological properties included in the package.
  
  evc(): Calculates EVC and EVC+ values of each nodes present in a given network.
  
  detectINs(): Detects influential nodes i.e. proteins based on the values of EVC and EVC+ for a given network.
  
  detectHubs(): Identify hub proteins in the given network based on the Pareto-principle of 80:20 rule followed by tuning of identified hubs against PPI data noise using rewiring of a given percentage of edges as per the user's choice in the network.
  
  detectBottlenecks(): Identify bottleneck proteins in the given network based on the Pareto-principle of 80:20 rule followed by tuning of identified bottlenecks against PPI data noise using rewiring of a given percentage of edges as per the user's choice in the network.
	
  heterogeneity(): Calculates the value of heterogeneity for a given network.
  
  cohesiveness(): Calculates the cohesiveness of a given network as it is or after the removal of a node of interest.

  compactness(): Calculates the compactness of a given network as it is or after the removal of a node of interest.
