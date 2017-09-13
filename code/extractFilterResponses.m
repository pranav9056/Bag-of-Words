function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W x H x N*3 matrix of filter responses


% TODO Implement your code here
if (size(img,3)==1)
   img = repmat(img,1,1,3); 
end
img = double(img);
[l,a,b] = RGB2Lab(img(:,:,1),img(:,:,2),img(:,:,3));
imgLab = cat(3,l,a,b);
for bank = 1:size(filterBank,1)
    conv = imfilter(imgLab,filterBank{bank},'replicate');
    
    if bank == 1
        filterResponses = conv;
%        mont = conv;
    else
        filterResponses = cat(3,filterResponses,conv);
%        mont  = cat(4,mont,conv);
    end
end
%montage(mont,'Size',[4 5]) % to get a montage 
end

