img1 = imread(fullfile('F:\','BTP','dataset1','50_class_performance.fig'));
%[labelIdx, scores] = predict(categoryClassifier, img1);

% Display the string label
%categoryClassifier.Labels(labelIdx)
%t1 = encode(bag, img1);
%test1= transpose(t1);
input_img = rgb2gray(img1);
test2 = extractLBPFeatures(input_img);
test1 = test2';
result1 = net(test1);
yind1 = 1+ vec2ind(result1);

[~, Label] = max(result1);
Label = Label';
Label(Label == 10) = 0;  
%ImageId = 1:n; ImageId = ImageId'; 
%writetable(table(ImageId, Label), 'submission.csv')
%testInd = tr.result1;


allSubFolders1 = genpath('F:\BTP\dataset1');
remain1 = allSubFolders1;
listOfFolderNames1 = {};
ii=1;
while true
	[singleSubFolder1, remain1] = strtok(remain1, ';');
	if isempty(singleSubFolder1)
		break;
	end
	listOfFolderNames1 = [listOfFolderNames1 singleSubFolder1];
end
numberOfFolders1 = length(listOfFolderNames1)
for k = 1 : Label
	thisFolder1 = listOfFolderNames1{yind1};
    
    fprintf('Processing folder %s\n', thisFolder1);
	filePattern1 = sprintf('%s/*.png', thisFolder1);
	baseFileNames1 = dir(filePattern1);
	filePattern1 = sprintf('%s/*.tif', thisFolder1);
	baseFileNames1 = [baseFileNames1; dir(filePattern1)];
	filePattern1 = sprintf('%s/*.jpg', thisFolder1);
	baseFileNames1 = [baseFileNames1; dir(filePattern1)];
	numberOfImageFiles1 = length(baseFileNames1);
    if k ==1
	 if numberOfImageFiles1 >= 1
		for f = 1 : 9
			fullFileName1 = fullfile(thisFolder1, baseFileNames1(f).name);
			fprintf('     Processing image file %s\n', fullFileName);
			img1 = imread(fullFileName1);
            subplot(3, 3, f);
            imshow(img1);

        end
     end
    end
end

