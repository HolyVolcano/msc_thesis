#' Plot a heatmap of dyadic cross-correlations
#'
#' Graphical representation of the lagged cross-correlations in time. Provides an intuitive description of synchronization dynamics.
#'
#' @param mea an object of class \code{MEA} (see function \code{\link{readMEA}}).
#' @param legendSteps integer. the number of levels used for the color-coding of the legend.
#' @param rescale logical. If TRUE, the color range will represent the minimum and maximum of the data. Otherwise the theoretical correlation range -1 to 1.
#' @param colors a vector of colors defining the plot scale.
#' @param bias a positive number. Allows to skew the color scale. Values larger than 1 give more widely spaced colors at the high end, and vice versa.
#' @param mirror logical. If TRUE, colors are mirrored for negative correlation values. This has effect only if \code{\link{MEAccf}} was run with \code{ABS=FALSE}
#'
#' @details The cross-correlation values are rescaled to be in a range from 0 to 1 before plotting.
#' @export

MEAheatmap  = function(mea, legendSteps = 10, rescale = FALSE, colors = c("#F5FBFF","#86E89E","#FFF83F","#E8A022","#FF3700"), bias = 1, mirror=TRUE){
  if(!is.MEA(mea) || is.null(mea$ccf)) stop("Only MEA objects with ccf analysis can be plotted by this function.",call.=F)
  ABS = !any(stats::na.omit(mea$ccf)<0) #do we have negative numbers?
  mat = mea$ccf
  if(grep("z",attributes(mea)$ccf$filter)) mat = tanh(mat) #revert fisher's z transform to have -1:1 range
  if(rescale){
    if(ABS) mat = rangeRescale(mat, 0,1)
    else    mat = rangeRescale(mat,-1,1)
  }

  sampRate = attr(mea,"sampRate")

  if(ABS){
    bins = seq(1/legendSteps,1, by=1/legendSteps)
    colfunc <- grDevices::colorRampPalette(colors=colors, bias=bias)
  }  else {
    bins = seq(-1+2/legendSteps,1, by=2/legendSteps)
    if(mirror) colfunc <- grDevices::colorRampPalette(colors=c(rev(colors[2:length(colors)]), colors), bias=bias)
    else colfunc <- grDevices::colorRampPalette(colors=colors, bias=bias)
  }

  colz = colfunc(legendSteps)
  colz = c(colz,"#aaaaaa") #colore degli NA

  plotH = ncol(mat)
  plotW = nrow(mat)
  leg_area = 1/5*plotW #legend area
  myYlim = c(1,plotH+1)
  myXlim = c(1,plotW+leg_area)
  oldPar = graphics::par("mar")
  graphics::par(mar=c(5, 6, 4, 2) + 0.1)
  base::plot(0,type="n",xlim=myXlim, ylim=myYlim,bty="n",axes=F,xlab="ccf windows",
       ylab=paste(attr(mea,"s2Name"),"leading    <<< ---   simultaneous  --- >>>    ",attr(mea,"s1Name"),"leading\nseconds"),
       main = paste0("Group: ",attr(mea,"group"),", id: ",attr(mea,"id"),", session: ",attr(mea,"session") ))
  mtext_lab = paste0(attr(mea,"ccf")$filter," with ", attr(mea,"ccf")$win,"s windows and ",attr(mea,"ccf")$inc,"s increments." )
  graphics::mtext(mtext_lab,side = 3)
  #axis
  xleft = rep(1:plotW, each =plotH)
  ybottom = rep(1:plotH,plotW)
  graphics::axis(1,at = 0.5+(1:attr(mea,"ccf")$n_win),labels=(1:attr(mea,"ccf")$n_win) )
  graphics::axis(2,at = 1.5+(-attr(mea,"ccf")$lag :attr(mea,"ccf")$lag )*sampRate + attr(mea,"ccf")$lag*sampRate,
       labels=-attr(mea,"ccf")$lag:attr(mea,"ccf")$lag )


  #to debug
  # mat[,1] = 1
  # mat[20:40,50:70]=NA

  vals = c(t(mat))

  #debug
   # vals[ncol(mat)*(0:nrow(mat))+1] = 1

  iCol = sapply(vals,function(x)sum(x>bins)+1)
  iFill = iCol
  iCol[is.na(iCol)]=length(colz)
  iFill[!is.na(iFill)] = NA
  iFill[is.na(iFill)] = 40

  graphics::rect(xleft,ybottom,xleft+1,ybottom+1,col = colz[iCol],border = NA)

  getNA = which(is.na(mat),arr.ind = T)
  if(length(getNA)>0)
    graphics::rect(getNA[,1],getNA[,2],getNA[,1]+1,getNA[,2]+1,col = 0,border = NA,density = 20)


  #legend

  na_y1 = 1
  na_y2 = plotH/100 * 10
  leg_x1 = plotW+1.5/5*leg_area
  leg_x2 = plotW+3.5/5*leg_area
  leg_y1 = plotH/100*15
  leg_y2 = plotH
  leg_incr = (plotH/100*85 )/legendSteps

  label_0 = plotH/100*20
  label_1 = plotH/100*97
  label_00 =label_0+(label_1-label_0)/2



  graphics::rect(leg_x1, na_y1,leg_x2, na_y2
       ,col = "#aaaaaa",border = NA)
  graphics::rect(leg_x1, na_y1,leg_x2, na_y2
       ,col = 0,border = NA,density = 20)



  legend_border = ifelse(legendSteps>50,NA,0)
  graphics::rect(
    leg_x1,
    seq(leg_y1,leg_y2-leg_incr, by=leg_incr),
    leg_x2,
    seq(leg_y1+leg_incr,leg_y2, by=leg_incr),
    col = colz, border = legend_border
  )

  if(rescale)
    graphics::text(leg_x2, c(na_y2/2,label_0,label_1), labels = c("NA",min(mea$ccf,na.rm=T),max(mea$ccf,na.rm=T)),cex = 1.5,pos=4)
  else
    graphics::text(leg_x2, c(na_y2/2,label_0,label_1), labels = c("NA",ifelse(ABS,0,-1),1),cex = 1.5,pos=4)

}