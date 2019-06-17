function S = silhouette(im)

[h,w,d] = size(im);

%% Color segmentation: red dinosaur in blue background
S = im(:,:,1) > (im(:,:,3)-2);

%% Remove noise

% Remove regions touching the border or smaller than 10% of image area
S = imclearborder(S);
S = bwareaopen(S, ceil(h*w/10));

% Remove holes < 1% image area
S = ~bwareaopen(~S, ceil(h*w/100));
