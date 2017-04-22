tic; % Start timer.
clc; % Clear command window.
clearvars; % Get rid of variables from prior run of this m-file.
fprintf('Running BlobsDemo.m...\n'); % Message sent to command window.
workspace; % Make sure the workspace panel with all the variables is showing.
imtool close all;  % Close all imtool figures.
format long g;
format compact;
captionFontSize = 14;

% Check that user has the Image Processing Toolbox installed.
hasIPT = license('test', 'image_toolbox');
if ~hasIPT
	% User does not have the toolbox installed.
	message = sprintf('Sorry, but you do not seem to have the Image Processing Toolbox.\nDo you want to try to continue anyway?');
	reply = questdlg(message, 'Toolbox missing', 'Yes', 'No', 'Yes');
	if strcmpi(reply, 'No')
		% User said No, so exit.
		return;
	end
end

% Read in a standard MATLAB demo image of coins (US nickles and dimes, which are 5 cent and 10 cent coins)
baseFileName = ('F:\CBIR\sample_img\img\CorelDB\obj_dish\433044.jpg')%'coins.png';
folder = fileparts(which(baseFileName)); % Determine where demo folder is (works with all versions).
fullFileName = fullfile(folder, baseFileName);
if ~exist(fullFileName, 'file')
	% It doesn't exist in the current folder.
	% Look on the search path.
	if ~exist(baseFileName, 'file')
		% It doesn't exist on the search path either.
		% Alert user that we can't find the image.
		warningMessage = sprintf('Error: the input image file\n%s\nwas not found.\nClick OK to exit the demo.', fullFileName);
		uiwait(warndlg(warningMessage));
		fprintf(1, 'Finished running BlobsDemo.m.\n');
		return;
	end
	% Found it on the search path.  Construct the file name.
	fullFileName = baseFileName; % Note: don't prepend the folder.
end
% If we get here, we should have found the image file.
originalImage = imread(fullFileName);
% Check to make sure that it is grayscale, just in case the user substituted their own image.
[rows, columns, numberOfColorChannels] = size(originalImage);
if numberOfColorChannels > 1
	%promptMessage = sprintf('Your image file has %d color channels.\nThis demo was designed for grayscale images.\nDo you want me to convert it to grayscale for you so you can continue?', numberOfColorChannels);
	%button = questdlg(promptMessage, 'Continue', 'Convert and Continue', 'Cancel', 'Convert and Continue');
	%if strcmp(button, 'Cancel')
	%	fprintf(1, 'Finished running BlobsDemo.m.\n');
	%	return;
	%end
	% Do the conversion using standard book formula
	originalImage = rgb2gray(originalImage);
end

% Display the grayscale image.
subplot(3, 3, 1);
imshow(originalImage);
% Maximize the figure window.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% Force it to display RIGHT NOW (otherwise it might not display until it's all done, unless you've stopped at a breakpoint.)
drawnow;
%caption = sprintf('Original "coins" image showing\n6 nickels (the larger coins) and 4 dimes (the smaller coins).');
%title(caption, 'FontSize', captionFontSize);
axis image; % Make sure image is not artificially stretched because of screen's aspect ratio.

% Just for fun, let's get its histogram and display it.
[pixelCount, grayLevels] = imhist(originalImage);
subplot(3, 3, 2);
bar(pixelCount);
title('Histogram of original image', 'FontSize', captionFontSize);
xlim([0 grayLevels(end)]); % Scale x axis manually.
grid on;

% Threshold the image to get a binary image (only 0's and 1's) of class "logical."
thresholdValue = 100;
binaryImage = originalImage > thresholdValue; % Bright objects will be chosen if you use >.


% Do a "hole fill" to get rid of any background pixels or "holes" inside the blobs.
binaryImage = imfill(binaryImage, 'holes');

imshow(binaryImage); 
