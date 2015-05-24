function stitch(imgFiles)
  images = cell(length(imgFiles), 1);    

  maxDim = 800;
    %load the images in list.
    for i=1:length(imgFiles)
         imgFile=imgFiles{i};
        img = imread(imgFile);
%         val = max(size(img));
%         if maxDim > 0 && val > maxDim
%             img = imresize(img, maxDim / val);
%         end
        images{i} = img;
    end
    
    [sifts, siftLocations] = getSift(images); %get sift locations and discriptors based on toolbox. 
    
    [H,  imagePairs, matchPairs, InlierPairs] = getH(sifts, siftLocations, images);%get homogeneous 
    
    Imws=warp(H, images);% warp each image into the new canvas;
    putTogether(Imws);      %put the images together with gain compension. 
    
    
    figure
    imshow(imagePairs{i});
    hold on;
    plot(matchPairs{i}(:,1),matchPairs{i}(:,2),'wo');
    figure 
    imshow(imagePairs{i});
    hold on
     plot(matchPairs{i}(InlierPairs{i},1),matchPairs{i}(InlierPairs{i},2),'go');
end