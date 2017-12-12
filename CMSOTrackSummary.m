function trackSummary = CMSOTrackSummary(objectsData, linksData, imageObj)

MSD = [];
trackLength = [];
linkId = [];
totalDistance = [];
uniqueLinks = unique(linksData.cmso_link_id);
numUniqueLinks = numel(uniqueLinks);

for thisLink = 1:numUniqueLinks
    thisLinkId = uniqueLinks(thisLink);
    rows = linksData.cmso_link_id==thisLinkId;
    
    linksSubset = linksData(rows,:);
    track = innerjoin(objectsData, linksSubset);
    [thisMSD, totalDistance] = trackingMSD(imageObj, track);
    MSD = [MSD; thisMSD];
    totalDistance = [totalDistance; totalDistance];
    trackLength = [trackLength; numel(rows(rows==1))];
    linkId = [linkId; thisLinkId];
end

trackSummary = table(linkId, MSD, totalDistance, trackLength);