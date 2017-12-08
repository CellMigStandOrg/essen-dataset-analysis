function [objects, links, tracks] = readCMSOJSON(filePath, fileName)
%Read the CMSOJSON file and find the indices of the columns in Objects and
%Links csv files.

jsonTxt = fileread([filePath fileName]);
CMSOjson = jsondecode(jsonTxt);

%Find the index of 'objects' and 'links'
numRes = numel(CMSOjson.resources);

tracksTableIdx = [];

for thisRes = 1:numRes
    thisColName = CMSOjson.resources(thisRes).name;
    if contains(thisColName, 'objects')
        objectsTableIdx = thisRes;
    end
    if contains(thisColName, 'links')
        linksTableIdx = thisRes;
    end
    if contains(thisColName, 'tracks')
        tracksTableIdx = thisRes;
    end
end


%Find the column indices of the 'objects' table
numCols = numel(CMSOjson.resources(objectsTableIdx).schema.fields);

for thisCol = 1:numCols
    thisColName = CMSOjson.resources(objectsTableIdx).schema.fields{thisCol}.name;
    if contains(thisColName, 'objects')
        objects.objectIdIdx = thisCol;
    end
    if contains(thisColName, 'frame')
        objects.frameIdIdx = thisCol;
    end
    if contains(thisColName, 'x_coord')
        objects.xCoordIdx = thisCol;
    end
    if contains(thisColName, 'y_coord')
        objects.yCoordIdx = thisCol;
    end
end


%Find the column indices of the 'links' table
numCols = numel(CMSOjson.resources(linksTableIdx).schema.fields);

for thisCol = 1:numCols
    thisColName = CMSOjson.resources(linksTableIdx).schema.fields{thisCol}.name;
    if contains(thisColName, 'link')
        links.linkIdIdx = thisCol;
    end
    if contains(thisColName, 'object')
        links.objectIdIdx = thisCol;
    end
end

%Is there a tracks.csv?
if ~isempty(tracksTableIdx)
    %Find the column indices of the 'tracks' table
    numCols = numel(CMSOjson.resources(tracksTableIdx).schema.fields);
    
    for thisCol = 1:numCols
        thisColName = CMSOjson.resources(tracksTableIdx).schema.fields{thisCol}.name;
        if contains(thisColName, 'track')
            tracks.trackIdIdx = thisCol;
        end
        if contains(thisColName, 'link')
            tracks.linkIdIdx = thisCol;
        end
    end
else
    tracks = [];
end