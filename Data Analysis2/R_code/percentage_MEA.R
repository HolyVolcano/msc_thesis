## read the first sample (intake interviews of patients that carried on therapy)
path_normal <- system.file("extdata/hospital/Control/2092_BDH/body", package = "rMEA")
mea_normal <- readMEA(path_normal, sampRate = 25, s1Col = 1, s2Col = 2,
                      s1Name = "Patient", s2Name = "Therapist", skip=1,
                      idOrder = c("id","session"), idSep="_")

mea_all <- c(mea_normal)
summary(mea_all)

## Show diagnostics for the first session:
diagnosticPlot(mea_all[[1]])

plot(mea_all[[1]], from=1, to=200)

## Filter the data
mea_smoothed <- MEAsmooth(mea_all)

mea_rescaled <- MEAscale(mea_smoothed)

## Generate a random sample
mea_random <- shuffle(mea_rescaled)

mea_ccf <- MEAccf(mea_rescaled, lagSec= 5, winSec = 30, incSec=10, ABS = F)

# Raw data of the first session with running lag-0 ccf
plot(mea_ccf[[1]], from=100, to=300, ccf = "lag_zero")


# Heatmap of the first session
MEAheatmap(mea_ccf[[1]])


mea<-mea_ccf[[1]]
legendSteps = 10; rescale = FALSE; colors = c("#F5FBFF","#86E89E","#FFF83F","#E8A022","#FF3700"); bias = 1; mirror=TRUE

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
  
  valsClean <- vals[!is.na(vals)]
  
  #corr_orange <- sum(valsClean >= 0.4 | valsClean <= -0.4)
  corr_red <- sum(valsClean <= 1 & valsClean >= 0.6 | valsClean >= -1 & valsClean <= -0.6)
  
  # sum(valsClean <= -0.4)
  
  #per_orange <- (corr_orange/length(valsClean))*100
  per_red <- (corr_red/length(valsClean))*100
  
  ############################################ building M1 ############################################################
  H <- t(mat) 
  M1 <- H[1:125,] #dim(M1) -> 125, and the length of the window
  
  vals_M1 = c(M1)
  
  valsClean_M1 <- vals_M1[!is.na(vals_M1)]
  
  #corr_orange_M1 <- sum(valsClean_M1 >= 0.4 | valsClean_M1 <= -0.4)
  corr_red_M1 <- sum(valsClean_M1 <= 1 & valsClean_M1 >= 0.6 | valsClean_M1 >= -1 & valsClean_M1 <= -0.6)
  
  #per_orange_M1 <- (corr_orange_M1/length(valsClean_M1))*100
  per_red_M1 <- (corr_red_M1/length(valsClean_M1))*100
  
  ############################################ building M2 ############################################################
  
  H1 <- t(mat) 
  M2 <- H[126:251,] #dim(M2) -> 126, and the length of the window
  
  vals_M2 = c(M2)
  
  valsClean_M2 <- vals_M2[!is.na(vals_M2)]
  
  #corr_orange_M2 <- sum(valsClean_M2 >= 0.4 | valsClean_M2 <= -0.4)
  corr_red_M2 <- sum(valsClean_M2 <= 1 & valsClean_M2 >= 0.6 | valsClean_M2 >= -1 & valsClean_M2 <= -0.6)
  
  #per_orange_M2 <- (corr_orange_M2/length(valsClean_M2))*100
  per_red_M2 <- (corr_red_M2/length(valsClean_M2))*100
  
    
  
  file_conn = "C:/Users/MJAR0016/Desktop/var.txt"
  text = c(per_red, per_red_M1, per_red_M2)            
  writeLines(text, file_conn)

  
  
  
  
  #debug
  # vals[ncol(mat)*(0:nrow(mat))+1] = 1
  
  iCol = sapply(vals,function(x)sum(x>bins)+1)
  iFill = iCol
  iCol[is.na(iCol)]=length(colz)
  iFill[!is.na(iFill)] = NA
  iFill[is.na(iFill)] = 40
  
  graphics::rect(xleft,ybottom,xleft+1,ybottom+1,col = colz[iCol],border = NA)
  
  # getNA = which(is.na(mat),arr.ind = T)
  # if(length(getNA)>0)
  #   graphics::rect(getNA[,1],getNA[,2],getNA[,1]+1,getNA[,2]+1,col = 0,border = NA,density = 20)
  # 
  
  # #legend
  # 
  # na_y1 = 1
  # na_y2 = plotH/100 * 10
  # leg_x1 = plotW+1.5/5*leg_area
  # leg_x2 = plotW+3.5/5*leg_area
  # leg_y1 = plotH/100*15
  # leg_y2 = plotH
  # leg_incr = (plotH/100*85 )/legendSteps
  # 
  # label_0 = plotH/100*20
  # label_1 = plotH/100*97
  # label_00 =label_0+(label_1-label_0)/2
  # 
  
#   
#   graphics::rect(leg_x1, na_y1,leg_x2, na_y2
#                  ,col = "#aaaaaa",border = NA)
#   graphics::rect(leg_x1, na_y1,leg_x2, na_y2
#                  ,col = 0,border = NA,density = 20)
#   
#   
#   
#   legend_border = ifelse(legendSteps>50,NA,0)
#   graphics::rect(
#     leg_x1,
#     seq(leg_y1,leg_y2-leg_incr, by=leg_incr),
#     leg_x2,
#     seq(leg_y1+leg_incr,leg_y2, by=leg_incr),
#     col = colz, border = legend_border
#   )
#   
#   if(rescale){
#     graphics::text(leg_x2, c(na_y2/2,label_0,label_1), labels = c("NA",min(mea$ccf,na.rm=T),max(mea$ccf,na.rm=T)),cex = 1.5,pos=4)
#     
#   }else{
#   graphics::text(leg_x2, c(na_y2/2,label_0,label_1), labels = c("NA",ifelse(ABS,0,-1),1),cex = 1.5,pos=4)
# }
#     
#   
