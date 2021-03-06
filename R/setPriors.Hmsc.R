#' @title setPriors.Hmsc
#'
#' @description Sets or resets priors to the Hmsc object
#'
#' @param V0 scale matrix in the Wishart prior distribution for the V matrix
#' @param f0 number of degreees of freedom in the Wishart prior distribution for the V matrix
#' @param mGamma mean for the prior multivariate Gaussian distribution for Gamma parameters
#' @param UGamma covariance matrix for the prior multivariate Gaussian distribution for Gamma parameters
#' @param aSigma
#' @param bSigma
#' @param nu
#' @param a1
#' @param b1
#' @param a2
#' @param b2
#' @param rhopw
#' @param setDefault
#'
#' @return Modified \code{Hmsc} object
#'
#' @examples
#'
#' @export

setPriors.Hmsc = function(hM, V0=NULL, f0=NULL, mGamma=NULL,
   UGamma=NULL, aSigma=NULL, bSigma=NULL, nu=NULL, a1=NULL,
   b1=NULL, a2=NULL, b2=NULL, nuDR=NULL, a1DR=NULL,
   b1DR=NULL, a2DR=NULL, b2DR=NULL, rhopw=NULL, setDefault=FALSE){

   if(!is.null(V0)){
      if(!isSymmetric(V0) || nrow(V0) != hM$nc || ncol(V0) != hM$nc)
         stop("HMSC.setPriors: V0 must be a positive definite matrix of size equal to number of covariates nc")
      hM$V0 = V0
   } else if(setDefault){
      hM$V0 = diag(hM$nc)
   }

   if(!is.null(f0)){
      if(f0 < hM$nc)
         stop("HMSC.setPriors: f0 must be greater than number of covariates in the model nc")
      hM$f0 = f0
   } else if(setDefault){
      hM$f0 = hM$nc+1
   }

   if(!is.null(mGamma)){
      if(length(mGamma) != hM$nc*hM$nt)
         stop("HMSC.setPriors: mGamma must be a vector of length equal to number of covariates times traits: nc x nt")
      hM$mGamma = mGamma
   } else if(setDefault){
      hM$mGamma = rep(0, hM$nc*hM$nt)
   }

   if(!is.null(UGamma)){
      if(!isSymmetric(UGamma) || nrow(UGamma) != (hM$nc*hM$nt) || ncol(UGamma) != (hM$nc*hM$nt))
         stop("HMSC.setPriors: UGamma must be a positive definite matrix of size equal to nc x nt")
      hM$UGamma = UGamma
   } else if(setDefault){
      hM$UGamma = diag(hM$nc * hM$nt)
   }

   if(!is.null(aSigma)){
      hM$aSigma = aSigma
   } else if(setDefault){
      hM$aSigma = rep(1, hM$ns)
   }

   if(!is.null(bSigma)){
      hM$bSigma = bSigma
   } else if(setDefault){
      hM$bSigma = rep(5, hM$ns)
   }

   if(!is.null(rhopw)){
      if(is.null(hM$C))
         stop("HMSC.setPriors: prior for phylogeny given, but not phylogenic relationship matrix was specified")
      if(ncol(rhopw)!=2)
         stop("HMSC.setPriors: rhopw must be a matrix with two columns")
      hM$rhopw = rhopw
   } else if(setDefault){
      rhoN = 100
      hM$rhopw = cbind(c(0:rhoN)/rhoN, c(0.5,rep(0.5/rhoN,rhoN)))
   }
   if(!is.null(nuDR)){
      hM$nuDR = nuDR
   } else if(setDefault){
      hM$nuDR = 3
   }
   if(!is.null(a1DR)){
      hM$a1DR = a1DR
   } else if(setDefault){
      hM$a1DR = 1
   }
   if(!is.null(b1DR)){
      hM$b1DR = b1DR
   } else if(setDefault){
      hM$b1DR = 1
   }
   if(!is.null(a2DR)){
      hM$a2DR = a2DR
   } else if(setDefault){
      hM$a2DR = 50
   }
   if(!is.null(b2DR)){
      hM$b2DR = b2DR
   } else if(setDefault){
      hM$b2DR = 1
   }
   return(hM)
}

