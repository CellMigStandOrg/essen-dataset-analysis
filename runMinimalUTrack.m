clear 
nPoints = 20;
sizeT = 20;

% Create an initial set of points, velocity and directions
x0 = 100 + (20)*rand(nPoints,1);
y0 = 100 + (20)*rand(nPoints,1);
v = 5 * rand(nPoints,1) ;
theta = 2*pi *rand(nPoints,1);

% Store the detection in the u-track format
movieInfo(sizeT, 1) = struct();
for t = 1 : sizeT
    % For each timepoint, the structure should contain at least three fields:
    % xCoord, yCoord and amp.
    % Each of these fields is a nPoints x 2 matrix where the first column is
    % the value and the second column is the uncertainty
    movieInfo(t).xCoord(:,1) = x0 + v .* cos(theta) * t + rand(nPoints,1);
    movieInfo(t).xCoord(:,2) = 0;
    movieInfo(t).yCoord(:,1) = y0 + v .* sin(theta) * t + rand(nPoints,1);
    movieInfo(t).yCoord(:,2) = 0;
    movieInfo(t).amp(:,1) = ones(size(x0));
    movieInfo(t).amp(:,2) = 0;
end

% Execute the tracking script
scriptTrackGeneral