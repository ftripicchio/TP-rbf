I= imread('./testImages/prueba1.tif');
% splitI = split_image(I(:, :, 2), 200);
% montage(splitI', 'borderSize', [2 2], 'backgroundColor', 'white', 'size', [8 12]);

greenChannel = I(:, :, 2);
blueChannel = I(:, :, 3);

%normalizacion
[counts,x] = imhist(greenChannel,256);
Treshold = otsuthresh(counts);
binaryImage = greenChannel > (Treshold * 700);
exudatesImage = binaryImage;
%figure,imshow(binaryC);

%segmentar en bloques de 200
greenSplit = split_image(greenChannel, 200);
blueSplit = split_image(blueChannel, 200);
binarySplit = split_image(binaryImage, 200);
exudatesSplit = split_image(exudatesImage, 200);
cellSize = size(greenSplit);

resultsCell = {};


%k =col
%j= fil
%iteracion sobre bloques
 for k=1:cellSize(2)
    for j=1:cellSize(1)
        currentGreen = greenSplit{j,k};
        currentBlue = blueSplit{j,k};
        currentBinary = binarySplit{j,k};
        surroundingBlue = get_surrounding_region(blueSplit,j,k);
        surroundingGreen = get_surrounding_region(greenSplit,j,k);
        
        %feature1: Homogeneidad del canal verde en la region
        feature1 = double(entropy(currentGreen));

        %feature2: Relación de la media del canal azul en la región con la
        %media del canal azul en la sección al rededor de la region
        localBlueMean = mean(currentBlue,'all');
        feature2 = double(localBlueMean/meanExtended(surroundingBlue));
        
        %feature3 
        aux=imgradient(currentGreen,'prewitt');
        feature3=double(aux(1));
        
        
        %feature5: Relación de la media del canal verde en la región con la
        %media del canal verde en la sección al rededor de la region
        localGreenMean = mean(currentGreen,'all');
        feature5 = localGreenMean/meanExtended(surroundingGreen);
        
        %feature6: Valor del pixel central del canal verde en la region
        sizeCurrentGreen=size(currentGreen);
        feature6 = double(currentGreen(int32(sizeCurrentGreen(1)/2),int32(sizeCurrentGreen(2)/2)));
        
        %feature7: Media del canal azul en la sección al rededor de la
        %región (5px)
        feature7=double(meanExtended(surroundingBlue));
        
        %feature8: tamaño de la región
        feature8 = double(sizeCurrentGreen(1)*sizeCurrentGreen(2));
        
        %feature4
        feature4=double(power(sum(bwperim(currentBinary),'all'),2)/feature8);
        
        %feature9: Desviacion estandar del canal verde en la sección al
        %rededor de la región (5px)
        feature9 = double(std2Extended(surroundingGreen));
        
        %feature10: Desviación estandar del canal verde en la region
        feature10 = double(std2(currentGreen));
        
        %feature11: Homogeneidad del canal azul en la region
        feature11 = double(entropy(currentBlue));
        
        %feature12: Desviacion estandar del canal azul en la sección al
        %rededor de la región (5px)
        feature12 = double(std2Extended(surroundingBlue));
        
        featureVectorPrueba = [feature1; feature2; feature3; feature4; feature5; feature6; feature7; feature8; feature9; feature10; feature11; feature12];
        netResult = net(featureVectorPrueba);
        resultsCell{j,k} = netResult;
        if (netResult < 0)
            exudatesSplit{j,k} = logical(exudatesSplit{j,k} * 0);
        end
    end
 end
blankImage = zeros(size(exudatesImage));
rgbImage = cat(3, blankImage , cell2mat(exudatesSplit) , blankImage);
C = imfuse(I,rgbImage,'blend');
imshow(C)
 

 

 



         


