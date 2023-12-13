function outputImage = reconstructImage(kMeansResults,dataSize,originalPixels)
    dataSizes = ["Small" "Medium" "Large" "Full"];
    imageSizes = {[100 100] [257 171] [512 91] [512 217]};
    reconBounds = find(strcmp(dataSizes,dataSize));

    outputImage = zeros(imageSizes{reconBounds}(1),imageSizes{reconBounds}(2));

    for i = 1:size(kMeansResults.assignments)
        outputImage(originalPixels(1,i),originalPixels(2,i)) = kMeansResults.assignments(i);
    end


end