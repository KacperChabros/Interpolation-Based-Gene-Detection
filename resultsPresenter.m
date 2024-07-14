clear
image = imread("Fish_exmaple.tif");
dataGreenBuiltIn = importdata("results/greenBuiltIn.txt");
greenBuiltInX = dataGreenBuiltIn(:, 1);
greenBuiltInY = dataGreenBuiltIn(:, 2);
numberOfFoundGreenBuiltIn = length(greenBuiltInX);

dataRedBuiltIn = importdata("results/redBuiltIn.txt");
redBuiltInX = dataRedBuiltIn(:,1);
redBuiltInY = dataRedBuiltIn(:,2);
numberOfFoundRedBuiltIn = length(redBuiltInX);

dataGreenLagrange = importdata("results/greenLagrange.txt");
greenLagrangeX = dataGreenLagrange(:,1);
greenLagrangeY = dataGreenLagrange(:,2);
numberOfFoundGreen = length(greenLagrangeX);

redGreenLagrange = importdata("results/redLagrange.txt");
redLagrangeX = redGreenLagrange(:,1);
redLagrangeY = redGreenLagrange(:,2);
numberOfFoundRed = length(redLagrangeX);

figure(1)
subplot(1,2,1)
imshow(image)
hold on
plot(greenLagrangeX, greenLagrangeY, "go", "LineWidth", 2)
plot(redLagrangeX, redLagrangeY, "ro", "LineWidth", 2)
hold off
title_string = sprintf("Genes identified using implemented Lagrange interpolation\n" + ...
    "Number of identified CEN-17 genes: %d\n" + ...
    "Number of identified HER 2 genes: %d", numberOfFoundGreen, numberOfFoundRed);
title(title_string);
legend("CEN-17", "HER 2")
set(gca, 'Position', [0.02, 0.01, 0.47, 0.98]);

subplot(1,2,2)
imshow(image)
hold on
plot(greenBuiltInX, greenBuiltInY, "go", "LineWidth", 2)
plot(redBuiltInX, redBuiltInY, "ro", "LineWidth", 2)
hold off
title_string = sprintf("Genes identified using built-in interpolation\n" + ...
    "Number of identified CEN-17 genes: %d\n" + ...
    "Number of identified HER 2 genes: %d", numberOfFoundGreenBuiltIn, numberOfFoundRedBuiltIn);
title(title_string);
legend("CEN-17", "HER 2")
set(gca, 'Position', [0.51, 0.01, 0.47, 0.98]);

figure(2)
subplot(1,2,1)
imshow(image)
hold on
plot(greenLagrangeX, greenLagrangeY, "co", "LineWidth", 2)
plot(greenBuiltInX, greenBuiltInY, "ms", "LineWidth", 2)
hold off
title('Comparison of the two methods for CEN-17 genes');
set(gca, 'Position', [0.02, 0.01, 0.47, 0.98]);
legend("Lagrange", "Built-in")

subplot(1,2,2)
imshow(image)
hold on
plot(redLagrangeX, redLagrangeY, "co", "LineWidth", 2)
plot(redBuiltInX, redBuiltInY, "ms", "LineWidth", 2)
hold off
title('Comparison of the two methods for HER 2 genes');
set(gca, 'Position', [0.51, 0.01, 0.47, 0.98]);
legend("Lagrange", "Built-in")
