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



#Run ipaq short then ipaq long
source('ipaq_short.r')
source('ipaq_long.r')

# harmonize PA_TOTAL and PA_LEVEL


#The final ipaq table is in dt_ and can be saved as a csv
fwrite(dt_,file = 'ipaq_final.csv',sep = ',',row.names = FALSE,quote = TRUE,verbose = T,na = '')
