function [maskBWL, props] = multimotLabelCells(mask)

maskBWL = bwlabel(mask);
props = regionprops(maskBWL, 'Area', 'ConvexImage');

numObj = length(props);

for thisObj = 1:numObj
    %Compare Area to ConvexHull
    convImg = props(thisObj).ConvexImage;
    objArea = props(thisObj).Area;
    %relSize(thisObj) = objArea/sum(sum(convImg));
    if objArea < 50
        maskBWL(maskBWL == thisObj) = 0;
    end
end

maskBWL = bwlabel(maskBWL);
props = regionprops(maskBWL, 'Area', 'ConvexImage', 'BoundingBox', 'Centroid');

