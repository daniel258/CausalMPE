# CausalMPE
R Code and simulations associated with the paper "Causal effects in the presence of disease etiologic heterogeneity" by Nevo et al. Comments and suggestions are welcomed and can be sent to 
danielnevo :panda_face: @ :panda_face: gmail.com (remove the pandas)

This repository includes three main parts
1. Simulations: Simulation scripts, simulation results and simulation summary.
2. Code for sensitivity analysis.
3. Hypothetical data example demonstrating the bias.

## Simulations
The *Simulations* folder includes four folders:

1. *Scripts*: Includes the scripts to run the code. The code was ran on a cluster, and each simulation setup was written in a different *R* script. Therefore, you can find the *R* scripts, the shell scripts, and the scripts that were used to collect all the results and save them in one excel file (see Results below). 
2. *Results*: Three excel files summarizing results for all considered parameter values for the following scenarios:
  * Main simulation study: two subtypes, null effect of the exposure on subtype 1 and harmful effect on subtype 2. As written in the paper, following the results of this simulation study, two more scenarios were considered:
  * A scenario with null effect of the exposure on both subtypes.
  * A scenario with harmful effect of the exposure on a single unified disease (no subtypes).
3. *Plots*: Includes the four plots published in the paper.
4. *PlotScripts*: Scripts to recreate the plots (in *Plots* folder) using the simulation results (from the *Results* folder).

## Hypothetical example

## Hypothetical example

