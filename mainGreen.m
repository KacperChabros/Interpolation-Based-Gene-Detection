clear
windowSize = 30;
numberOfPoints = 21;
numberOfFunctions = 3;
stepSize = 1;
distanceThresh = 15;

diffThreshStrict = 0.30;
diffThresh = 0.40;
diffLBThresh = 0.20;
redThresh = 0.78;
redThreshStrict = 0.6;
redThreshLB = 0.41;
redThreshSum = 0.72;
sumRedMatchThresh = 0.78;

image = imread("Fish_exmaple.tif");
imgNum = im2double(image);
imgRed = imgNum(:,:,1)';
imgGreen = imgNum(:,:,2)';
width = size(imgGreen, 1);
height = size(imgGreen, 2);

greenPointMid = [564, 403];
greenPointLessBrightMid = [105, 1076];

[expectedValues, expectedValuesBuiltIn] = calculateExpectedValues(greenPointMid, imgGreen, ...
    windowSize, numberOfPoints, numberOfFunctions);
[expectedValuesLB, expectedValuesBuiltInLB] = calculateExpectedValues(greenPointLessBrightMid, ...
    imgGreen, windowSize, numberOfPoints, numberOfFunctions);

foundXs = [];
foundYs = [];
foundBuiltInXs = [];
foundBuiltInYs = [];

for i=1:stepSize:height
    for j=1:stepSize:width
        if(j+windowSize > width)
             continue
        end 
        bestError = inf;
        bestHeight = 0;
        bestErrorBuiltIn = inf;
        bestHeightBuiltIn = 0;
        rangeXs = j:j+windowSize-1;

        for k = 0:windowSize-1
            if(i+k > height)
                break
            end
            actualValues = imgGreen(rangeXs, i+k)';
            
            diff = abs(expectedValues - actualValues);
            diffLB = abs(expectedValuesLB - actualValues);

            diffBuiltIn = abs(expectedValuesBuiltIn - actualValues);
            diffBuiltInLB = abs(expectedValuesBuiltInLB - actualValues);
            
            percBelow = percentBelowLevel(imgRed, rangeXs,i+k, redThreshSum); 
            if( ( all(diff < diffThreshStrict) && all(imgRed(rangeXs, i+k) < redThresh) && percBelow > sumRedMatchThresh) ...
                    || (all(diff < diffThresh) && all(imgRed(rangeXs, i+k) < redThreshStrict)) ...
                    || ( all(diffLB < diffLBThresh) && all(imgRed(rangeXs, i+k) < redThreshLB) )  )
                
                difference = min(sum(diff), sum(diffLB));
                if( difference < bestError)
                    bestError = difference;
                    bestHeight = i+k;
                end
            end

            if( ( all(diffBuiltIn < diffThreshStrict) && all(imgRed(rangeXs, i+k) < redThresh) && percBelow > sumRedMatchThresh) ...
                    || (all(diffBuiltIn < diffThresh) && all(imgRed(rangeXs, i+k) < redThreshStrict)) ...
                    || ( all(diffBuiltInLB < diffLBThresh) && all(imgRed(rangeXs, i+k) < redThreshLB) )  )

                difference = min(sum(diffBuiltIn), sum(diffBuiltInLB));
                if( difference < bestErrorBuiltIn)
                    bestErrorBuiltIn = difference;
                    bestHeightBuiltIn = i+k;
                end
            end
        end

        if(bestHeight > 0)
            foundXs(end+1) = int16(j+windowSize/2);
            foundYs(end+1) = bestHeight;
        end

        if(bestHeightBuiltIn > 0)
            foundBuiltInXs(end+1) = int16(j+windowSize/2);
            foundBuiltInYs(end+1) = bestHeightBuiltIn;
        end
    end
end

[finalXs, finalYs] = removeRepeatedPoints(foundXs, foundYs, distanceThresh);
[finalBuiltInXs, finalBuiltInYs] = removeRepeatedPoints(foundBuiltInXs, foundBuiltInYs, distanceThresh);

length(finalXs)
length(finalBuiltInXs)
imshow(image)
hold on
plot(finalXs, finalYs, "go", "LineWidth",2);
plot(finalBuiltInXs, finalBuiltInYs, "ms", "LineWidth",2);
hold off
saveResults("results/greenLagrange.txt", finalXs, finalYs);
saveResults("results/greenBuiltIn.txt", finalBuiltInXs, finalBuiltInYs);
