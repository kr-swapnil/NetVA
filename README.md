# NetVA
An R package for network vulnerability analysis

Version: 1.0

Date: 2022-02-04

Authors: Swapnil Kumar, Grace Pauline D, Vaibhav Vindal (Email ID: <vaibhav@uohyd.ac.in>)

Maintainer: Swapnil Kumar (Email ID: <swapnil.kr@yahoo.com>)

Depends: R (>= 4.1.0), igraph (>= 1.2.5)

Imports: parallel (>= 0.1)

Description: Performs network vulnerability analysis and help to identify vulnerable or critical proteins (VPs) for a given protein-protein interaction (PPI) network. Hence, network vulnerability analysis is an approach to identify VPs by assessing networks based on its topological properties. The VPs are identified based on nine different topological properties calculated for networks as constructed by deleting all nodes/proteins, one by one, from the original network under investigation. This package provides the capabilities to use multiple cores on Linux/macOS to parallelize the process using parallel package. It also helps to identify hubs and bottlenecks present in the given network based on the well-known pareto-principle of 80:20 rule.
