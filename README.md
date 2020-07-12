# Goals of `solidagos`

This package aims to help ecologist evaluate -- via simulation -- the statistical properties of various sampling designs and study protocols for measuring populations. The framework created for this project allows users to ask "what if" questions about study designs for collecting data for ecological monitoring and species distibution models. The framework allows users to examine tradeoffs in design and protocols in terms of bias and variance of target estimands.

Using roadsides as an example, say we want to estimate the distribution of two prairie remnant species on roadsides in a given area. One species is thought to be rare but occurs in a variety of environmental conditions; the other species is thought to be common in particular environmental conditions. The ultimate goal of the study is to produce a species distribution map of those two species. How should we design a study to collect data on these two species? Before implemenentation, example of questions that the study should address include:

* What are the sampling units? That is, how should the study area be divided into smaller units, such as rectangular quadrats or points, for study?
* How should sampling units be selected? By simple random sample? By expert input?
* What protocol do observers follow in the field? Do they walk a line-transect through a sampling unit?
* How well trained do the observers need to be in identification of the target species?

The goal of `solidago` is to simplify the process answering such questions and understanding trade-offs in study designs.
