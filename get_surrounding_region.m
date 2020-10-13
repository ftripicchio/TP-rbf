function [surroundingRegion] = get_surrounding_region(image,j,k)
    t = size(image);
    curS = size(image{j,k});
    surroundingRegion = {};
    if (j>1 && k>1)
        aux = image{j-1, k-1};
        s = size(aux);
        aux = aux([s(1)-4:s(1)],[s(2)-4:s(2)]);
        surroundingRegion{1,1} = uint8(aux);
    else
        surroundingRegion{1,1} = uint8(ones(5));
    end
    
    if (j>1)
        aux = image{j-1, k};
        s = size(aux);
        aux = aux([s(1)-4:s(1)],[1:s(2)]);
        surroundingRegion{1,2} = uint8(aux);
    else
        surroundingRegion{1,2} = uint8(ones([5 curS(2)]));
    end
    
    if (j>1 && k<t(2))
        aux = image{j-1, k+1};
        s = size(aux);
        aux = aux([s(1)-4:s(1)], [1:5]);
        surroundingRegion{1,3} = uint8(aux);
    else
        surroundingRegion{1,3} = uint8(ones(5));
    end
    
    if (k>1)
        aux = image{j, k-1};
        s = size(aux);
        aux = aux([1:s(1)], [s(2)-4:s(2)]);
        surroundingRegion{2,1} = uint8(aux);
    else
        surroundingRegion{2,1} = uint8(ones([curS(1) 5]));
    end
    
    surroundingRegion{2,2} = uint8(ones(curS));
    
    if (k<t(2))
        aux = image{j, k+1};
        s = size(aux);
        aux = aux([1:s(1)], [1:5]);
        surroundingRegion{2,3} = uint8(aux);
    else
        surroundingRegion{2,3} = uint8(ones([curS(1) 5]));
    end
    
    if (j<t(1) && k>1)
        aux = image{j+1, k-1};
        s = size(aux);
        aux = aux([1:5],[s(2)-4:s(2)]);
        surroundingRegion{3,1} = uint8(aux);
    else
        surroundingRegion{3,1} = uint8(ones(5));
    end
    
    if (j<t(1))
        aux = image{j+1, k};
        s = size(aux);
        aux = aux([1:5],[1:s(2)]);
        surroundingRegion{3,2} = uint8(aux);
    else
        surroundingRegion{3,2} = uint8(ones([5 curS(2)]));
    end
    
    if (j<t(1) && k<t(2))
        aux = image{j+1, k+1};
        s = size(aux);
        aux = aux([1:5], [1:5]);
        surroundingRegion{3,3} = uint8(aux);
    else
        surroundingRegion{3,3} = uint8(ones(5));
    end

    %surroundingRegion = cell2mat(surroundingRegion);
end

