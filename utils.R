capFirst <- function(x) {
  s <- strsplit(x, " ")[[1]]
  paste(toupper(substring(s, 1, 1)), substring(s, 2),
    sep = "", collapse = " ")
}

# This function helps to source multiple files which are in the same directory. Just provide it with a path and all .R files in the directory it is
# pointed to will be sourced. Can be done recursively or not.
sourceDirectory <- function(path, recursive = FALSE, local = TRUE) {
  if (!dir.exists(path)) {
    warning(paste(path, "is not a valid directory!"))
    return(NULL)
  }

  # Source it where function is called (local)
  if (is.logical(local) && local) { env <- parent.frame() }
    # Source it in global environment
  else if (is.logical(local) && !local) { env <- globalenv() }
    # Source it in defined environment
  else if (is.environment(local)) { env <- local }
  else { stop("'local' must be TRUE, FALSE or an environment") }

  files <- list.files(path = path, pattern = ".*\\.R", all.files = F, full.names = TRUE, recursive = recursive)
  for (fileToSource in files) {
    tryCatch(
      {
      source(fileToSource, local = env)
      cat(fileToSource, "sourced.\n")
    },

      error = function(cond) {
        message("Loading of file \"", fileToSource, "\" failed.")
        message(cond)
      }

    )
  }
}

data_atDate_greece <<- function(inputDate) {
  data_greece_region_timeline[which(data_greece_region_timeline$date == inputDate),] %>%
    distinct()
}

# wordcloud2 alternative implemenation, to fix this issue:
# https://github.com/rstudio/shinydashboard/issues/281#issuecomment-615888981
wordcloud2a <- function (data, size = 1, minSize = 0, gridSize = 0, fontFamily = "Segoe UI", 
                         fontWeight = "bold", color = "random-dark", backgroundColor = "white", 
                         minRotation = -pi/4, maxRotation = pi/4, shuffle = TRUE, 
                         rotateRatio = 0.4, shape = "circle", ellipticity = 0.65, 
                         widgetsize = NULL, figPath = NULL, hoverFunction = NULL) 
{
  if ("table" %in% class(data)) {
    dataOut = data.frame(name = names(data), freq = as.vector(data))
  }
  else {
    data = as.data.frame(data)
    dataOut = data[, 1:2]
    names(dataOut) = c("name", "freq")
  }
  if (!is.null(figPath)) {
    if (!file.exists(figPath)) {
      stop("cannot find fig in the figPath")
    }
    spPath = strsplit(figPath, "\\.")[[1]]
    len = length(spPath)
    figClass = spPath[len]
    if (!figClass %in% c("jpeg", "jpg", "png", "bmp", "gif")) {
      stop("file should be a jpeg, jpg, png, bmp or gif file!")
    }
    base64 = base64enc::base64encode(figPath)
    base64 = paste0("data:image/", figClass, ";base64,", 
                    base64)
  }
  else {
    base64 = NULL
  }
  weightFactor = size * 180/max(dataOut$freq)
  settings <- list(word = dataOut$name, freq = dataOut$freq, 
                   fontFamily = fontFamily, fontWeight = fontWeight, color = color, 
                   minSize = minSize, weightFactor = weightFactor, backgroundColor = backgroundColor, 
                   gridSize = gridSize, minRotation = minRotation, maxRotation = maxRotation, 
                   shuffle = shuffle, rotateRatio = rotateRatio, shape = shape, 
                   ellipticity = ellipticity, figBase64 = base64, hover = htmlwidgets::JS(hoverFunction))
  chart = htmlwidgets::createWidget("wordcloud2", settings, 
                                    width = widgetsize[1], height = widgetsize[2], sizingPolicy = htmlwidgets::sizingPolicy(viewer.padding = 0, 
                                                                                                                            browser.padding = 0, browser.fill = TRUE))
  chart
}

# function that breaks a long string into lines
str_trimmer <- function(string, break_limit, collapse = "<br>"){
  sapply(strwrap(string, break_limit, simplify=FALSE), paste, collapse=collapse)
}

# Five color palette for map
map_pal <- colorQuantile(palette = c("#AAAAAA",
                                     "#A5CB81",
                                     "#F6BC26",
                                     "#E5712A",
                                     "#AC242A"),
                         domain = 0:4, n = 5, reverse = FALSE)
