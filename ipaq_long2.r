#*****************************************/
#                                         /
#      IPAQ LONG FORM  WITH FREQ FLOOR    /
#                                         /
#*****************************************/


ipaq_floor(dt_,c('PA_VIG_FREQ_EST','PA_MOD_FREQ_EST','PA_WALK_FREQ_EST'))

#Estimate time 
ipaq_estimate_time(dt_,output = 'PA_VIG_TIME_DAY_EST_FLOOR',freq_est = 'PA_VIG_FREQ_EST_FLOOR',time_wk = 'PA_VIG_TIME_WK')
ipaq_estimate_time(dt_,output = 'PA_MOD_TIME_DAY_EST_FLOOR',freq_est = 'PA_MOD_FREQ_EST_FLOOR',time_wk = 'PA_MOD_TIME_WK')
ipaq_estimate_time(dt_,output = 'PA_WALK_TIME_DAY_EST_FLOOR',freq_est = 'PA_WALK_FREQ_EST_FLOOR',time_wk = 'PA_WALK_TIME_WK')


#Truncate weekly estimated time over 180
ipaq_mark_trunc180(dt_,'PA_VIG_TIME_DAY_EST_FLOOR');ipaq_mark_trunc180(dt_,'PA_MOD_TIME_DAY_EST_FLOOR'); ipaq_mark_trunc180(dt_,'PA_WALK_TIME_DAY_EST_FLOOR');
#Truncate weekly estimated time over 180
ipaq_trunc180(dt_, vars = c('PA_VIG_TIME_DAY_EST_FLOOR','PA_MOD_TIME_DAY_EST_FLOOR','PA_WALK_TIME_DAY_EST_FLOOR'))


# Compute MOD proportion:
# ipaq_div(dt_,'PA_CYCLING_TIME_WK',by = 'PA_MOD_TIME_WK',output = 'PA_CYCLING_PROP')
# ipaq_div(dt_,'PA_GARDEN_VIG_TIME_WK',by = 'PA_MOD_TIME_WK',output = 'PA_GARDEN_VIG_PROP')
# ipaq_div(dt_,'PA_INSIDE_MOD_TIME_WK',by = 'PA_MOD_TIME_WK',output = 'PA_INSIDE_MOD_PROP')
# ipaq_div(dt_,'PA_GARDEN_MOD_TIME_WK',by = 'PA_MOD_TIME_WK',output = 'PA_GARDEN_MOD_PROP')
# ipaq_div(dt_,'PA_LEISURE_MOD_TIME_WK',by = 'PA_MOD_TIME_WK',output = 'PA_LEISURE_MOD_PROP')
# ipaq_div(dt_,'PA_WRK_MOD_TIME_WK',by = 'PA_MOD_TIME_WK',output = 'PA_WRK_MOD_PROP')


# -----------------Compute continuous score ---------------------------..
#-- VIG AND WALK
ipaq_mult(dt_,output = 'PA_TOTAL_VIG_MET_L_FLOOR',vars = c('PA_VIG_FREQ_EST_FLOOR','PA_VIG_TIME_DAY_EST_FLOOR_CLEAN'),num = 8.0)
ipaq_mult(dt_,output = 'PA_TOTAL_WALK_MET_L_FLOOR',vars = c('PA_WALK_FREQ_EST_FLOOR','PA_WALK_TIME_DAY_EST_FLOOR_CLEAN'),num = 3.3)

#--MOD
ipaq_mult(dt_,output = 'PA_CYCLING_PARTIAL_MET_FLOOR',vars = c('PA_MOD_FREQ_EST_FLOOR','PA_MOD_TIME_DAY_EST_FLOOR_CLEAN','PA_CYCLING_PROP'),num = 6*0.9)
ipaq_mult(dt_,output = 'PA_GARDEN_VIG_PARTIAL_MET_FLOOR',vars = c('PA_MOD_FREQ_EST_FLOOR','PA_MOD_TIME_DAY_EST_FLOOR_CLEAN','PA_GARDEN_VIG_PROP'),num = 5.5*0.9)
ipaq_mult(dt_,output = 'PA_INSIDE_MOD_PARTIAL_MET_FLOOR',vars = c('PA_MOD_FREQ_EST_FLOOR','PA_MOD_TIME_DAY_EST_FLOOR_CLEAN','PA_INSIDE_MOD_PROP'),num = 3*0.9)
ipaq_mult(dt_,output = 'PA_GARDEN_MOD_PARTIAL_MET_FLOOR',vars = c('PA_MOD_FREQ_EST_FLOOR','PA_MOD_TIME_DAY_EST_FLOOR_CLEAN','PA_GARDEN_MOD_PROP'),num = 4*0.9)
ipaq_mult(dt_,output = 'PA_LEISURE_MOD_PARTIAL_MET_FLOOR',vars = c('PA_MOD_FREQ_EST_FLOOR','PA_MOD_TIME_DAY_EST_FLOOR_CLEAN','PA_LEISURE_MOD_PROP'),num = 4*0.9)
ipaq_mult(dt_,output = 'PA_WRK_MOD_PARTIAL_MET_FLOOR',vars = c('PA_MOD_FREQ_EST_FLOOR','PA_MOD_TIME_DAY_EST_FLOOR_CLEAN','PA_WRK_MOD_PROP'),num = 4*0.9)

ipaq_sum(dt_,output = 'PA_TOTAL_MOD_MET_L_FLOOR',vars = c('PA_CYCLING_PARTIAL_MET_FLOOR','PA_GARDEN_VIG_PARTIAL_MET_FLOOR','PA_INSIDE_MOD_PARTIAL_MET_FLOOR',
                                                          'PA_GARDEN_MOD_PARTIAL_MET_FLOOR','PA_LEISURE_MOD_PARTIAL_MET_FLOOR','PA_WRK_MOD_PARTIAL_MET_FLOOR'))

# --------------TOTAL SCORE MET--------------------------------
ipaq_sum(dt_,output = 'PA_TOTAL_MET_L_FLOOR',vars = c('PA_TOTAL_VIG_MET_L_FLOOR','PA_TOTAL_MOD_MET_L_FLOOR','PA_TOTAL_WALK_MET_L_FLOOR'))



#  ----------- Categorization --------------------------

ipaq_category(dt_,output = 'PA_LEVEL_L_FLOOR',vig_freq = 'PA_VIG_FREQ_EST_FLOOR', mod_freq = 'PA_MOD_FREQ_EST_FLOOR',walk_freq = 'PA_WALK_FREQ_EST_FLOOR',
              vig_time = 'PA_VIG_TIME_DAY_EST_FLOOR_CLEAN',mod_time = 'PA_MOD_TIME_DAY_EST_FLOOR_CLEAN',walk_time = 'PA_WALK_TIME_DAY_EST_FLOOR_CLEAN',total_met = 'PA_TOTAL_MET_L_FLOOR')
