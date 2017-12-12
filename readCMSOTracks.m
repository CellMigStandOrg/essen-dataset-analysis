function [objectsData, linksData, tracksData] = readCMSOTracks(filepath, objects, links, tracks)

objectsData = readtable([filepath, objects.fileName]);
linksData = readtable([filepath, links.fileName]);
if ~isempty(tracks)
    tracksData = readtable([filepath, tracks.fileName]);
end