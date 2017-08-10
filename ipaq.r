###################################################
#                                                 #
#                   Main code                     #
#                                                 #
###################################################


#Load IPAQ module first
source('ipaq.INIT.r')

#The raw data is in  data.table "full_d_" 

# Copy to dt_
data.table::setDT(full_d_)
dt_ <- copy(full_d_)



#Run ipaq short 
source('ipaq_short.r')
ipaq_rm(dt_,vars = names(dt_)[grepl('_WK$', names(dt_))] )

#then  run ipaq long
source('ipaq_long.r')
source('ipaq_long2.r')
ipaq_rm( dt_,vars = names(dt_)[grepl('_WK$|_PARTIAL_|_PROP$|(DAY_EST(_FLOOR)?)$', names(dt_))] )


# clean gt 960*7
ipaq_clean_gt960_7(dt_,vars = names(dt_)[!grepl('time|freq|job|(?i)ID|A_ADM|STUDY_NAME', names(dt_))] )


#The final ipaq table is in dt_ and can be saved as a csv
fwrite(dt_,file = 'ipaq_final.csv',row.names = FALSE,quote = TRUE,verbose = T,na = '')
