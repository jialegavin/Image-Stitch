function Imws=warp(homoInfo, images)
    
    nImages = length(images);
    assert(length(homoInfo) == nImages);
    Imws=cell(nImages,1);
    bbox = getBoundingBox([0 0 0 0], images, homoInfo);
    for i=1:nImages
       [height, width, layer] = size(images{i});
       im=double(images{i});
        bb_xmin = bbox(1);
        bb_xmax = bbox(2);
        bb_ymin = bbox(3);
        bb_ymax = bbox(4);

        [U,V] = meshgrid(bb_xmin:bb_xmax,bb_ymin:bb_ymax);
        [nrows, ncols] = size(U);

        Hi = inv(homoInfo{i});
         u = U(:);
          v = V(:);
          x1 = Hi(1,1) * u + Hi(1,2) * v + Hi(1,3);
          y1 = Hi(2,1) * u + Hi(2,2) * v + Hi(2,3);
          w1 = 1./(Hi(3,1) * u + Hi(3,2) * v + Hi(3,3));
          U(:) = x1 .* w1;
          V(:) = y1 .* w1;
          if layer == 3
            nim(nrows, ncols, 3) = -1;
           
            nim(:,:,1) = interp2(im(:,:,1),U,V,'linear');
           
            nim(:,:,2) = interp2(im(:,:,2),U,V,'linear');
         
            nim(:,:,3) = interp2(im(:,:,3),U,V,'linear');
          else
            nim(nrows, ncols) = 1;
            nim(:,:) = interp2(im(:,:),U,V,'linear',10);
          end
        
        Imws{i}=nim; 
    end
    
   

end

function newBox = getBoundingBox(bbox, images, H)
    assert(length(images) == length(H));
    n = length(images);
    newBox = bbox;
    for i=1:n
        [w, h, ~] = size(images{i});
        imgBox = H{i}*[1 w 1 w; 1 1 h h; 1 1 1 1];
        imgBox = [imgBox(1, :) ./ imgBox(3, :); ...
                  imgBox(2, :) ./ imgBox(3, :)];
        newBox = [  ceil(min(newBox(1), min(imgBox(1, :)))) ...
                    ceil(max(newBox(2), max(imgBox(1, :)))) ...
                    ceil(min(newBox(3), min(imgBox(2, :)))) ...
                    ceil(max(newBox(4), max(imgBox(2, :))))];
    end
end