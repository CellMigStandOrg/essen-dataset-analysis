function trackSummary = tracksFromCMSODatapackage(session, imageId, filePath)

imageObj = getImages(session, imageId);
fileAnnotation = getImageFileAnnotations(session, imageId, 'include', 'CMSO_datapackage');
origFile = fileAnnotation.getFile;
fileName = char(origFile.getName.getValue.getBytes');
getFileAnnotationContent(session, fileAnnotation, [filePath fileName]);
unzip([filePath fileName], filePath);

%Find the json file and get details of the tracking
try
    [objects, links, tracks] = readCMSOJSON(filePath, ['CMSO_' num2str(imageId) '.json']);
catch
    [jsonFileName, filePath] = uigetfile('*.json', 'Please choose the JSON file');
    [objects, links, tracks] = readCMSOJSON(filePath, jsonFileName);
end

[objectsData, linksData, tracksData] = readCMSOTracks(filePath, objects, links, tracks);

trackSummary = CMSOTrackSummary(objectsData, linksData, imageObj);
writetable(trackSummary, [filePath 'trackSummary_' num2str(imageId) '.xlsx']);