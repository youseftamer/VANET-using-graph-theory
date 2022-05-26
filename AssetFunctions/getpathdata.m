function [momatx, momaty] = getpathdata(SP, x, y, spd)
    
    n = length(x);
    motioncellx = cell(n);
    motioncelly = cell(n);
    
    arr=zeros(1,spd);               
    for j=1:n
        for i= 1 : n
            motioncellx(j,i)= mat2cell(arr,1,spd);
            motioncelly(j,i)= mat2cell(arr,1,spd);
        end
    end
    
    for j=1:n
        for i= 1: length(SP{j})-1 
            motioncellx(j,i)= mat2cell(linspace(x(SP{j}(i)),x(SP{j}(i+1)),spd),1,spd); 
            motioncelly(j,i)= mat2cell(linspace(y(SP{j}(i)),y(SP{j}(i+1)),spd),1,spd);
        end
    end
    
    momatx = cell2mat(motioncellx);
    momaty = cell2mat(motioncelly);
end