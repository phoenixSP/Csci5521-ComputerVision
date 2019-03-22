function [label_test_pred] = PredictKNN(feature_train, label_train, feature_test, k) 
Mdl = fitcknn(feature_train,label_train,'NumNeighbors',k,'Distance', 'correlation');
label_test_pred = predict(Mdl,feature_test);
end