function createCMSOJSON(imageId, saveResults)

imageId = num2str(imageId);
fileText = fileread('template.json');
jsonData = jsondecode(fileText);
jsonData.resources(1).path = ['objects_' imageId '.csv'];
jsonData.resources(2).path = ['links_' imageId '.csv'];

%At the moment the JSON file is not indented
jsonOut = jsonencode(jsonData);
fid = fopen([saveResults.path 'CMSO_' imageId '.json'], 'w');
fprintf(fid, '%s', jsonOut);
fclose(fid);