function [confusion, accuracy] = ClassifyKNN_Tiny

file=fopen(".\scene_classification_data\train.txt");
end_of_file = fgetl(file);
train_class=[];
output_size=[16 16];
feature_train=[];
while ischar(end_of_file)
    cell = strsplit(end_of_file);
    train_class=[train_class; convertCharsToStrings(cell{1})];
    filename=".\scene_classification_data\"+cell{2};
    I=imread(filename);
    feature= GetTinyImage(I, output_size);
    feature_train=[feature_train; feature'];
    end_of_file = fgetl(file);
end

fclose(file);
label_train=grp2idx(train_class);

file=fopen(".\scene_classification_data\test.txt");
end_of_file = fgetl(file);
test_class=[];
output_size=[16 16];
feature_test=[];
while ischar(end_of_file)
    cell = strsplit(end_of_file);
    test_class=[test_class; convertCharsToStrings(cell{1})];
    filename=".\scene_classification_data\"+cell{2};
    I=imread(filename);
    feature= GetTinyImage(I, output_size);
    feature_test=[feature_test; feature'];

    end_of_file = fgetl(file);
end

fclose(file);
label_test=grp2idx(test_class);

k=10;
[label_test_pred] = PredictKNN(feature_train, label_train, feature_test, k);
% [label_test_pred] = PredictSVM(feature_train, label_train, feature_test);

accuracy= sum(label_test_pred==label_test)*100/size(label_test,1);

confusion = confusionmat(label_test,label_test_pred);

end