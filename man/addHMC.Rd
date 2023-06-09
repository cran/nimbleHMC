% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/configuration.R
\name{addHMC}
\alias{addHMC}
\title{Add HMC sampler}
\usage{
addHMC(
  conf,
  nodes = character(),
  control = list(),
  replace = FALSE,
  print = TRUE
)
}
\arguments{
\item{conf}{A nimble MCMC configuration object, as returned by `configureMCMC`.}

\item{nodes}{A character vector of continuous-valued stochastic node names to sample by HMC.  If this argument contains any discrete-valued nodes, an error is produced and no HMC sampler is added.}

\item{control}{Optional named list of control parameters to be passed as the `control` argument to `sampler_HMC`.  See `help(sampler_HMC)` for details.}

\item{replace}{Logical argument.  If `TRUE`, any existing samplers operating on the specified nodes will be removed, prior to adding the HMC sampler.  Default value is `FALSE`.}

\item{print}{Logical argument whether to print the newly added HMC sampler.  Default value is `TRUE`.}
}
\value{
Invisibly returns an object of class `MCMCconf`, but this function is primary called for its side effect.
}
\description{
Add a Hamiltonian Monte Carlo (HMC) sampler to an existing nimble MCMC configuration object
}
\details{
This is a helper function, which invokes the `addSampler` method of the MCMC configuration object, to add an HMC sampler to an MCMC configuration.

Use this function if you have created an MCMC configuration and want to add an HMC sampler.

If more Use `conf$addSampler` instead if you need more fine-grained control.  See `help(configureMCMC)` in nimble.
}
\examples{
nimbleOptions(enableDerivs = TRUE)

code <- nimbleCode({
    b0 ~ dnorm(0, 0.001)
    b1 ~ dnorm(0, 0.001)
    sigma ~ dunif(0, 10000)
    for(i in 1:N) {
        mu[i] <- b0 + b1 * x[i]
        y[i] ~ dnorm(mu[i], sd = sigma)
    }
})

N <- 10
constants <- list(N = N, x = 1:N)
data <- list(y = 1:N)
inits <- list(b0 = 1, b1 = 0.1, sigma = 1)

Rmodel <- nimbleModel(code, constants, data, inits, buildDerivs = TRUE)

## create MCMC configuration object
conf <- configureMCMC(Rmodel, nodes = NULL)

## add HMC sampler operating on all stochastic model nodes
addHMC(conf)

Rmcmc <- buildMCMC(conf)

# Cmodel <- compileNimble(Rmodel)
# Cmcmc <- compileNimble(Rmcmc, project = Rmodel)
# samples <- runMCMC(Cmcmc)
}
\seealso{
\code{\link{configureHMC}} \code{\link{buildHMC}} \code{\link{sampler_HMC}} \code{\link{configureMCMC}} \code{\link{addSampler}}
}
\author{
Daniel Turek
}
