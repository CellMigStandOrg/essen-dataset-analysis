function finalProps = multimotLabelCells(mask)

props = regionprops(mask, 'Area', 'Centroid');
finalProps = struct;
counter = 1;

numObj = length(props);

for thisObj = 1:numObj
    objArea = props(thisObj).Area;
    
    if objArea > 50        
        finalProps(counter).Area = props(thisObj).Area;
        finalProps(counter).Centroid = props(thisObj).Centroid;
        counter = counter + 1;
    end
end

