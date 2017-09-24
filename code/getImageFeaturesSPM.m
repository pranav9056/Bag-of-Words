function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)

    % TODO Implement your code here
    rows = size(wordMap,1);
    cols = size(wordMap,2);
    for l = 0:layerNum-1
%        disp('layer number ');
%        disp(l);
        if l == 0 
            h = getImageFeatures(wordMap,dictionarySize);
            if layerNum - 1 > 2
                w  = 2-(layerNum-1);
            else
                w = 1/4;
            end
%            disp(w);
            h = h*w;
        else
            if l == 1 && layerNum-1 > 2
                w  = 2-(layerNum-1);
            elseif l == 1 && layerNum-1 <= 2
                w = 1/4;
            else
                w = 2^(l - (layerNum - 1) -1);
            end
%            disp('weight');
%            disp(w);
            rowD = rows/(2*l);
            colD = cols/(2*l);
            valIB = 1;
            for i = 0:(2*l)-1
                valIS = floor(rowD*(i+1));
                valJB = 1;
                for j = 0:(2*l)-1                    
                    valJS = floor(colD*(j+1));
%                    disp('IB ')
%                    disp(valIB);
%                    disp('IS ')
%                    disp(valIS);
%                    disp('JB ')
%                    disp(valJB);
%                    disp('JS ');
%                    disp(valJS);
                    th = getImageFeatures(wordMap(valIB:valIS,valJB:valJS),dictionarySize);
                    th = th*w;
                    h = cat(1,h,th);
                    valJB = floor(colD*(j+1))+1;
                end
                valIB = floor(rowD*(i+1))+1;
            end
        end
        
    end
    
    


end