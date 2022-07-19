# analyzeBehaviorspace is open-source software; you can redistribute it and/or
# modify it under the terms of the MIT License as published by the Open Source
# Initiative.
#
# analyzeBehaviorspace is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the MIT License for more details.
#
# You should have received a copy of the MIT License along with this program; if
# not, see <https://opensource.org/licenses/MIT>.

# shinystan is free software; you can redistribute it and/or modify it under the
# terms of the GNU General Public License as published by the Free Software
# Foundation; either version 3 of the License, or (at your option) any later
# version.
#
# shinystan is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, see <http://www.gnu.org/licenses/>.
#' ShinyStan interface and shinystan R package
#'
#' @docType package
#' @name analyzeBehaviorspace
#' @keywords internal
#'
#' @description
#'
#' Applied Bayesian data analysis is primarily implemented through the Markov
#' chain Monte Carlo (MCMC) algorithms offered by various software packages.
#' When analyzing a posterior sample obtained by one of these algorithms the
#' first step is to check for signs that the chains have converged to the target
#' distribution and and also for signs that the algorithm might require tuning
#' or might be ill-suited for the given model. There may also be theoretical
#' problems or practical inefficiencies with the specification of the model.
#' ShinyStan provides interactive plots and tables helpful for analyzing a
#' posterior sample, with particular attention to identifying potential problems
#' with the performance of the MCMC algorithm or the specification of the model.
#' ShinyStan is powered by RStudio's Shiny web application framework and works
#' with the output of MCMC programs written in any programming language (and has
#' extended functionality for models fit using the rstan package and the
#' No-U-Turn sampler).
#'
#' @section License:
#'
#'  The \pkg{analyzeBehaviorspace} package is open source licensed under the
#'  MIT License.
#'
#' @section Bug reports:
#' \itemize{
#'  \item analyzeBehaviorspace issue tracker (\url{https://github.com/jonathan-g/analyzeBehaviorspace/issues})
#' }
#'
#'
#' @import shiny
#' @import dplyr
#' @import tidyr
#' @import purrr
#' @import readr
#' @import stringr
#' @import ggplot2
#' @import janitor
#' @importFrom rlang .data
#' @importFrom stats na.omit sd
#'
NULL
