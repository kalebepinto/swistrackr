#' Video Analyzed Info
#'
#' \code{track_video} is used to read a video in .avi extension that has been
#' analysed in the Swistrack4. Subsequently, this file will be used to
#' measure the running time in seconds that a particle of interest remained
#' in the user's zones of interest.
#'
#' @param video.avi Video name in the directory, in .avi extension analyzed in Swistrack4 program.
#'
#' @return Running time in seconds and framerate from video
#' @examples track_video(video.avi = system.file('extdata', 'video-swistrack-1.avi', package = 'swistrackr'))
#'
#' @export

track_video <- function(video.avi = NA){
  if(nchar(Sys.which('ffmpeg')) == 0){
    stop('ffmpeg not found. Install ffmpeg to continue.', .call = F)
  }
  if (!file.exists(video.avi)){
    stop('Swistrack video not found', call. = F)
  }
  if (grepl('\\.avi$', video.avi) == FALSE){
    stop('Not a AVI file.', call. = F)
  }
  video.avi <- gsub('.+/', '',video.avi)
  wa <- getOption('warn') # Desabilitar temporariamente os warnings
  options(warn = -1)
  outff <- system(paste0('ffmpeg -i ' , video.avi, ' 2>&1'), intern = T)
  options(warn = wa) # Devolve os warnings para o usuario
  du <- outff[grep('Duration', outff)]
  du <- gsub(', *.+', '', du)
  du <- gsub('.+Duration: ', '', du)
  hours <- as.numeric(unlist(strsplit(du, ':'))[1])
  minutes <- as.numeric(unlist(strsplit(du, ':'))[2])
  seconds <- as.numeric(unlist(strsplit(du, ':'))[3])
  du <- hours * 3600 + minutes * 60 + seconds # Duracao em segundos
  fps <- outff[grep('fps', outff)] # Pegar fps parte 1
  fps <- gsub(' fps.+', '',fps) # Pegar fps parte 2
  fps <- gsub('.+kb/s, ', '',fps) # Pegar fps parte 3
  fps <- as.numeric(fps) # Pegar fps parte 4
  out <- data.frame(video.avi, du, fps)
  colnames(out) <- c('Video Name', 'Running time (s)', 'FPS')
  rownames(out) <- 1
  rm(wa); rm(outff); rm(du); rm(hours); rm(minutes); rm(seconds); rm(fps)
  returnValue(out)
}
