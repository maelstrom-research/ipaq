#*****************************************/
#                                         /
#      IPAQ SHORT FORM                    /
#                                         /
#*****************************************/

# Remove freq > 7
ipaq_clean_gt7(dt_,vars = c('PA_MOD_FREQ','PA_VIG_FREQ','PA_WALK_FREQ'))

# Compute the time and clean: time in [10, 960]; freq ==0 -> time = 0 
ipaq_computetime(dt_,freq = 'PA_VIG_FREQ_CLEAN',min = 'PA_VIG_TIME_MIN',hr = 'PA_VIG_TIME_HR',time_output = 'PA_VIG_TIME_DAY')
ipaq_computetime(dt_,freq = 'PA_MOD_FREQ_CLEAN',min = 'PA_MOD_TIME_MIN',hr = 'PA_MOD_TIME_HR',time_output = 'PA_MOD_TIME_DAY')
ipaq_computetime(dt_,freq = 'PA_WALK_FREQ_CLEAN',min = 'PA_WALK_TIME_MIN',hr = 'PA_WALK_TIME_HR',time_output = 'PA_WALK_TIME_DAY')


# Readjust activity time_day AND freq: time in [10, 960]; freq ==0 -> time = 0 
ipaq_readj_freq_time(dt_, freq = 'PA_VIG_FREQ_CLEAN',time = 'PA_VIG_TIME_DAY')
ipaq_readj_freq_time(dt_, freq = 'PA_MOD_FREQ_CLEAN', time = 'PA_MOD_TIME_DAY')
ipaq_readj_freq_time(dt_, freq = 'PA_WALK_FREQ_CLEAN',time = 'PA_WALK_TIME_DAY')


# Compute activity time per/week
ipaq_mult(dt_,vars = c('PA_VIG_TIME_DAY','PA_VIG_FREQ_CLEAN'),output = 'PA_VIG_TIME_WK')
ipaq_mult(dt_,vars = c('PA_MOD_TIME_DAY','PA_MOD_FREQ_CLEAN'),output = 'PA_MOD_TIME_WK')
ipaq_mult(dt_,vars  = c('PA_WALK_TIME_DAY','PA_WALK_FREQ_CLEAN'),output = 'PA_WALK_TIME_WK')

# Compute total activity time/week
ipaq_sum(dt_,output = 'PA_TOTAL_TIME_WK',vars = c('PA_VIG_TIME_WK','PA_MOD_TIME_WK','PA_WALK_TIME_WK'))

#Mark total weekly activity time > 960*7
ipaq_mark_gt960_7(dt_,'PA_TOTAL_TIME_WK');ipaq_mark_gt960_7(dt_,'PA_VIG_TIME_WK'); ipaq_mark_gt960_7(dt_,'PA_MOD_TIME_WK'); ipaq_mark_gt960_7(dt_,'PA_WALK_TIME_WK')


#Clean marked where time (gt than 960*7)
#ipaq_clean_gt960_7(dt_,'PA_VIG_FREQ_CLEAN','PA_MOD_FREQ_CLEAN','PA_WALK_FREQ_CLEAN','PA_VIG_TIME_WK','PA_MOD_TIME_WK','PA_WALK_TIME_WK','PA_VIG_TIME_CLEAN','PA_MOD_TIME_CLEAN','PA_WALK_TIME_CLEAN')

#Truncate weekly time over 180
ipaq_mark_trunc180(dt_,'PA_VIG_TIME_DAY');ipaq_mark_trunc180(dt_,'PA_MOD_TIME_DAY'); ipaq_mark_trunc180(dt_,'PA_WALK_TIME_DAY');
ipaq_trunc180(dt_, vars =c('PA_VIG_TIME_DAY','PA_MOD_TIME_DAY','PA_WALK_TIME_DAY'))



# -----------------Compute continuous score ---------------------------..
ipaq_mult(dt_,output = 'PA_TOTAL_VIG_MET_S',vars = c('PA_VIG_FREQ_CLEAN','PA_VIG_TIME_DAY_CLEAN'),num = 8.0)
ipaq_mult(dt_,output = 'PA_TOTAL_MOD_MET_S',vars = c('PA_MOD_FREQ_CLEAN','PA_MOD_TIME_DAY_CLEAN'),num = 4.0)
ipaq_mult(dt_,output = 'PA_TOTAL_WALK_MET_S',vars = c('PA_WALK_FREQ_CLEAN','PA_WALK_TIME_DAY_CLEAN'),num = 3.3)

# --------------TOTAL SCORE MET--------------------------------
ipaq_sum(dt_,output = 'PA_TOTAL_MET_S',vars = c('PA_TOTAL_VIG_MET_S','PA_TOTAL_MOD_MET_S','PA_TOTAL_WALK_MET_S'))



#  ----------- Categorization --------------------------

ipaq_category(dt_,output = 'PA_LEVEL_S',vig_freq = 'PA_VIG_FREQ_CLEAN', mod_freq = 'PA_MOD_FREQ_CLEAN',walk_freq = 'PA_WALK_FREQ_CLEAN',
              vig_time = 'PA_VIG_TIME_DAY_CLEAN',mod_time = 'PA_MOD_TIME_DAY_CLEAN',walk_time = 'PA_WALK_TIME_DAY_CLEAN',total_met = 'PA_TOTAL_MET_S')







