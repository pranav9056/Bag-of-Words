function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix

	load('vision.mat');
	load('../data/traintest.mat');
    conf = zeros(8,8);
    target ='../data/';
    for i = 1:size(test_imagenames,1)
        imPath = [target,test_imagenames{i}];
        imPath1 = strrep(imPath,'.jpg','.mat');
        if exist(imPath1,'file')
            load(imPath1);
        else
            image = imread(imPath);
            wordMap = getVisualWords(image, filterBank, dictionary);
        end
        h = getImageFeaturesSPM(3, wordMap, size(dictionary,2));
        distances = distanceToSet(h, train_features);
        [~,nnI] = max(distances);
        conf(test_labels(i),train_labels(nnI)) =  conf(test_labels(i),train_labels(nnI))+1;

        

    end
    acc = (trace(conf)/sum(conf(:)))*100;
    fprintf('Accuracy: %f \n',acc);


	% TODO Implement your code here

end