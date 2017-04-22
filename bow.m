%F:\BTP\sample_img\CorelDB
%setDir  = fullfile(toolboxdir('vision'),'visiondata','imageSets');
setDir = fullfile('F:\','BTP','dataset');
imds = imageDatastore(setDir,'IncludeSubfolders',true,'LabelSource',...
    'foldernames');
[trainingSet,testSet] = splitEachLabel(imds,0.3,'randomize');
bag = bagOfFeatures(trainingSet);

categoryClassifier = trainImageCategoryClassifier(trainingSet,bag);

confMatrix = evaluate(categoryClassifier,testSet)

mean(diag(confMatrix))

img = imread(fullfile(setDir,'obj_dish','433044.jpg'));
img = imread(fullfile(setDir,'obj_dish','433044.jpg'));

categoryClassifier.Labels(labelIdx)