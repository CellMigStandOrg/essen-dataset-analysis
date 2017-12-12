function zipDpkg(saveResults, imageId)

objectsFile = [saveResults.dir 'objects_' num2str(imageId) '.csv'];
linksFile = [saveResults.dir 'links_' num2str(imageId) '.csv'];
tracksFile = [saveResults.dir 'tracks_' num2str(imageId) '.csv'];
jsonFile = [saveResults.dir 'CMSO_' num2str(imageId) '.json'];

zip([saveResults.dir 'cmso_tracks_' num2str(imageId) '.zip'], {objectsFile, linksFile, tracksFile, jsonFile});
