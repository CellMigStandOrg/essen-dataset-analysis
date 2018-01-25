function mask = multimotPhaseMasking(plane, do45, varLen, doContour)

plane = double(plane);
[sy, sx] = size(plane);
xDiff = sx-sy;
planeSq1 = plane(:,1:sy);
planeSq2 = plane(:,sx-sy+1:end);
planeSq3 = imrotate(planeSq1,90);
planeSq4 = imrotate(planeSq2,90);
planeVar1 = movvar(plane',varLen)';
planeVar2 = movvar(plane,varLen);
planeVarD1 = zeros(sy,sy);
planeVarD2 = zeros(sy,sy);
planeVarD3 = zeros(sy,sy);
planeVarD4 = zeros(sy,sy);
indMat = 1:numel(planeVarD1);
indMat = reshape(indMat, size(planeVarD1));
if do45 == 1
    for thisD = -sy+1:sy-1
        d1 = diag(planeSq1, thisD);
        d2 = diag(planeSq2, thisD);
        idx = diag(indMat, thisD);
        dVar1 = movvar(d1, varLen);
        dVar2 = movvar(d2, varLen);
        planeVarD1(idx) = dVar1;
        planeVarD2(idx) = dVar2;
    end
    planeVar3 = [planeVarD1, planeVarD2(:,end-xDiff+1:end)];
    for thisD = -sy+1:sy-1
        d1 = diag(planeSq3, thisD);
        d2 = diag(planeSq4, thisD);
        idx = diag(indMat, thisD);
        dVar1 = movvar(d1, varLen);
        dVar2 = movvar(d2, varLen);
        planeVarD3(idx) = dVar1;
        planeVarD4(idx) = dVar2;
    end
    planeVar4 = [planeVarD4; planeVarD3(end-xDiff+1:end,:)];
    planeVar4 = imrotate(planeVar4,-90);
    
    planeVar = planeVar1 + planeVar2 + planeVar3 + planeVar4;
else
    planeVar = planeVar1 + planeVar2;
end

if doContour
    [~, contourObj] = contour(planeVar, 10);
    drawnow;
    minContourLine = contourObj.LevelList(1);
    
    mask = zeros(size(plane));
    mask(planeVar > minContourLine) = 1;
    mask = imfill(mask, 'holes');
    mask = logical(mask);
else
    se = strel('diamond', 3);
    planeVarEdge = edge(planeVar);
    planeVarEdgeClose = imclose(planeVarEdge, se);
    planeVarEdgeCloseFill = imfill(planeVarEdgeClose, 'holes');
    mask = planeVarEdgeCloseFill;
end
