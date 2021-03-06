% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/generics.R, R/pairRDD.R
\docType{methods}
\name{sampleByKey}
\alias{sampleByKey}
\alias{sampleByKey,RDD,logical,vector,integer-method}
\alias{sampleByKey,RDD-method}
\title{Return a subset of this RDD sampled by key.}
\usage{
sampleByKey(x, withReplacement, fractions, seed)

\S4method{sampleByKey}{RDD,logical,vector,integer}(x, withReplacement,
  fractions, seed)
}
\arguments{
\item{x}{The RDD to sample elements by key, where each element is
list(K, V) or c(K, V).}

\item{withReplacement}{Sampling with replacement or not}

\item{seed}{Randomness seed value}

\item{fraction}{The (rough) sample target fraction}
}
\description{
\code{sampleByKey} Create a sample of this RDD using variable sampling rates
for different keys as specified by fractions, a key to sampling rate map.
}
\examples{
\dontrun{
sc <- sparkR.init()
rdd <- parallelize(sc, 1:3000)
pairs <- lapply(rdd, function(x) { if (x \%\% 3 == 0) list("a", x)
                                   else { if (x \%\% 3 == 1) list("b", x) else list("c", x) }})
fractions <- list(a = 0.2, b = 0.1, c = 0.3)
sample <- sampleByKey(pairs, FALSE, fractions, 1618L)
100 < length(lookup(sample, "a")) && 300 > length(lookup(sample, "a")) # TRUE
50 < length(lookup(sample, "b")) && 150 > length(lookup(sample, "b")) # TRUE
200 < length(lookup(sample, "c")) && 400 > length(lookup(sample, "c")) # TRUE
lookup(sample, "a")[which.min(lookup(sample, "a"))] >= 0 # TRUE
lookup(sample, "a")[which.max(lookup(sample, "a"))] <= 2000 # TRUE
lookup(sample, "b")[which.min(lookup(sample, "b"))] >= 0 # TRUE
lookup(sample, "b")[which.max(lookup(sample, "b"))] <= 2000 # TRUE
lookup(sample, "c")[which.min(lookup(sample, "c"))] >= 0 # TRUE
lookup(sample, "c")[which.max(lookup(sample, "c"))] <= 2000 # TRUE
fractions <- list(a = 0.2, b = 0.1, c = 0.3, d = 0.4)
sample <- sampleByKey(pairs, FALSE, fractions, 1618L) # Key "d" will be ignored
fractions <- list(a = 0.2, b = 0.1)
sample <- sampleByKey(pairs, FALSE, fractions, 1618L) # KeyError: "c"
}
}

