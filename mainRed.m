clear
windowSize = 15;
numberOfPoints = 21;
numberOfFunctions = 3;
stepSize = 1;
distanceThresh = 15;

diffThresh = 0.27;
diffThreshLB = 0.25;
greenThresh = 0.70;
greenThreshLB = 0.40;
greenThreshSum = 0.56;
sumGreenMatchThresh = 0.74;

image = imread("Fish_exmaple.tif");
imgNum = im2double(image);
imgRed = imgNum(:,:,1)';
imgGreen = imgNum(:,:,2)';
width = size(imgRed, 1);
height = size(imgRed, 2);

redPointMid = [1542,311];
redPointLessBrightMid = [754,959];

[expectedValues, expectedValuesBuiltIn] = calculateExpectedValues(redPointMid, imgRed, ...
    windowSize, numberOfPoints, numberOfFunctions);
[expectedValuesLB, expectedValuesBuiltInLB] = calculateExpectedValues(redPointLessBrightMid, ...
    imgRed, windowSize, numberOfPoints, numberOfFunctions);
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
            actualValues = imgRed(rangeXs, i+k)';
            
            diff = abs(expectedValues - actualValues);
            diffLB = abs(expectedValuesLB - actualValues);

            diffBuiltIn = abs(expectedValuesBuiltIn - actualValues);
            diffBuiltInLB = abs(expectedValuesBuiltInLB - actualValues);
            
            percBelow = percentBelowLevel(imgGreen, rangeXs,i+k, greenThreshSum); 
            if( ( all(diff < diffThresh) && all(imgGreen(rangeXs, i+k) < greenThresh) && percBelow > sumGreenMatchThresh) ...
                    || ( all(diffLB < diffThreshLB) && all(imgGreen(rangeXs, i+k) < greenThreshLB) )  )
                
                difference = min(sum(diff), sum(diffLB));
                if( difference < bestError)
                    bestError = difference;
                    bestHeight = i+k;
                end
            end

            if( ( all(diffBuiltIn < diffThresh) && all(imgGreen(rangeXs, i+k) < greenThresh) && percBelow > sumGreenMatchThresh) ...
                    || ( all(diffBuiltInLB < diffThreshLB) && all(imgGreen(rangeXs, i+k) < greenThreshLB) )  )

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
plot(finalXs, finalYs, "ro", "LineWidth",2);
plot(finalBuiltInXs, finalBuiltInYs, "cs", "LineWidth",2);
hold off
saveResults("results/redLagrange.txt", finalXs, finalYs);
saveResults("results/redBuiltIn.txt", finalBuiltInXs, finalBuiltInYs);
