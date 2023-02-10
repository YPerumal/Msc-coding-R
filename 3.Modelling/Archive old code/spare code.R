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



# Extra Code

## Decision Tree

-Gonna can this for the moment

Used Rpart and Caret
```{r}
# Decision Trees
# Set train control for cross-val
# dt_ctrl <- trainControl(method = 'cv', number = 5, verboseIter = F)
# 
# #rpart
# dt_grid <- expand.grid(cp = c(0.0001,0.001,0.01,0.05,0.1)) #Default for regression is 5. Controls tree size.
# 
# # # rpart2
# # dt_grid <- expand.grid(maxdepth = c(5,10,20)
# #                        ) #Default for regression is 5. Controls tree size.
# 
# set.seed(42)
# dt_gridsearch <- train(GammaGTValue ~ .,
#                        data = train_df,
#                        method = 'rpart',
#                        trControl = dt_ctrl
#                        ,tuneGrid = dt_grid #Here is the grid
#                        )
# 
# # dt_gridsearch$bestTune
# # cp <- dt_gridsearch$bestTune[[1]]
# 
# # train a final model to get variable importance plot
# # library(rpart)
# # dt_final <-  rpart(GammaGTValue ~ ., data = train_df,cp=cp)
# 
# #Predictions
# dt_grid_pred <- predict(dt_gridsearch, newdata = test_df)
# dt_rmse_long <-  sqrt(mean((test_df$GammaGTValue- dt_grid_pred)^2))
```

Using the Trees Library
```{r}
# Decision Trees
# set.seed(42)
# 
# tree_model <- tree(GammaGTValue ~ ., data=train_df)
# summary(tree_model)
# 
# plot(tree_model)
# text(tree_model, cex=0.8)
# 
# # cross validation
# cv_tree <- cv.tree(tree_model)
# plot(cv_tree$size, cv_tree$dev, type = 'b')
# 
# ## pruning
# prune_tree <- prune.tree(tree_model, best = 2)
# plot(prune_tree)
# text(prune_tree, pretty=0, cex=0.8)
# 
# tree_yhat<- predict(tree_model, newdata=x_test)
# tree_res <- data.frame(tree_yhat,y_test)
# plot(tree_res$tree_yhat, tree_res$tree_yhat)
# 
# tree_rmse <- sqrt(mean((tree_yhat-y_test$GammaGTValue)^2))# MSE



# from imput splits


# Extra code

```{r}
## First Attempt
# tmp_factors %>%
# group_by(rowname, PUBLIC_SECTOR_IND) %>%
# tally() %>%
# arrange(rowname, desc(n)) %>%
# summarize(freq = first(PUBLIC_SECTOR_IND))
```


```{r}
# Code Stefan helped me with 

# dum %>% group_by(name) %>% summarise(across(where(is.numeric), mean))
# 
# fn <- function(x){
#     names(sort(table(x), decreasing = T))[1]
# }
# 
# dumm %>% group_by(name) %>% summarise(across(where(is.factor), fn))
```


```

