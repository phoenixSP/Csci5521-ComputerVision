function [bow_feature] = ComputeBoW(feature, vocab) 

pre_histogram=knnsearch(double(vocab),double(feature) );
%model = fitcknn(vocab,label_train,'NumNeighbors',k,'Distance', 'correlation');
%pre_histogram = predict(model,feature);
histo=histcounts(pre_histogram,'BinLimits',[1, size(vocab,1)], 'BinMethod','integers');
bow_feature=histo/norm(histo);

end