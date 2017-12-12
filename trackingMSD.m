function [MSD, totalDistance] = trackingMSD(imageObj, track)

MSD = [];
pixels = imageObj.getPrimaryPixels;

physX = pixels.getPhysicalSizeX;
physY = pixels.getPhysicalSizeY;
physZ = pixels.getPhysicalSizeZ;

if isempty(physX)
    physX = 1;
else
    physX = physX.getValue;
end
if isempty(physY)
    physY = 1;
else
    physY = physY.getValue;
end
if isempty(physZ)
    physZ = 1;
else
    physZ = physZ.getValue;
end

%Check for z dimension in the tracking data
zDim = 1;
try
    checkZ = track.cmso_z_coord(1);
catch
    zDim = 0;
end

[numSegments, ~] = size(track);

segmentDistances = zeros(numSegments-1,1);
for thisSegment = 1:numSegments-1
    x1 = track.cmso_x_coord(thisSegment);
    x2 = track.cmso_x_coord(thisSegment+1);
    y1 = track.cmso_y_coord(thisSegment);
    y2 = track.cmso_y_coord(thisSegment+1);
    if zDim
        z1 = track.cmso_z_coord(thisSegment);
        z2 = track.cmso_z_coord(thisSegment+1);
        segmentDistances(thisSegment) = sqrt(((x1-x2)*physX)^2 + ((y1-y2)*physY)^2 + ((z1-z2)*physZ)^2);
    else
        segmentDistances(thisSegment) = sqrt(((x1-x2)*physX)^2 + ((y1-y2)*physY)^2);
    end
end
MSD = nanmean(segmentDistances);
totalDistance =nansum(segmentDistances);