function outputImage = split_image(image, blockSize)
    [r,c] = size(image);
    rowBlocks = floor(r/blockSize);
    extraRow = mod(r,blockSize);
    columnBlocks = floor(c/blockSize);
    extraColumn = mod(c,blockSize);
    x = transpose(zeros(rowBlocks,1) + blockSize);
    x = [x extraRow];
    y = transpose(zeros(columnBlocks,1) + blockSize);
    y = [y extraColumn];
    outputImage = mat2cell(image,x,y);
end

