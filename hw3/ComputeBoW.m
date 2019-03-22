function [bow_feature] = ComputeBoW(feature, vocab) 
k=10;
label_train=[1:size(vocab,1)];
model = fitcknn(vocab,label_train,'NumNeighbors',k,'Distance', 'correlation');

pre_histogram = predict(model,feature);
histo=histcounts(pre_histogram,size(vocab,2));
bow_feature=histo/norm(histo);

end