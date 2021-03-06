function buildRecognitionSystem()
% Creates vision.mat. Generates training features for all of the training images.

	load('dictionary.mat');
	load('../data/traintest.mat');
    for i = 1:size(train_imagenames,1)
        imPath = train_imagenames{i};
        imPath1 = ['../data/',strrep(imPath,'.jpg','.mat')];
        if exist(imPath1,'file')
            load(imPath1);
        else
            image = imread(['../data/',imPath]);
            wordMap = getVisualWords(image, filterBank, dictionary);
        end
        if i == 1
            train_features = getImageFeaturesSPM(3,wordMap,size(dictionary,2));
        else
            temp = getImageFeaturesSPM(3,wordMap,size(dictionary,2));
            train_features = cat(2,train_features,temp);
        end
        
        
    end
    
    
    

	% TODO create train_features


	save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');

end