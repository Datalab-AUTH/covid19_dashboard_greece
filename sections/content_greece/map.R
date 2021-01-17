
output$overview_map_greece <- renderImage({
  # A temp file to save the output.
  # This file will be removed later by renderImage
  outfile <- "data/greece_map/map.png"
  outfile_size <- 800
  
  # Return a list containing the filename
  list(src = outfile,
       contentType = 'image/png',
       width = outfile_size,
       height = outfile_size,
       alt = "This is alternate text")
}, deleteFile = FALSE)