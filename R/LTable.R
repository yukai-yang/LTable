#################################################################################
## package name: LTable
## author: Yukai Yang
## Statistiska Inst., Uppsala Universitet
## May 2013
#################################################################################

acat <- function(string,file=""){
  cat(string,file=file,sep="",fill=T,append=T)
}

#' Make LaTeX table code from R objcts.
#'
#' This function makes LaTeX table code from R objcts.
#'
#' The function saves LaTeX users' time for writing tables. It uses directly the results from R to produce LaTeX table code.
#'
#' The function handels values in \code{...} in the following way:
#'
#' Elements in \code{...} will be binded by row.
#'
#' If an element in \code{...} is a list, then its element will be binded by column.
#'
#' Missing values will be filled by empty character "".
#'
#' @param ... can be matrices, data.frames, or lists of matrices or data.frames.
#' @param caption a character string of the caption.
#' @param label a character string of the label.
#' @param indent a boolean indicating if indent.
#' @param file a connection, or a character string naming the file to print to. If "" (the default), ltable prints to the standard output connection, the console unless redirected by sink. If it is "|cmd", the output is piped to the command given by 'cmd', by opening a pipe connection.
#'
#' @author Yukai Yang, \email{yukai.yang@@statistik.uu.se}
#'
#' @keywords LTable
#'
#' @examples
#' x = matrix(rnorm(9),3,3)
#' y = data.frame(a=c('a','b','c','d'),b=1:4)
#' z = matrix(0,2,5)
#' LTable(y,caption="Hello!",list(round(x,2),z),label="tab:hi",indent=TRUE)
#'
#' @export
LTable <- function(..., caption="", label="", indent=F, file="")
#     inside a list, by column; by row otherwise
{
  lObj = list(...)
  iN = length(lObj)
  if(iN==0) return("Nothing to print!")

  lP = list()
  length(lP) = iN
  for(iter in 1:iN){
    if(is.list(lObj[[iter]]) && !is.data.frame(lObj[[iter]])) lP[[iter]] = lObj[[iter]]
    else{
      lP[[iter]] = list()
      lP[[iter]][[1]] = lObj[[iter]]
    }
  }

  mncol <- function(lmat){
    return(sum(sapply(lmat,ncol)))
  }

  mnrow <- function(lmat){
    return(max(sapply(lmat,nrow)))
  }

  icn = max(sapply(lP,mncol))
  align = NULL
  for(iter in 1:icn) align = paste0(align,'c')

  lines = NULL

  for(tmp in lP){
    nt = icn-mncol(tmp)
    tail = NULL
    if(nt > 0) for(iter in 1:nt) tail = paste0(tail," & ")
    tail = paste0(tail," \\\\")

    nt = mnrow(tmp)
    for(iter in 1:nt){
      line = NULL
      for(jter in 1:length(tmp)){
        if(nrow(tmp[[jter]])>=iter){
          for(kter in 1:ncol(tmp[[jter]])) line = paste0(line," & ",as.character(tmp[[jter]][iter,kter]))
        }else{
          for(kter in 1:ncol(tmp[[jter]])) line = paste0(line," & ")
        }
      }
      line = substr(line,3,nchar(line))
      line = paste0(line,tail)
      lines = c(lines,line)
    }
  }

  cat("\\begin{table}",file=file,sep="",fill=T,append=F)
  if(indent){
    acat("  \\centering",file)
    acat(paste0("  \\begin{tabular}{",align,"}"),file)
    acat("    \\hline",file)
    acat("    \\hline",file)
    for(line in lines){
      acat(paste0("    ",line),file)
      acat("    \\hline",file)
    }
    acat("    \\hline",file)
    acat("  \\end{tabular}",file)
    acat(paste("  \\caption{",caption,"}",sep=''),file)
    acat(paste("  \\label{",label,"}",sep=''),file)
  }else{
    acat("\\centering",file)
    acat(paste0("\\begin{tabular}{",align,"}"),file)
    acat("\\hline",file)
    acat("\\hline",file)
    for(line in lines){
      acat(line,file)
      acat("\\hline",file)
    }
    acat("\\hline",file)
    acat("\\end{tabular}",file)
    acat(paste("\\caption{",caption,"}",sep=''),file)
    acat(paste("\\label{",label,"}",sep=''),file)
  }
  cat("\\end{table}",file)
}

