#' Calculate time in zones
#'
#' \code{times} calculates the time in seconds that the tracked particle
#' remains in the zones of interest. The function uses the framerate
#' of the analyzed video and the number of frames located within the
#' zone of interest as parameters to calculate the result.
#'
#' @param output.swtr Swistrack4 output containing the xy coordinates
#' and frames of the video tracked particle
#' @param zones.swtr Table with the coordinates of the zones of interest
#' created with the \code{zones} function
#' @param video.swtr Object containing the information of the video
#' created with the \code{track_video} function
#'
#' @return A table containing the values of time that the particle
#' remained in each of the zones of interest.
#' @examples times(output.swtr, zones.swtr, video.swtr)
#'
#' @export

if(!require(sp)){
  install.packages('sp')
  library(sp)
}
if(!require(jpeg)){
  install.packages('jpeg')
  library(jpeg)
}

times <- function(output.swtr = NA, zones.swtr = NA, video.swtr = NA){
  n <- 1:length(levels(as.factor(zones.swtr$Zones))) #Varia de acordo com numero de zonas
  ord <- 1:nrow(output.swtr) # Varia de acordo com o numero de frames da tabela de coordenadas
  t <- NA # Recebe o valor de tempo calculado
  z <- NA # Recebe o nome da zona de interesse
  for(i in 1:length(n)){
    temp <- point.in.polygon(output.swtr$x, output.swtr$y,
                             zones.swtr[grep(paste0('\\Zone ', n[i]),
                                             zones.swtr[, 1]), 2],
                             zones.swtr[grep(paste0('\\Zone ', n[i]),
                                             zones.swtr[, 1]), 3]) != 0
    zon <- rep(paste0('Zone ', n[i]), length(temp))
    temp.a <- cbind.data.frame(ord, zon, temp)
    temp.n <- as.numeric(temp)
    t[i] <- sum(temp.n) / video.swtr[[3]]
    z[i] <- zon[1]
  }
  time <- data.frame(z, t)
  colnames(time) <- c('Zone Name', 'Current Time (s)')
  returnValue(time)
}
