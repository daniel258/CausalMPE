## Simulation Scenarios
This file summarize the details of the different simulation scenarios. The numbering of the scenarios was only for internal needs. It is presented here for convenience. 

The data was simulated from model (2) with no covariates $X$. In the code, ``betaE`` is a bivariate vector representing $\beta_1$ and $\beta_2$ from equation (2), and ``betaU`` is a bivariate vector representing $\theta_1$ and $\theta_2$. The parameters $\alpha_1$ and $\alpha_2$ are represented by the bivariate vector ``beta0``, and are fixed in all *rare outcome* scenarios.

In the *rare outcome* scenarios (which are our main scenarios), we fixed ``beta0=c(-6, -5)``. Under each scenario, we conducted simulations under 36 sub-scenarios, created by considering six different values for ``betaE2`` ($\beta_2$) and six values for either ``betaU1``, ``betaU2`` or both, depending on the scenario. These values are indicated by the term ``patt`` in the simulation scripts and is represented by two-latter suffix for each file name. The first latter indicates the value of ``exp(betaE2)`` ($exp(\beta_2)$) (A => 1.25, B => 1.5, C => 1.75, D => 2, E => 2.25, F => 2.5) and the second indicates the value of ``exp(betaU1)``, ``exp(betaU2)`` or both (A => 2, B=> 3,C => 4, D => 5, E => 6, F => 7). The table below summarizes the different scenarios for rare outcomes.


Scenario    |  exp(betaE1) |  exp(betaE2) | exp(betaU1) | exp(betaU2) |
------------| ------------ | ------------ | ----------- | ----------- |
Main        |      1       | 1st letter   | 2nd letter  | 2nd letter  |
1           |      1       | 1st letter   |     5       | 2nd letter  |
1a          |      1       | 1st letter   | 2nd letter  |      5      |
2           |      1       | 1st letter   |     2.5     | 2nd letter  |
3           |      1       | 1st letter   |     5       | 2nd letter  |
4           |      1       | 1st letter   |     5       | 2nd letter  |


