% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/edec_stage_1.R
\name{run_edec_stage_1}
\alias{run_edec_stage_1}
\title{Run EDec stage 1 algorithm.}
\usage{
run_edec_stage_1(meth_bulk_samples, informative_loci, num_cell_types,
  max_its = 2000, rss_diff_stop = 1e-10)
}
\arguments{
\item{meth_bulk_samples}{Matrix with methylation profiles of bulk tissue
samples. Rows correspond to loci/probes and columns correspond to different
samples.}

\item{informative_loci}{A vector containing names (strings) of rows
corresponding to loci/probes that are informative for distinguishing cell
types.}

\item{num_cell_types}{Number of cell types to use in deconvolution.}

\item{max_its}{Maximum number of iterations after which the algorithm will
stop.}

\item{rss_diff_stop}{Maximum difference between the residual sum of squares
of the model in two consecutive iterations for the algorithm to converge.}
}
\value{
A list with the following components:

\describe{
 \item{\code{methylation}}{A matrix with average methylation profiles of
  constituent cell types. Rows represent different loci/probes and columns
  represent different cell types.}
 \item{\code{proportions}}{A matrix with proportions of constituent cell
  types in each input sample. Rows represent different samples. Columns
  represent different cell types.}
 \item{\code{iterations}}{Number of iterations the method went through before
reaching convergence or maximum number of iterations.}
 \item{\code{explained.variance}}{Proportion of variance in input methylation
  profiles over informative loci explained by the final model.}
 \item{\code{res.sum.squares}}{Residual sum of squares for the final model
  over the set of informative loci.}
 \item{\code{aic}}{Akaike Information Criterion for the final model over the
  set of informative loci.}
 \item{\code{rss.per.iteration}}{Vector of residual sum of squares for the
  models generated in each iteration of the algorithm.}
 }
}
\description{
\code{run_edec_stage_1} takes as input the methylation profiles of complex tissue
samples, the set of loci with high variability in methylation across cell
types, and the number of constituent cell types. It then estimates the
average methylation profiles of constituent cell types, and the proportions
of constituent cell types in each input sample.
}
\details{
The first stage of EDec performs constrained matrix factorization to find
cell type specific methylation profiles and constituent cell type proportions
that minimize the Euclidian distance between their linear combination and the
original matrix of tissue methylation profiles. The minimization algorithm
involves an iterative procedure that, in each round, alternates between
estimating constituent cell type proportions (using \code{\link{estimate_props_qp}}
function) and methylation profiles (using \code{\link{estimate_meth_qp}} function)
by solving constrained least squares problems through quadratic programming.
The minimization problem is made tractable by the constraints that
methylation measurements (beta values) and cell type proportions are numbers
in the [0,1] interval, and that cell type proportions within a sample add up
to one. These constraints restrict the space of possible solutions, thus
making it possible for the local iterative search to reproducibly find a
global minimum and an accurate solution. One key requirement for EDec is that
cell type proportions vary across samples. A second requirement is that there
must be significant differences across constituent cell type methylation
profiles. The latter requirement can be met by providing EDec with loci
expected to vary in methylation levels across constituent cell types.
}

