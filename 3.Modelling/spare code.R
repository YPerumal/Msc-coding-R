# looping over the lists



results_list_all_cols <- list( )
for (i in c(1:5)) {
    # train the model
    temp_model <- random_forest_train_func(data.frame(imputed_df_list[[i]]) %>%  slice_sample(n=1000))
    # make prediction on test set and store y_pred vector
    
    results_list_all_cols[i] <- random_forest_test_func(temp_model,mf_test_df)[1]
}

res_df <- data.frame(cbind(results_list_all_cols[[1]],results_list_all_cols[[2]],results_list_all_cols[[3]],
                           results_list_all_cols[[4]],results_list_all_cols[[5]]))

# calculate the average of all predictions across the 5 models.
res_df <- res_df %>% mutate(mean_pred=rowMeans(across()))

# calculate rmse on the averaged vector
sqrt(mean((mf_test_df$GammaGTValue- res_df[,'mean_pred'])^2))