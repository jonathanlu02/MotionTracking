% Takes in a 4-D video matrix and number of frames to read, and converts
% the moving mass in the video to coordinates returned by matrix A.
function A = readData(vid)

%%% setting up the Frame Differencing method %%%
numFrames = size(vid, 4);

%%  turn resulting 4-d video matrix to 3-d grayscale matrix (w,h,numFrames)
for k = numFrames:-1:1 % note: start backwards to initialize size of g
    g(:, :, k) = rgb2gray(vid(:, :, :, k));
end

%% compute frame differences
for k = numFrames-1:-1:1
    d(:, :, k) = imabsdiff(g(:, :, k), g(:, :, k+1));
end
% imtool(d(:, :, 1), []) %difference b/w frame 1 and 2
% implay(d)

%% compute threshold to divide foreground/background pixels
% essentially divides pixels to only black/white (binary), where black
% resembles non-movement, white resembles change in frame (movement)

% note how the paint can has a huge mass of white pixel density
thresh = graythresh(d); % range [0, 1]
bw = (d >= thresh * 255); %scale back to data range [0, 255]
% implay(bw)

centroids = zeros(numFrames, 2);
for k = 1:numFrames-1
    L = bwlabel(bw(:, :, k));
    s = regionprops(L, 'area', 'centroid'); % calculate centroids for connected components
    area_vector = [s.Area];
    [tmp, idx] = max(area_vector);
    if (~isempty(s)) % some frames stutter and don't have any binary image
        centroids(k, :) = s(idx(1)).Centroid; %(x,y) coordinates
    end
end

x = centroids(:,1);
y = centroids(:,2);

% remove 0s from stuttering frames
x = x(find(x~=0));
y = y(find(y~=0));

% subtract mean for each value (centering the data)
x = x - (ones(length(x),1)*mean(x));
y = y - (ones(length(y),1)*mean(y));

%plot(1:length(y), y)

A = [x'; y'];