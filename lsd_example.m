% lsd_example.m
% Test LSD algorithm with MATLAB
%% show the image.
%pathname='./images/YC.jpg';
pathname='./xiaozhu/IMG_8966.jpg';
im = imread(pathname);
% pathname='./xiaozhu/IMG_8966.jpg';
% im = imread(pathname);
imshow(im);
%% get the start_points and end_points of each straight line use LSD.
% note: input parameter is the path of image, use '/' as file separator.
% points = lsd('./images/YC.jpg');
points = lsd(pathname);
%% plot the lines.
hold on;
for i = 1:size(points, 2)
    plot(points(1:2, i), points(3:4, i), 'LineWidth', 2, 'Color', [1, 0, 0]);
end
