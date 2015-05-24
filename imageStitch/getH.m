function [homoInfo, imagePairs, matchPairs, InlierPairs] = getH(sifts, siftLocations, images)
%homoInfo is the H of each images based on the order of images.
%imagePairs are pairs of images. Two images used to get match points and
%Inlier points are set as one pair. The operation of this one is used to
%show the matched points and inlier points. 
%matchPairs are the matched locations based on imagePairs
%InlierPairs are the inlier index in match locations based on imagePairs
%and matchPairs
%input:
%       sifts are the sift discriptors of each siftLocations
%       siftLocations are the sift keypoints locations
%       images are the input images save in list. 
    nImages = length(sifts);
    imagePairs=cell(2*(nImages-1),1);
    matchPairs=cell(2*(nImages-1),1);
    InlierPairs=cell(2*(nImages-1),1);
    assert(length(siftLocations) == nImages);
    assert(length(images) == nImages);
    
    iReference = ceil(nImages / 2);%set the base image as the middle of the image list. 
    homoInfo = cell(nImages, 1);
%     inliers = cell(nImages,1);
    MATCH_THRESHOLD = 0.2; 
    RANSAC_N = 300;    %the iteration of RANSAC
    RANSAC_EPSILON = 3;
    RANSAC_FINISH_THRES = 0.8;
    index=1;
    % compute homo for neighbors
    for i=1:nImages
        if i == iReference
            H = eye(3);
        else
            if i < iReference
                j = i + 1;
            else
                j = i - 1;
            end
                matches = match(sifts{i}, sifts{j},  MATCH_THRESHOLD);
                matchLocations1 = siftLocations{i}(matches(:, 1), :);
                matchLocations2 = siftLocations{j}(matches(:, 2), :);
               
                 [H, inlierIdx] = ransac(matchLocations1, matchLocations2, ...
                        RANSAC_N, RANSAC_EPSILON, RANSAC_FINISH_THRES);
               if(i<iReference)
                imagePairs{index}=images{i};
                matchPairs{index}=matchLocations1;
                InlierPairs{index}=inlierIdx;
                index=index+1;
                imagePairs{index}=images{j};
                matchPairs{index}=matchLocations2;
                InlierPairs{index}=inlierIdx;
                index=index+1;
               else
                imagePairs{index}=images{j};
                matchPairs{index}=matchLocations2;
                InlierPairs{index}=inlierIdx;
                index=index+1;
                imagePairs{index}=images{i};
                matchPairs{index}=matchLocations1;
                InlierPairs{index}=inlierIdx;
                index=index+1;
               end

        end
        homoInfo{i} = H;
    end
    
    % update homo
    for i=iReference-2:-1:1
        homoInfo{i} = homoInfo{i} * homoInfo{i + 1};
    end
    for i=iReference+2:nImages
        homoInfo{i} = homoInfo{i} * homoInfo{i - 1};
    end 
end