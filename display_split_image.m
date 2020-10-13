I= imread('.\32.tif');
splitI = split_image(I(:, :, 2), 200);
sizeI = size(splitI);
montage(splitI', 'borderSize', [2 2], 'backgroundColor', 'white', 'size', sizeI);