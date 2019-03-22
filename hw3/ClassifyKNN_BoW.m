function [confusion, accuracy] = ClassifyKNN_BoW 

%getting data
file=fopen(".\scene_classification_data\train.txt");
end_of_file = fgetl(file);
training_image_cell={};
index=1;
train_class=[];
while ischar(end_of_file)
    cell = strsplit(end_of_file);
    train_class=[train_class; convertCharsToStrings(cell{1})];

    filename=".\scene_classification_data\"+cell{2};
    I=imread(filename);
    
    training_image_cell{index}=I;
    index=index+1;
    end_of_file = fgetl(file);
end
fclose(file);

%getting test image
file=fopen(".\scene_classification_data\test.txt");
end_of_file = fgetl(file);
testing_image_cell={};
index=1;
test_class=[];
while ischar(end_of_file)
    cell = strsplit(end_of_file);
    test_class=[test_class; convertCharsToStrings(cell{1})];
    filename=".\scene_classification_data\"+cell{2};
    I=imread(filename);
    testing_image_cell{index}=I;
    index=index+1;
    end_of_file = fgetl(file);
end
fclose(file);

dic_size=50;
vocab = BuildVisualDictionary(training_image_cell, dic_size);

feature_train=[];
for i=1:size(training_image_cell,2)
    im=im2single(training_image_cell{i});
    [~, feature] = vl_dsift(im, 'Fast', 'Step', 20, 'size', 20);
    feature=feature';
    bow_feature = ComputeBoW(feature, vocab);
    feature_train=[feature_train; bow_feature];
end 

label_train=grp2idx(train_class);
label_test=grp2idx(test_class);

k=10;
[label_test_pred] = PredictKNN(feature_train, label_train, feature_test, k);


end