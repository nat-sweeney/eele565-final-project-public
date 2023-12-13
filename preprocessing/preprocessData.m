% Loading in data (Salinas A datacube and ground truths)
load("../data/Salinas_corrected.mat");
load("../data/Salinas_gt.mat");

% Ranges for Data Partition [rowMin rowMax colMin colMax]
smallRange = [271 370 1 100];
mediumRange = [256 512 1 170];
largeRange = [1 512 1 90];

% Removing unlabeled data from datacube
keepCube = zeros(size(salinas_corrected,1),size(salinas_corrected,2),size(salinas_corrected,3));
for i = 1:size(keepCube,1)
    for j = 1:size(keepCube,2)
        if(salinas_gt(i,j) > 0)
            keepCube(i,j,:) = salinas_corrected(i,j,:);
        end
    end
end

% Reshaping the datacube samples into a matrix for the K means algorithm to
% run through. This also creates a label set and spatial location set
vectorSet = cell(1,5348);
labelSet = cell(1,5348);
spatialSet = cell(1,5348);
index = 1;
for i = 1:size(keepCube,1)
    for j = 1:size(keepCube,2)
        if(salinas_gt(i,j) > 0)
            vector = reshape(keepCube(i,j,:),1,204);
            vectorSet{index} = vector;
            labelSet{index} = salinas_gt(i,j);
            spatialSet{index} = [i,j];
            index = index + 1;
        end
    end
end

% Calculating number of labeled samples
sampleLocations = find(salinas_gt);
samples = length(sampleLocations);

% Reconverting back into matrix
salinasData = cell2mat(vectorSet);
salinasData = reshape(salinasData,204,length(find(salinas_gt)));

salinasLabels = cell2mat(labelSet);

salinasPixels = cell2mat(spatialSet);
salinasPixels = reshape(salinasPixels,2,length(find(salinas_gt)));

% Shuffling small dataset
[~,randIndeces] = sort(randn(1,samples));
salinasData_s = [salinasData(:,randIndeces(1:end))];
salinasLabels_s = [salinasLabels(:,randIndeces(1:end))];
salinasPixels_s = [salinasPixels(:,randIndeces(1:end))];

% Saving data
save("../data/salinasData.mat","salinasData_s");
save("../data/salinasLabels.mat","salinasLabels_s");
save("../data/salinasPixels.mat","salinasPixels_s");

%% Creating small dataset (6 Clusters)
% Grabbing section of datacube based on ranges set at the top.
keepCubeSmall = keepCube(smallRange(1):smallRange(2),smallRange(3):smallRange(4),:);
salinas_gtSmall = salinas_gt(smallRange(1):smallRange(2),smallRange(3):smallRange(4));

% Calculating number of labeled samples
smallSampleLocations = find(salinas_gt(smallRange(1):smallRange(2),smallRange(3):smallRange(4)));
smallSamples = length(smallSampleLocations);

% Creating vectors
vectorSetSmall = cell(1,smallSamples);
labelSetSmall = cell(1,smallSamples);
spatialSetSmall = cell(1,smallSamples);
index = 1;
for i = 1:size(keepCubeSmall,1)
    for j = 1:size(keepCubeSmall,2)
        if(salinas_gtSmall(i,j) > 0)
            vector = reshape(keepCubeSmall(i,j,:),1,204);
            vectorSetSmall{index} = vector;
            labelSetSmall{index} = salinas_gtSmall(i,j);
            spatialSetSmall{index} = [i,j];
            index = index + 1;
        end
    end
end

% Converting cell to matrix
salinasSmall = cell2mat(vectorSetSmall);
salinasSmall = reshape(salinasSmall,204,smallSamples);

salinasLabelsSmall = cell2mat(labelSetSmall);

salinasPixelsSmall = cell2mat(spatialSetSmall);
salinasPixelsSmall = reshape(salinasPixelsSmall,2,smallSamples);

% Shuffling small dataset
[~,randIndecesSmall] = sort(randn(1,smallSamples));
salinasDataSmall_s = [salinasSmall(:,randIndecesSmall(1:end))];
salinasLabelsSmall_s = [salinasLabelsSmall(:,randIndecesSmall(1:end))];
salinasPixelsSmall_s = [salinasPixelsSmall(:,randIndecesSmall(1:end))];

% Saving data
save("../data/salinasDataSmall.mat","salinasDataSmall_s");
save("../data/salinasLabelsSmall.mat","salinasLabelsSmall_s");
save("../data/salinasPixelsSmall.mat","salinasPixelsSmall_s");

%% Creating medium dataset (8 Clusters)
keepCubeMedium = keepCube(mediumRange(1):mediumRange(2),mediumRange(3):mediumRange(4),:);
salinas_gtMedium = salinas_gt(mediumRange(1):mediumRange(2),mediumRange(3):mediumRange(4));

% Calculating number of labeled samples
mediumSampleLocations = find(salinas_gt(mediumRange(1):mediumRange(2),mediumRange(3):mediumRange(4)));
mediumSamples = length(mediumSampleLocations);

% Creating vectors
vectorSetMedium = cell(1,mediumSamples);
labelSetMedium = cell(1,mediumSamples);
spatialSetMedium = cell(1,mediumSamples);
index = 1;
for i = 1:size(keepCubeMedium,1)
    for j = 1:size(keepCubeMedium,2)
        if(salinas_gtMedium(i,j) > 0)
            vector = reshape(keepCubeMedium(i,j,:),1,204);
            vectorSetMedium{index} = vector;
            labelSetMedium{index} = salinas_gtMedium(i,j);
            spatialSetMedium{index} = [i,j];
            index = index + 1;
        end
    end
end

% Converting cell to matrix
salinasMedium = cell2mat(vectorSetMedium);
salinasMedium = reshape(salinasMedium,204,mediumSamples);

salinasLabelsMedium = cell2mat(labelSetMedium);

salinasPixelsMedium = cell2mat(spatialSetMedium);
salinasPixelsMedium = reshape(salinasPixelsMedium,2,mediumSamples);

% Shuffling medium dataset
[~,randIndecesMedium] = sort(randn(1,mediumSamples));
salinasDataMedium_s = [salinasMedium(:,randIndecesMedium(1:end))];
salinasLabelsMedium_s = [salinasLabelsMedium(:,randIndecesMedium(1:end))];
salinasPixelsMedium_s = [salinasPixelsMedium(:,randIndecesMedium(1:end))];

% Saving data
save("../data/salinasDataMedium.mat","salinasDataMedium_s");
save("../data/salinasLabelsMedium.mat","salinasLabelsMedium_s");
save("../data/salinasPixelsMedium.mat","salinasPixelsMedium_s");

%% Creating large dataset (13 Clusters)
keepCubeLarge = keepCube(largeRange(1):largeRange(2),largeRange(3):largeRange(4),:);
salinas_gtLarge = salinas_gt(largeRange(1):largeRange(2),largeRange(3):largeRange(4));

% Calculating number of labeled samples
largeSampleLocations = find(salinas_gt(largeRange(1):largeRange(2),largeRange(3):largeRange(4)));
largeSamples = length(largeSampleLocations);

% Creating vectors
vectorSetLarge = cell(1,largeSamples);
labelSetLarge = cell(1,largeSamples);
spatialSetLarge = cell(1,largeSamples);
index = 1;
for i = 1:size(keepCubeLarge,1)
    for j = 1:size(keepCubeLarge,2)
        if(salinas_gtLarge(i,j) > 0)
            vector = reshape(keepCubeLarge(i,j,:),1,204);
            vectorSetLarge{index} = vector;
            labelSetLarge{index} = salinas_gtLarge(i,j);
            spatialSetLarge{index} = [i,j];
            index = index + 1;
        end
    end
end

% Converting cell to matrix
salinasLarge = cell2mat(vectorSetLarge);
salinasLarge = reshape(salinasLarge,204,largeSamples);

salinasLabelsLarge = cell2mat(labelSetLarge);

salinasPixelsLarge = cell2mat(spatialSetLarge);
salinasPixelsLarge = reshape(salinasPixelsLarge,2,largeSamples);

% Shuffling large dataset
[~,randIndecesLarge] = sort(randn(1,largeSamples));
salinasDataLarge_s = [salinasLarge(:,randIndecesLarge(1:end))];
salinasLabelsLarge_s = [salinasLabelsLarge(:,randIndecesLarge(1:end))];
salinasPixelsLarge_s = [salinasPixelsLarge(:,randIndecesLarge(1:end))];

% Saving data
save("../data/salinasDataLarge.mat","salinasDataLarge_s");
save("../data/salinasLabelsLarge.mat","salinasLabelsLarge_s");
save("../data/salinasPixelsLarge.mat","salinasPixelsLarge_s");