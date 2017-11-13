function props = runMultimotPhaseMasking(session, imageId)
tic;

theImage = getImages(session, imageId);
pixels = theImage.getPrimaryPixels;
numT = pixels.getSizeT.getValue;
for thisT = 1:10
    plane = getPlane(session, imageId, 0, 0, thisT-1);
    [mask, ~] = multimotPhaseMaskingIdx(plane, 1, 8);
    [maskBWL, props{thisT}] = multimotLabelCells(mask);
    %Store label masks for tracking?
    %Does anyone want them on the server?
end

toc;