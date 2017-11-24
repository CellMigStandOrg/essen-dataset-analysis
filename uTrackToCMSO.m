function uTrackToCMSO(tracks, imageId, saveResults)

%Create JSON
createCMSOJSON(imageId, saveResults)

numTracks = numel(tracks);

cmso_object_id = [];
cmso_frame_id = [];
cmso_x_coord = [];
cmso_y_coord = [];

%For the moment this will not deal with split or joined tracks.
for thisTrack = 1:numTracks
    numFrames = numel(tracks(thisTrack).tracksFeatIndxCG);
    xIdx = 1;
    yIdx = 2;
    %for cmso_tracks
    cmso_link_id = [cmso_link_id; thisTrack];
    cmso_track_id = [cmso_track_id; thisTrack];
    cmso_object_id_links = [cmso_object_id_links; thisTrack];
    for thisFrame = 1:numFrames
        %For cmso_objects
        cmso_object_id = [cmso_object_id; thisTrack];
        cmso_frame_id = [cmso_frame_id; thisFrame];
        cmso_x_coord = [cmso_x_coord; tracks(thisTrack).tracksCoordAmpCG(xIdx)];
        cmso_y_coord = [cmso_y_coord; tracks(thisTrack).tracksCoordAmpCG(yIdx)];
        
        xIdx = xIdx + 8;
        yIdx = yIdx + 8;
    end   
end

objectsTbl = table(cmso_object_id, cmso_frame_id, cmso_x_coord, cmso_y_coord);

writetable(objectsTbl, [saveResults.path 'objects_' imageId '.csv'])
