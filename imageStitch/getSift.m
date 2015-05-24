function [sifts siftLocations] = getSift(images, maxDim)
% Compute the sift descriptor of N images
% imgFiles - N x 1 cell array containing image file names
% sifts - N x 1 cell array, sifts{i} is a M x 128 array containing 
%         M sift feature vectors of image i.
% siftLocations - N x 1 cell array, siftLocations is a M x 2 array 
%                   containing (x, y) of M interesting points of image i

  sifts = cell(length(images), 1);
  siftLocations = cell(length(images), 1);
 
    for i=1:length(images)
        img=images{i};
        img2=single(rgb2gray(img));
        [f d]=vl_sift(img2);
        sifts{i}=double(d');
        siftLocations{i}=round([f(1,:)' f(2,:)']);
        images{i} = img;
%         figure
%         imshow(img);
%         perm = randperm(size(f,2)) ;
%         sel = perm(1:50) ;
%         h3 = vl_plotsiftdescriptor(d(:,sel),f(:,sel)) ;
%         figure
%         imshow(img);
%         hold on;
%         plot(f(1,:),f(2,:),'g.');
    end

end