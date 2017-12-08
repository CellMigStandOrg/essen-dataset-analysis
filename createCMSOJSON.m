function createCMSOJSON(imageId, saveResults, addTracksData)

imageId = num2str(imageId);
fileText = fileread('template.json');
jsonData = jsondecode(fileText);
jsonData.resources(1).path = ['objects_' imageId '.csv'];
jsonData.resources(2).path = ['links_' imageId '.csv'];

if addTracksData
    jsonData.resources(3) = jsonData.resources(2);
    jsonData.resources(3).name = 'cmso_tracks_table';
    jsonData.resources(3).path = ['tracks_' imageId '.csv'];
    jsonData.resources(3).schema.fields(1).name = 'cmso_track_id';
    jsonData.resources(3).schema.fields(2).name = 'cmso_link_id';
    jsonData.resources(3).schema.foreignKeys.fields = 'cmso_link_id';
    jsonData.resources(3).schema.foreignKeys.reference(1).fields = 'cmso_link_id';
    jsonData.resources(3).schema.foreignKeys.reference(1).resource = 'cmso_links_table';
end

%At the moment the JSON file is not indented and on one line only.
jsonOut = jsonencode(jsonData);
fid = fopen([saveResults.dir 'CMSO_' imageId '.json'], 'w');
fprintf(fid, '%s', jsonOut);
fclose(fid);