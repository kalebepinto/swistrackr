#' Define Zones of Interest
#'
#' With \code{zones} the user determines the zones of interest, using
#' the background.jpg previously created. Zones of interest are used
#' to calculate information such as time in seconds, number of visits, or
#' order of zones visited.
#'
#' @param image.jpg Background image in .jpg format
#' @param nzones Number of interest zones in the video
#' @param pzones Number of points to select the zone of interest
#'
#' @return A table containing the x and y axis values for each zone of interest.
#' @examples zones('image.jpg = bg.image', nzones = 2, pzones = 4)
#'
#' @export

if(!require(sp)){
  install.packages('sp')
  library(sp)
}

zones <- function(image.jpg = NA, nzones = 1, pzones = 4){
  n <- 1:nzones
  img <- image.jpg
  plot(0:img[[3]], type = 'n', xlab = 'x (Pixels)', ylab = 'y (Pixels)',
       ylim = c(img[[2]], 0), lab = c(20, 10, 10), las = 2, bty = 'l')
  rasterImage(readJPEG(img[[1]]), 0, img[[2]], img[[3]], 0)
  for(i in 1:length(n)){
    lz <- locator(pzones)
    polygon(lz$x, lz$y, col = '#FF000080', border = '#FFCC0080')
    zone <- paste0('Zone ', n[i])
    if(n[i] == 1){
      values <- cbind.data.frame(rep(zone, pzones), lz$x, lz$y)
    }
    if(n[i] != 1){
      v2 <- cbind.data.frame(rep(zone, pzones), lz$x, lz$y)
      values <- rbind(values, v2)
    }
  }
  colnames(values) <- c('Zones', 'x', 'y')
  rm(n); rm(img); rm(lz); rm(zone); rm(v2)
  returnValue(values)
}
