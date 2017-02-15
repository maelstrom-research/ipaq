#################################################################################################
#                                                                                               #
#               SET of useful functions to help for the processing of IPAQ data:                #
#                                                                                               #
#################################################################################################

if('init.ipaq' %in% search())detach(init.ipaq)
.load_packages <- function(pkg) 
{
  if(!suppressPackageStartupMessages(require(pkg,warn.conflicts = F,quietly = T,character.only = TRUE))){
    install.packages(pkg)
    suppressPackageStartupMessages(library(pkg,quietly = T,warn.conflicts = F,character.only = TRUE))
  }
  
}


##### -----------Load dependencies
.load_packages('data.table'); .load_packages('bit64');.load_packages('stringi');
options(datatable.showProgress = TRUE)

################# put everything in an evironment ##########
init.ipaq<-new.env()



#************************************************         IPAQ       ******************************************************************

init.ipaq$ipaq_clean_gt7 <- function(dt_,vars)
{
  for(x in vars) { set(dt_,j = k<-paste0(x,'_CLEAN'),value = dt_[,floor(eval(as.name(x)))]); set(dt_,i= which(dt_[[x]]>7),j = k,value = NA_integer_)}
}


init.ipaq$ipaq_update_work_freq <- function(dt_,job,vars) { for(x in vars) {set(dt_,i= which(dt_[,eval(as.name(job))]==0L),j = x, value = 0L)} }


init.ipaq$ipaq_computetime <- function(dt_, freq, min, hr, time_output)
{ 
  
  min_v <- dt_[,eval(as.name(min))]
  hr_v <- dt_[,eval(as.name(hr))]
  
  check_hr <- dt_[,hr_v %in% c(15L,30L,45L,60L,90L)]
  
  ix <- which(is.na(hr_v))
  set(dt_,i=ix,j=time_output,value=min_v[ix] )
  
  ix<- which(is.na(min_v) & !check_hr)
  set(dt_,i=ix,j=time_output,value=hr_v[ix]*60L )
  
  ix <- which(is.na(min_v) & check_hr)
  set(dt_,i=ix,j=time_output,value=hr_v[ix] )
  
  ix <- which((!is.na(min_v)) & (!is.na(hr_v)))
  set(dt_,i=ix,j=time_output,value=hr_v[ix]*60L+min_v[ix] )
 
  
  time_v <- dt_[,eval(as.name(time_output))]
  freq_v <- dt_[,eval(as.name(freq))]
  #clean
  
  set(dt_, which(freq_v==0L),j=time_output,value = 0L)
  
  set(dt_, which(time_v>960L),j=time_output,value = NA_integer_)
 
  set(dt_, which(time_v<10L),j=time_output,value = 0L)
  
  #Recalibrate freq [freq =0 if time ==0]
  time_output_v <- dt_[,eval(as.name(time_output))]
  set(dt_, which(time_output_v==0),j=freq,value = 0L)
}




init.ipaq$ipaq_readj_freq_time <- function(dt_,time,freq) 
{
  freq_v <- dt_[,eval(as.name(freq))];  time_v <- dt_[,eval(as.name(time))]
  set(dt_, which(freq_v==0L),j=time,value = 0L)
  set(dt_, which(time_v>960L),j=time,value = NA_integer_)
  set(dt_, which(time_v<10L),j=time,value = 0L)
  set(dt_, which(time_v==0L),j=freq,value = 0L)
}


init.ipaq$ipaq_mult <- function(dt_,output,vars,num=1L)
{
  dt_[,(output):=Reduce('*',.SD)*eval(num),.SDcols=vars]
}


init.ipaq$ipaq_sum <- function(dt_,output,vars){ dt_[,(output):=rowSums(.SD),.SDcols=vars] }


init.ipaq$ipaq_mark_gt960_7 <- function(dt_,total_time)
{
  dt_[eval(as.name(total_time))>960*7,is_gt960time7:=1L]
}

init.ipaq$ipaq_clean_gt960_7 <- function (dt_,vars){dt_[is_gt960time7==1,c(vars):=NA]}


init.ipaq$ipaq_mark_trunc180 <- function (dt_,time_day ) { dt_[eval(as.name(time_day))>180 ,is_trunc180:=1L] }

init.ipaq$ipaq_trunc180 <- function(dt_,vars)
{
  for(x in vars) {set(dt_,j=k<-paste0(x,'_CLEAN'),value=dt_[,eval(as.name(x))]); dt_[is_trunc180==1 & eval(as.name(x))>180L,(k):=180L]}
}




init.ipaq$ipaq_estimate_freq <- function(dt_,output,vars) 
{
  dt2_ <- dt_[,{ TMP_MAX = do.call('pmax',.SD); TMP_SUM = rowSums(.SD); TMP_MIN = pmin(7,TMP_SUM);.(TMP_MAX=TMP_MAX,TMP_SUM=TMP_SUM,TMP_MIN=TMP_MIN)} ,.SDcols=vars] 
  dt2_[,TMP_MEAN:= rowMeans(.SD),.SDcols=c('TMP_MAX','TMP_MIN')]
  set(dt_,j=output,value = dt2_[,TMP_MEAN])
}


init.ipaq$ipaq_floor <- function(dt_,vars)
{
  for(x in vars) { set(dt_,j = k<-paste0(x,'_FLOOR'),value = dt_[,floor(eval(as.name(x)))])}
}



init.ipaq$ipaq_estimate_time <- function (dt_, output, freq_est,time_wk)
{
  freq_est_v <- as.name(freq_est); time_wk_v <- as.name(time_wk)
  ix <- dt_[,eval(freq_est_v)]==0
  set(dt_,i= which(ix),j=output,value = 0.0)
  set(dt_,i=which(!ix), j=output,value = dt_[!ix, eval(time_wk_v)/eval(freq_est_v)])
}



init.ipaq$ipaq_div <- function(dt_,var,by,output) 
{
  by_v <- as.name(by)
  dt_[eval(by_v) == 0 ,(output):=0.0 ]
  dt_[!(eval(by_v) == 0),(output):= eval(as.name(var))/eval(by_v)]
}


init.ipaq$ipaq_category <- function(dt_,output,vig_freq,mod_freq,walk_freq,vig_time,mod_time,walk_time,total_met)
{
  vig_f <- as.name(vig_freq); mod_f <- as.name(mod_freq); walk_f <- as.name(walk_freq);
  vig_t <- as.name(vig_time); mod_t <- as.name(mod_time);walk_t <- as.name(walk_freq);
  total_m <- as.name(total_met); output_v <- as.name(output)
  dt_[,sum_f := eval(vig_f)+eval(mod_f)+eval(walk_f) ][,mod_plus_walk_f:= eval(mod_f)+eval(walk_f)][,(output) := 1L]
  #high
  dt_[ ( eval(vig_f) >= 3 & eval(total_m) >= 1500 ) | ( sum_f >= 7 & eval(total_m) >= 3000 ), (output) := 3L]
  #mod
  dt_[ ((eval(vig_f) >= 3 & eval(vig_t) >= 20) | (eval(mod_f) >= 5 & eval(mod_t) >= 30 ) | (eval(walk_f) >= 5 & eval(walk_t) >= 30 ) 
       | (mod_plus_walk_f >= 5 & eval(mod_t) >= 30 & eval(walk_t) >= 30) | (sum_f >= 5 & eval(total_m) >= 600)) & !(eval(output_v)==3), (output) := 2L]
  #low
  dt_[eval(total_m)==0 & (!eval(output_v) %in% 2:3), (output) := 1L]
  dt_[is.na(eval(total_m)), (output) := NA_integer_]
  #clean
  dt_[,c('sum_f','mod_plus_walk_f') := NULL]
  
}


init.ipaq$ipaq_rm <- function (dt_,vars) 
{
  dt_[,c(vars):=NULL]
}



######################### -> attach util env <- ###########
attach(init.ipaq)