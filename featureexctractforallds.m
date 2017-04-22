allSubFolders = genpath('F:\BTP\dataset');
remain = allSubFolders;
listOfFolderNames = {};
ii=1;
while true
	[singleSubFolder, remain] = strtok(remain, ';');
	if isempty(singleSubFolder)
		break;
	end
	listOfFolderNames = [listOfFolderNames singleSubFolder];
end
numberOfFolders = length(listOfFolderNames)
for k = 1 : numberOfFolders
	thisFolder = listOfFolderNames{k};
	fprintf('Processing folder %s\n', thisFolder);
	filePattern = sprintf('%s/*.png', thisFolder);
	baseFileNames = dir(filePattern);
	filePattern = sprintf('%s/*.tif', thisFolder);
	baseFileNames = [baseFileNames; dir(filePattern)];
	filePattern = sprintf('%s/*.jpg', thisFolder);
	baseFileNames = [baseFileNames; dir(filePattern)];
	numberOfImageFiles = length(baseFileNames);
	if numberOfImageFiles >= 1
		for f = 1 : numberOfImageFiles
			fullFileName = fullfile(thisFolder, baseFileNames(f).name);
			%fprintf('     Processing image file %s\n', fullFileName);
			img = imread(fullFileName);
            %grayimage = rgb2gray(theImage);
            %lbpimagefeatured(ii,:) = extractLBPFeatures(grayimage);
            %target(ii,k-1) = 1;
            %ii=ii+1;
            % I = imread('cameraman.tif');
           featureVector = encode(bag, img);
           lbpimagefeatured(ii,:) = featureVector;
           target(ii,k-1) = 1;
           ii=ii+1;
           
		end
	end
end
csvwrite('inputfile.dat',lbpimagefeatured)
csvwrite('targetfile.dat',target)