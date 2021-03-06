% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/options.R
\name{c3_colour}
\alias{c3_colour}
\title{Colour Palette}
\usage{
c3_colour(c3, colours)
}
\arguments{
\item{c3}{c3 htmlwidget object}

\item{colours}{character vector of colours}
}
\value{
c3
}
\description{
Manually assign colours
}
\examples{
data.frame(a = c(1,2,3,2), b = c(2,4,1,5)) \%>\%
  c3() \%>\%
  c3_colour(c('red','black'))

}
