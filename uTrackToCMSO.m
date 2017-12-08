function uTrackToCMSO(tracks, imageId, saveResults)

numTracks = numel(tracks);

%Create variables
cmso_object_id = [];
cmso_frame_id = [];
cmso_track_id = [];
cmso_link_id_tracks = [];
cmso_object_id_links = [];
cmso_link_id = [];
cmso_x_coord = [];
cmso_y_coord = [];
cmso_link_id_counter = 1;
cmso_object_id_counter = 1;

for thisTrack = 1:numTracks
    
    numFrames = numel(tracks(thisTrack).tracksFeatIndxCG(1,:));
    numLinksThisTrack = numel(tracks(thisTrack).tracksFeatIndxCG(:,1));
    
    for thisLink = 1:numLinksThisTrack
        %For tracks.csv
        cmso_track_id = [cmso_track_id; thisTrack];
        cmso_link_id_tracks = [cmso_link_id_tracks; cmso_link_id_counter];
        
        xIdx = 1;
        yIdx = 2;
        
        for thisFrame = 1:numFrames
            %For links.csv
            cmso_link_id = [cmso_link_id; cmso_link_id_counter];
            cmso_object_id_links = [cmso_object_id_links; cmso_object_id_counter];
            %For cmso_objects
            frameIdx = tracks(thisTrack).seqOfEvents(1,1) + thisFrame - 1;
            cmso_object_id = [cmso_object_id; cmso_object_id_counter];
            cmso_frame_id = [cmso_frame_id; frameIdx];
            cmso_x_coord = [cmso_x_coord; tracks(thisTrack).tracksCoordAmpCG(thisLink, xIdx)];
            cmso_y_coord = [cmso_y_coord; tracks(thisTrack).tracksCoordAmpCG(thisLink, yIdx)];
            
            xIdx = xIdx + 8;
            yIdx = yIdx + 8;
            cmso_object_id_counter = cmso_object_id_counter + 1;
        end
        cmso_link_id_counter = cmso_link_id_counter + 1;
    end
end

objectsTbl = table(cmso_object_id, cmso_frame_id, cmso_x_coord, cmso_y_coord);
cmso_object_id = cmso_object_id_links;
linksTbl = table(cmso_link_id, cmso_object_id);
cmso_link_id = cmso_link_id_tracks;
tracksTbl = table(cmso_track_id, cmso_link_id);

writetable(objectsTbl, [saveResults.dir 'objects_' num2str(imageId) '.csv']);
writetable(linksTbl, [saveResults.dir 'links_' num2str(imageId) '.csv']);
writetable(tracksTbl, [saveResults.dir 'tracks_' num2str(imageId) '.csv']);
%Create JSON
createCMSOJSON(imageId, saveResults, 1);