function [featureVector, existExudateVector] = generar_training_vector()
clear;
excelMatrix = readmatrix('training.xlsx');
excelMatrixSize = size(excelMatrix);
lineaExcel = 1;
existExudateVector = [];
featureVector = [ ; ];
for image = 1:90
   %Por cada imagen se deben leer 12x8 bloques
    imageS=int2str(image);
    I = imread(append('./trainingImages/',imageS,'.tif'));
    
    greenChannel = I(:, :, 2);
    blueChannel = I(:, :, 3);

    %normalizacion
    [counts,x] = imhist(greenChannel,256);
    T = otsuthresh(counts);
    binaryImage = greenChannel > (T * 580);

    %segmentar en bloques de 200
    greenSplit = split_image(greenChannel, 200);
    blueSplit = split_image(blueChannel, 200);
    binarySplit = split_image(binaryImage, 200);
    
    
    
    splitI = split_image(I(:, :, 2), 200);
    sizeSplitI = size(splitI);
    for row = 1:sizeSplitI(1)
        for col = 1:sizeSplitI(2)
            %Calcular features
           
            featureVector = double([featureVector; calculate_features(greenSplit, blueSplit,binarySplit, row, col)]);
            %Valores de entrenamiento
            existExudate = excelMatrix(lineaExcel,4);
            if (existExudate == 0)
                existExudate = -1;
            end
            
            
            %Agregar al vector de entrenamiento el bloque actual.
            existExudateVector = [existExudateVector, existExudate];
            %Leer siguiente linea de excel.
            if (lineaExcel < excelMatrixSize(1))
                lineaExcel = lineaExcel + 1;   
            end
            
            
        end      
    end      
end
featureVector = featureVector';
end