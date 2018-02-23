function [tracksFinal, props] = runMultimotPhaseMasking(session, imageId, saveResults, varLen, doContour)
tic;

%[saveResults.filename, saveResults.dir] = uiputfile('*.mat','Save Results','tracks.mat');
theImage = getImages(session, imageId);
pixels = theImage.getPrimaryPixels;
numT = pixels.getSizeT.getValue;

%varLen = optimiseVarLen(session, imageId);

for thisT = 1:numT
    plane = getPlane(session, imageId, 0, 0, thisT-1);
    mask = multimotPhaseMasking(plane, 1, varLen, doContour);
    props{thisT} = multimotLabelCells(mask);
    
    
    %Store label masks for tracking?
    %Does anyone want them on the server?
end

movieInfo = uTrackMovieInfoFromProps(props);

tracksFinal = trackGeneral(saveResults, movieInfo);

uTrackToCMSO(tracksFinal, imageId, saveResults);

zipDpkg(saveResults, imageId);

attachCMSODatapackage(session, imageId, saveResults);

%plotTracks2D(tracksFinal);

toc;