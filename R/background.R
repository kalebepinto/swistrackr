#' Background Info
#'
#' \code{background} is used to import an image.jpg previously created in
#' an image editor that corresponds to a video frame used in Swistrack4
#' that #' does not contain the tracked particle. Later, this file will
#' be used to define the zones of interest to be analyzed.
#'
#' @param image.jpg Image in .jpg extension created in an image editor
#'
#' @return Height and Width dimensions from background video
#' @examples background(image.jpg = 'bg-swistrack-1.jpg')
#'
#' @export

if(!require(jpeg)){
  install.packages('jpeg')
}

background <- function(image.jpg = NA){
  if (!file.exists(image.jpg)){
    stop('File not found.', call. = F)
  }
  if (grepl('\\.jpg$', image.jpg) == FALSE){
    stop('Not a JPEG file.', call. = F)
  }
  img <- jpeg::readJPEG(image.jpg)
  dimen <- data.frame(image.jpg, dim(img)[1], dim(img)[2])
  colnames(dimen) <- c('Image Name', 'Height', 'Width')
  rownames(dimen) <- 1
  rm(img)
  returnValue(dimen)
}
