% Takes in a 4-d Video matrix, (x,y) coordinates pertaining to upper left
% starting coordinates, and width (w), height (h) to crop. Returns cropped
% 4-d matrix.
function cropped = cropVid(vid,x,y,w,h)
    numFrames = size(vid, 4);
    for k = 1:numFrames-1
       cropped(:,:,:,k) = imcrop(vid(:,:,:,k), [x y w h]);
    end
end