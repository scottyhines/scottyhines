# test functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
devtools::install("~/scottyhines")

library(scottyhines)
library(dplyr)
df <- scottyhines::create_fake_data(5000)
df %>% glimpse()

outcomes <- c("attitude_work_ethic", "attitude_adaptability", "attitude_creativity")
vars_of_interest <- c("attitude_teamwork", "attitude_communication", "attitude_persistence")

# Tables
scottyhines::build_means_table(df, group_var = "demo_performance", vars = outcomes)
scottyhines::build_correlation_table(data = df, outcome_vars = outcomes, interest_vars = vars_of_interest)

# analyses
out_ttest <- scottyhines::run_t_test(df, outcome_vars = outcomes, group_var = "demo_attrition")
out_anova <- scottyhines::run_anova_with_contrasts(df, outcome_vars = outcomes, control_vars = "attitude_leadership",  group_var = "demo_region_code")
out_anova$anova_summary
out_anova$contrast_summary
scottyhines::run_linear_regression(df, outcome_var = "demo_performance", control_vars = "attitude_leadership", interest_vars = vars_of_interest)
scottyhines::run_logistic_regression(df, outcome_var = "demo_attrition", control_vars = c("attitude_leadership", "attitude_innovation"), interest_vars = vars_of_interest)
scottyhines::run_hierarchical_regression(df, outcome_var = "demo_performance", control_vars = c("demo_tenure", "demo_region_code"), interest_vars = vars_of_interest, group_var = "demo_job_level")
scottyhines::run_network_analysis(df, outcome_var = "demo_performance", control_vars = "attitude_leadership", interest_vars = c("network_degree", "network_betweenness", "network_closeness", "network_eigenvector"), group_var = "demo_job_level", num_permutations = 500)
scottyhines::run_heartbeat(df, outcomes)
scottyhines::run_causal_attitude_network(df, gamma = .5, threshold = F)
scottyhines::run_mixed_effects_model(df, outcome_vars = c("attitude_work_ethic", "attitude_adaptability"), control_vars = c("attitude_teamwork"), interest_vars = c("attitude_communication"), random_effects = "(1 | demo_job_level)", interaction_var = "demo_job_level", include_interaction = T)
