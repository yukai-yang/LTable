# LTable package for producing tables in LaTeX
# author: Yukai Yang
# May 2013

acat <- function(string,file=""){
  cat(string,file=file,sep="",fill=T,append=T)
}

ltable <- function(...,caption="",label="",indent=F,file="")
# input:
#   ..., must be lists of matrices or data.frames, matrices, or data.frames
#     inside a list, by column; by row otherwise
#   caption, the caption string
#   label, the label string
#   indent, whether to indent
#   file, A connection, or a character string naming the file to print to. If "" (the default), ltable prints to the standard output connection, the console unless redirected by sink. If it is "|cmd", the output is piped to the command given by 'cmd', by opening a pipe connection.
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
  acat("\\end{table}",file)
}

#x = matrix(rnorm(9),3,3)
#y = data.frame(a=c('a','b','c','d'),b=1:4)
#z = matrix(0,2,5)
#ltable(y,caption="Hello!",list(round(x,2),z),label="tab:hi",indent=T)
