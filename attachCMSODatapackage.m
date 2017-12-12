function attachCMSODatapackage(session, imageId, saveResults)

namespace = 'CMSO_datapackage';
fa = writeFileAnnotation(session, [saveResults.dir 'cmso_tracks_' num2str(imageId) '.zip'], 'namespace', namespace);

link = linkAnnotation(session, fa, 'image', imageId);