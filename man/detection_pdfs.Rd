% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/detectors.R
\name{detection_pdfs}
\alias{detection_pdfs}
\alias{phnorm}
\title{Detection PDFs}
\usage{
phnorm(x, y, theta)
}
\arguments{
\item{x}{x-coordinates for specimens}

\item{y}{y-coordinates for specimens}

\item{theta}{mean parameter for half normal distribution}
}
\description{
Detects specimens with decaying probability with > y, irregardless of x.
}
\references{
Clark RG (2016) Statistical Efficiency in Distance Sampling. PLoS ONE 11(3): e0149298.
doi:10.1371/journal.pone.0149298
}
