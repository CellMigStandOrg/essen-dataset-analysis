function movieInfo = uTrackMovieInfoFromProps(props)

numT = numel(props);
movieInfo(numT,1) = struct;

for thisT = 1:numT
    numProps = numel(props{thisT});
    for thisProp = 1:numProps
        movieInfo(thisT).xCoord(thisProp,1) = props{thisT}(thisProp).Centroid(1);
        movieInfo(thisT).xCoord(thisProp,2) = 0;
        movieInfo(thisT).yCoord(thisProp,1) = props{thisT}(thisProp).Centroid(2);
        movieInfo(thisT).yCoord(thisProp,2) = 0;
        movieInfo(thisT).amp(thisProp,1) = 1;
        movieInfo(thisT).amp(thisProp,2) = 0;
    end
    
end
