function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.

% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)

    % TODO Implement your code here
    dictionary = dictionary';
    wordMap = zeros(size(img,1),size(img,2));
    filterResponses = extractFilterResponses(img,filterBank);
    for i = 1:size(filterResponses,1)
        for j = 1:size(filterResponses,2)
        temp = filterResponses(i,j,:);
        temp = reshape(temp,[1,size(filterResponses,3)]);
        distanceArr = pdist2(temp,dictionary);
        [minVal,minInd] = min(distanceArr);
        wordMap(i,j) = minInd;
        end
    end


end
