#*****************************************/
#                                         /
#      IPAQ LONG FORM                     /
#                                         /
#*****************************************/


# Remove freq > 7
ipaq_clean_gt7(dt_,vars = c('PA_WRK_WALK_FREQ','PA_WRK_VIG_FREQ','PA_WRK_MOD_FREQ','PA_CYCLING_FREQ','PA_TRANS_WALK_FREQ','PA_LEISURE_MOD_FREQ',
               'PA_MOTOR_VEHICLE_FREQ','PA_GARDEN_MOD_FREQ','PA_LEISURE_VIG_FREQ','PA_INSIDE_MOD_FREQ','PA_LEISURE_WALK_FREQ','PA_GARDEN_VIG_FREQ'))

# Update work related freq: work == 0 -> freq =0   [ONLY IN THE LONG FORM]
ipaq_update_work_freq(dt_,job='PA_JOB_UNPAID_WRK',vars = c('PA_WRK_WALK_FREQ_CLEAN','PA_WRK_VIG_FREQ_CLEAN','PA_WRK_MOD_FREQ_CLEAN'))

# Compute the time/day and clean: time in [10, 960]; freq ==0 -> time = 0 
ipaq_computetime(dt_,freq = 'PA_WRK_WALK_FREQ_CLEAN',min = 'PA_WRK_WALK_TIME_MIN',hr = 'PA_WRK_WALK_TIME_HR',time_output = 'PA_WRK_WALK_TIME_DAY')
ipaq_computetime(dt_,freq = 'PA_WRK_VIG_FREQ_CLEAN',min = 'PA_WRK_VIG_TIME_MIN',hr = 'PA_WRK_VIG_TIME_HR',time_output = 'PA_WRK_VIG_TIME_DAY')
ipaq_computetime(dt_,freq = 'PA_WRK_MOD_FREQ_CLEAN',min = 'PA_WRK_MOD_TIME_MIN',hr = 'PA_WRK_MOD_TIME_HR',time_output = 'PA_WRK_MOD_TIME_DAY')
ipaq_computetime(dt_,freq = 'PA_CYCLING_FREQ_CLEAN',min = 'PA_CYCLING_TIME_MIN',hr = 'PA_CYCLING_TIME_HR',time_output = 'PA_CYCLING_TIME_DAY')
ipaq_computetime(dt_,freq = 'PA_TRANS_WALK_FREQ_CLEAN',min = 'PA_TRANS_WALK_TIME_MIN',hr = 'PA_TRANS_WALK_TIME_HR',time_output = 'PA_TRANS_WALK_TIME_DAY')
ipaq_computetime(dt_,freq = 'PA_LEISURE_MOD_FREQ_CLEAN',min = 'PA_LEISURE_MOD_TIME_MIN',hr = 'PA_LEISURE_MOD_TIME_HR',time_output = 'PA_LEISURE_MOD_TIME_DAY')
ipaq_computetime(dt_,freq = 'PA_GARDEN_MOD_FREQ_CLEAN',min = 'PA_GARDEN_MOD_TIME_MIN',hr = 'PA_GARDEN_MOD_TIME_HR',time_output = 'PA_GARDEN_MOD_TIME_DAY')
ipaq_computetime(dt_,freq = 'PA_LEISURE_VIG_FREQ_CLEAN',min = 'PA_LEISURE_VIG_TIME_MIN',hr = 'PA_LEISURE_VIG_TIME_HR',time_output = 'PA_LEISURE_VIG_TIME_DAY')
ipaq_computetime(dt_,freq = 'PA_INSIDE_MOD_FREQ_CLEAN',min = 'PA_INSIDE_MOD_TIME_MIN',hr = 'PA_INSIDE_MOD_TIME_HR',time_output = 'PA_INSIDE_MOD_TIME_DAY')
ipaq_computetime(dt_,freq = 'PA_LEISURE_WALK_FREQ_CLEAN',min = 'PA_LEISURE_WALK_TIME_MIN',hr = 'PA_LEISURE_WALK_TIME_HR',time_output = 'PA_LEISURE_WALK_TIME_DAY')
ipaq_computetime(dt_,freq = 'PA_GARDEN_VIG_FREQ_CLEAN',min = 'PA_GARDEN_VIG_TIME_MIN',hr = 'PA_GARDEN_VIG_TIME_HR',time_output = 'PA_GARDEN_VIG_TIME_DAY')



# Readjust activity time_day AND freq: time in [10, 960]; freq ==0 -> time = 0 
ipaq_readj_freq_time(dt_, freq = 'PA_WRK_WALK_FREQ_CLEAN',time = 'PA_WRK_WALK_TIME_DAY')
ipaq_readj_freq_time(dt_, freq = 'PA_WRK_VIG_FREQ_CLEAN', time = 'PA_WRK_VIG_TIME_DAY')
ipaq_readj_freq_time(dt_, freq = 'PA_WRK_MOD_FREQ_CLEAN',time = 'PA_WRK_MOD_TIME_DAY')
ipaq_readj_freq_time(dt_, freq = 'PA_CYCLING_FREQ_CLEAN',time = 'PA_CYCLING_TIME_DAY')
ipaq_readj_freq_time(dt_, freq = 'PA_TRANS_WALK_FREQ_CLEAN',time = 'PA_TRANS_WALK_TIME_DAY')
ipaq_readj_freq_time(dt_, freq = 'PA_LEISURE_MOD_FREQ_CLEAN',time = 'PA_LEISURE_MOD_TIME_DAY')
ipaq_readj_freq_time(dt_, freq = 'PA_GARDEN_MOD_FREQ_CLEAN',time = 'PA_GARDEN_MOD_TIME_DAY')
ipaq_readj_freq_time(dt_, freq = 'PA_LEISURE_VIG_FREQ_CLEAN',time = 'PA_LEISURE_VIG_TIME_DAY')
ipaq_readj_freq_time(dt_, freq = 'PA_INSIDE_MOD_FREQ_CLEAN',time = 'PA_INSIDE_MOD_TIME_DAY')
ipaq_readj_freq_time(dt_, freq = 'PA_LEISURE_WALK_FREQ_CLEAN',time = 'PA_LEISURE_WALK_TIME_DAY')
ipaq_readj_freq_time(dt_, freq = 'PA_GARDEN_VIG_FREQ_CLEAN',time = 'PA_GARDEN_VIG_TIME_DAY')




# Compute activity time per/week
ipaq_mult(dt_,vars = c('PA_WRK_WALK_FREQ_CLEAN', 'PA_WRK_WALK_TIME_DAY'),output = 'PA_WRK_WALK_TIME_WK')
ipaq_mult(dt_,vars = c('PA_WRK_VIG_FREQ_CLEAN', 'PA_WRK_VIG_TIME_DAY'),output = 'PA_WRK_VIG_TIME_WK')
ipaq_mult(dt_,vars = c('PA_WRK_MOD_FREQ_CLEAN', 'PA_WRK_MOD_TIME_DAY'),output = 'PA_WRK_MOD_TIME_WK')
ipaq_mult(dt_,vars = c('PA_CYCLING_FREQ_CLEAN', 'PA_CYCLING_TIME_DAY'),output = 'PA_CYCLING_TIME_WK')
ipaq_mult(dt_,vars = c('PA_TRANS_WALK_FREQ_CLEAN', 'PA_TRANS_WALK_TIME_DAY'),output = 'PA_TRANS_WALK_TIME_WK')
ipaq_mult(dt_,vars = c('PA_LEISURE_MOD_FREQ_CLEAN', 'PA_LEISURE_MOD_TIME_DAY'),output = 'PA_LEISURE_MOD_TIME_WK')
ipaq_mult(dt_,vars = c('PA_GARDEN_MOD_FREQ_CLEAN', 'PA_GARDEN_MOD_TIME_DAY'),output = 'PA_GARDEN_MOD_TIME_WK')
ipaq_mult(dt_,vars = c('PA_LEISURE_VIG_FREQ_CLEAN', 'PA_LEISURE_VIG_TIME_DAY'),output = 'PA_LEISURE_VIG_TIME_WK')
ipaq_mult(dt_,vars = c('PA_INSIDE_MOD_FREQ_CLEAN', 'PA_INSIDE_MOD_TIME_DAY'),output = 'PA_INSIDE_MOD_TIME_WK')
ipaq_mult(dt_,vars = c('PA_LEISURE_WALK_FREQ_CLEAN', 'PA_LEISURE_WALK_TIME_DAY'),output = 'PA_LEISURE_WALK_TIME_WK')
ipaq_mult(dt_,vars = c('PA_GARDEN_VIG_FREQ_CLEAN', 'PA_GARDEN_VIG_TIME_DAY'),output = 'PA_GARDEN_VIG_TIME_WK')


#Compute weekly activity for each intensity group [walk,vig,mod]
ipaq_sum(dt_,output = 'PA_VIG_TIME_WK', vars = c('PA_WRK_VIG_TIME_WK','PA_LEISURE_VIG_TIME_WK'))
ipaq_sum(dt_,output = 'PA_MOD_TIME_WK',vars = c('PA_WRK_MOD_TIME_WK','PA_CYCLING_TIME_WK','PA_GARDEN_MOD_TIME_WK','PA_GARDEN_VIG_TIME_WK','PA_INSIDE_MOD_TIME_WK','PA_LEISURE_MOD_TIME_WK'))
ipaq_sum(dt_,output = 'PA_WALK_TIME_WK',vars = c('PA_WRK_WALK_TIME_WK','PA_LEISURE_WALK_TIME_WK','PA_TRANS_WALK_TIME_WK'))

#Sum all weekly activity intensity times
ipaq_sum(dt_,output = 'PA_TOTAL_TIME_WK',vars = c('PA_VIG_TIME_WK','PA_MOD_TIME_WK','PA_WALK_TIME_WK'))


#Mark where total weekly activity time > 960*7
ipaq_mark_gt960_7(dt_,'PA_TOTAL_TIME_WK');ipaq_mark_gt960_7(dt_,'PA_VIG_TIME_WK'); ipaq_mark_gt960_7(dt_,'PA_MOD_TIME_WK'); ipaq_mark_gt960_7(dt_,'PA_WALK_TIME_WK')

#Estimate freq
ipaq_estimate_freq(dt_,output = 'PA_VIG_FREQ_EST',vars = c('PA_WRK_VIG_FREQ_CLEAN','PA_LEISURE_VIG_FREQ_CLEAN'))
ipaq_estimate_freq(dt_,output = 'PA_MOD_FREQ_EST', vars = c('PA_WRK_MOD_FREQ_CLEAN','PA_CYCLING_FREQ_CLEAN','PA_GARDEN_VIG_FREQ_CLEAN','PA_GARDEN_MOD_FREQ_CLEAN','PA_INSIDE_MOD_FREQ_CLEAN','PA_LEISURE_MOD_FREQ_CLEAN'))
ipaq_estimate_freq(dt_,output = 'PA_WALK_FREQ_EST',vars = c('PA_WRK_WALK_FREQ_CLEAN','PA_LEISURE_WALK_FREQ_CLEAN','PA_TRANS_WALK_FREQ_CLEAN'))

#Estimate time 
ipaq_estimate_time(dt_,output = 'PA_VIG_TIME_DAY_EST',freq_est = 'PA_VIG_FREQ_EST',time_wk = 'PA_VIG_TIME_WK')
ipaq_estimate_time(dt_,output = 'PA_MOD_TIME_DAY_EST',freq_est = 'PA_MOD_FREQ_EST',time_wk = 'PA_MOD_TIME_WK')
ipaq_estimate_time(dt_,output = 'PA_WALK_TIME_DAY_EST',freq_est = 'PA_WALK_FREQ_EST',time_wk = 'PA_WALK_TIME_WK')


#Truncate weekly estimated time over 180
ipaq_mark_trunc180(dt_,'PA_VIG_TIME_DAY_EST');ipaq_mark_trunc180(dt_,'PA_MOD_TIME_DAY_EST'); ipaq_mark_trunc180(dt_,'PA_WALK_TIME_DAY_EST');
#Truncate weekly estimated time over 180
ipaq_trunc180(dt_, vars = c('PA_VIG_TIME_DAY_EST','PA_MOD_TIME_DAY_EST','PA_WALK_TIME_DAY_EST'))


# Compute MOD proportion:
ipaq_div(dt_,'PA_CYCLING_TIME_WK',by = 'PA_MOD_TIME_WK',output = 'PA_CYCLING_PROP')
ipaq_div(dt_,'PA_GARDEN_VIG_TIME_WK',by = 'PA_MOD_TIME_WK',output = 'PA_GARDEN_VIG_PROP')
ipaq_div(dt_,'PA_INSIDE_MOD_TIME_WK',by = 'PA_MOD_TIME_WK',output = 'PA_INSIDE_MOD_PROP')
ipaq_div(dt_,'PA_GARDEN_MOD_TIME_WK',by = 'PA_MOD_TIME_WK',output = 'PA_GARDEN_MOD_PROP')
ipaq_div(dt_,'PA_LEISURE_MOD_TIME_WK',by = 'PA_MOD_TIME_WK',output = 'PA_LEISURE_MOD_PROP')
ipaq_div(dt_,'PA_WRK_MOD_TIME_WK',by = 'PA_MOD_TIME_WK',output = 'PA_WRK_MOD_PROP')


# -----------------Compute continuous score ---------------------------..
#-- VIG AND WALK
ipaq_mult(dt_,output = 'PA_TOTAL_VIG_MET_L',vars = c('PA_VIG_FREQ_EST','PA_VIG_TIME_DAY_EST_CLEAN'),num = 8.0)
ipaq_mult(dt_,output = 'PA_TOTAL_WALK_MET_L',vars = c('PA_WALK_FREQ_EST','PA_WALK_TIME_DAY_EST_CLEAN'),num = 3.3)

#--MOD
ipaq_mult(dt_,output = 'PA_CYCLING_PARTIAL_MET',vars = c('PA_MOD_FREQ_EST','PA_MOD_TIME_DAY_EST_CLEAN','PA_CYCLING_PROP'),num = 6)
ipaq_mult(dt_,output = 'PA_GARDEN_VIG_PARTIAL_MET',vars = c('PA_MOD_FREQ_EST','PA_MOD_TIME_DAY_EST_CLEAN','PA_GARDEN_VIG_PROP'),num = 5.5)
ipaq_mult(dt_,output = 'PA_INSIDE_MOD_PARTIAL_MET',vars = c('PA_MOD_FREQ_EST','PA_MOD_TIME_DAY_EST_CLEAN','PA_INSIDE_MOD_PROP'),num = 3)
ipaq_mult(dt_,output = 'PA_GARDEN_MOD_PARTIAL_MET',vars = c('PA_MOD_FREQ_EST','PA_MOD_TIME_DAY_EST_CLEAN','PA_GARDEN_MOD_PROP'),num = 4)
ipaq_mult(dt_,output = 'PA_LEISURE_MOD_PARTIAL_MET',vars = c('PA_MOD_FREQ_EST','PA_MOD_TIME_DAY_EST_CLEAN','PA_LEISURE_MOD_PROP'),num = 4)
ipaq_mult(dt_,output = 'PA_WRK_MOD_PARTIAL_MET',vars = c('PA_MOD_FREQ_EST','PA_MOD_TIME_DAY_EST_CLEAN','PA_WRK_MOD_PROP'),num = 4)

ipaq_sum(dt_,output = 'PA_TOTAL_MOD_MET_L',vars = c('PA_CYCLING_PARTIAL_MET','PA_GARDEN_VIG_PARTIAL_MET','PA_INSIDE_MOD_PARTIAL_MET','PA_GARDEN_MOD_PARTIAL_MET','PA_LEISURE_MOD_PARTIAL_MET','PA_WRK_MOD_PARTIAL_MET'))

# --------------TOTAL SCORE MET--------------------------------
ipaq_sum(dt_,output = 'PA_TOTAL_MET_L',vars = c('PA_TOTAL_VIG_MET_L','PA_TOTAL_MOD_MET_L','PA_TOTAL_WALK_MET_L'))



#  ----------- Categorization --------------------------

ipaq_category(dt_,output = 'PA_LEVEL_L',vig_freq = 'PA_VIG_FREQ_EST', mod_freq = 'PA_MOD_FREQ_EST',walk_freq = 'PA_WALK_FREQ_EST',
              vig_time = 'PA_VIG_TIME_DAY_EST_CLEAN',mod_time = 'PA_MOD_TIME_DAY_EST_CLEAN',walk_time = 'PA_WALK_TIME_DAY_EST_CLEAN',total_met = 'PA_TOTAL_MET_L')





