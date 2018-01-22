function [props, numObj] = optimiseVarLen(session, imageId, doContour)

numObj = [];
for thisLen = 3:30
    plane = getPlane(session, imageId, 0, 0, 0);
    mask = multimotPhaseMaskingIdx(plane, 1, thisLen, doContour);
    props{thisLen} = regionprops(mask, 'Area');
    numObj(end+1) = length(props{thisLen});
end

