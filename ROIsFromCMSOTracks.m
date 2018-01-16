function ROIsFromCMSOTracks(session, imageId, objectsData, linksData)

iUpdate = session.getUpdateService();
imageObj = getImages(session, imageId);
trackSummary = CMSOTrackSummary(objectsData, linksData, imageObj);

numTracks = height(trackSummary);

for thisTrack = 1:numTracks
   trackLength = trackSummary.trackLength(thisTrack);
   if trackLength < 5
       continue;
   end
   roi = omero.model.RoiI;
   TVec = [];
   xCoords = [];
   yCoords = [];
   theseCMSOobjs = linksData.cmso_object_id(linksData.cmso_link_id==thisTrack);
   numObj = numel(theseCMSOobjs);
   for objCounter = 1:numObj
       thisObj = theseCMSOobjs(objCounter);
       %nextObj = theseCMSOobjs(objCounter+1);
       TVec = [TVec objectsData.cmso_frame_id(objectsData.cmso_object_id==thisObj)];
       xCoords = [xCoords round(objectsData.cmso_x_coord(objectsData.cmso_object_id==thisObj))];
       %xCoord2 = round(objectsData.cmso_x_coord(objectsData.cmso_object_id==nextObj));
       yCoords = [yCoords round(objectsData.cmso_y_coord(objectsData.cmso_object_id==thisObj))];
       %yCoord2 = round(objectsData.cmso_y_coord(objectsData.cmso_object_id==nextObj));
       if sum(ismember(objectsData.Properties.VariableNames, 'cmso_z_coord'))
           zCoord = round(objectsData.cmso_z_coord(objectsData.cmso_object_id==thisObj));
       else
           zCoord = 1;
       end
   end
   for objCounter = 1:numObj
       pLine = createPolyline(xCoords, yCoords);
       
       % Indicate on which plane to attach the shape
       setShapeCoordinates(pLine, zCoord-1, 0, TVec(objCounter)-1);
       
       % Attach the shapes to the roi, several shapes can be added.
       roi.addShape(pLine);
   end
   
   roi.setImage(omero.model.ImageI(imageId, false));
   roi = iUpdate.saveAndReturnObject(roi);
   
end