## read the first sample (intake interviews of patients that carried on therapy)
path_normal <- system.file("extdata/hospital/control/2023_CFLH/head", package = "rMEA")
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
#mea_ccf <- MEAccf((mea_rescaled[[1]], from=1, to=59416), lagSec= 5, winSec = 30, incSec=10, ABS = F)

# Raw data of the first session with running lag-0 ccf
plot(mea_ccf[[1]], from=100, to=300, ccf = "lag_zero")

# Heatmap of the first session
MEAheatmap(mea_ccf[[1]])

