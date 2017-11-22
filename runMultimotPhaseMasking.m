function [tracksFinal, props] = runMultimotPhaseMasking(session, imageId)
tic;

[saveResults.filename, saveResults.dir] = uiputfile('*.mat','Save Results','tracks.mat');
theImage = getImages(session, imageId);
pixels = theImage.getPrimaryPixels;
numT = pixels.getSizeT.getValue;
for thisT = 1:numT
    plane = getPlane(session, imageId, 0, 0, thisT-1);
    [mask, ~] = multimotPhaseMaskingIdx(plane, 1, 8);
    [~, props{thisT}] = multimotLabelCells(mask);
    
    
    %Store label masks for tracking?
    %Does anyone want them on the server?
end

movieInfo = uTrackMovieInfoFromProps(props);

tracksFinal = trackGeneral(saveResults, movieInfo);

plotTracks2D(tracksFinal);

toc;