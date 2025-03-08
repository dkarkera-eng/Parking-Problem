% Store filenames correctly using a cell array
filename = {'2012-09-11_15_36_32.txt', ...
            '2012-09-15_06_01_59.txt', ...
            '2012-09-20_10_09_24.txt', ...
            '2012-11-08_13_15_44.txt', ...
            '2012-12-12_17_40_14.txt', ...
            '2012-12-13_20_30_17.txt',...
            '2013-01-16_18_40_15.txt',...
            '2013-03-16_08_55_03.txt',...
            '2013-04-12_17_50_13.txt',...
            '2013-03-16_08_55_03.txt'};

% Define column indices
VacancyLabel = 1;
Xmin = 2;
Ymin = 3;
Xmax = 4;
Ymax = 5;

% Preallocate storage (assuming each file has the same number of rows)
numFiles = length(filename);
A = cell(numFiles, 1);
B = cell(numFiles, 1);
C = cell(numFiles, 1);
D = cell(numFiles, 1);
E = cell(numFiles, 1);

% Loop through files
for i = 1:numFiles
    data = readmatrix(filename{i}); % Use filename{i} to get string
    
    % Store entire column as a vector in cell array
    % A stores a integer value that represents whether a parking spot is
    % available or taken '1' represents an empty space and '2' represents
    % an occupied space
    % B stores a location in pixels of the x coordinate minimum
    % C stores the location in pixels of the x coordinate maximum
    % D stores a location in pixels of the y coordinate minimum
    % E stores the location in pixels of the y coordinate maximum
    A{i} = data(:, VacancyLabel);
    B{i} = data(:, Xmin);
    C{i} = data(:, Ymin);
    D{i} = data(:, Xmax);
    E{i} = data(:, Ymax);
end

numFiles = length(A); % Number of files

% Preallocate storage for first elements
elementsA = zeros(numFiles, 1);
elementsB = zeros(numFiles, 1);
elementsC = zeros(numFiles, 1);
elementsD = zeros(numFiles, 1);
elementsE = zeros(numFiles, 1);

% Loop through each file and store each element in its respective variable
for i = 1:numFiles
    elements = length(A{i});
    for j = 1:elements
    elementsA(i,j) = A{i}(j); 
    elementsB(i,j) = B{i}(j); 
    elementsC(i,j) = C{i}(j); 
    elementsD(i,j) = D{i}(j); 
    elementsE(i,j) = E{i}(j); 
    end
end
% Loop through files to process and visualize parking spots
for i = 1:numFiles
    % Load corresponding image
    imageFilename = strrep(filename{i}, '.txt', '.jpg'); % Assuming image file follows text file naming
    imageData = imread(imageFilename);
    
    % Display the image
    figure;
    imshow(imageData);
    hold on;

    % Number of parking spots
    numSpots = length(A{i});

    % Loop through each parking spot
    for j = 1:numSpots
        xmin = B{i}(j);
        ymin = C{i}(j);
        xmax = D{i}(j);
        ymax = E{i}(j);
        width = xmax - xmin;
        height = ymax - ymin;

        % Define color: Green for empty (1), Red for occupied (2)
        if A{i}(j) == 1
            color = 'g'; % Green for empty spaces
        else
            color = 'r'; % Red for occupied spaces
        end

      % Define the four corners using two points (top-left and bottom-right)
top_left = [xmin, ymin];
top_right = [xmax, ymin];
bottom_right = [xmax, ymax];
bottom_left = [xmin, ymax];

% Draw the rectangle using plot by connecting the four corners correctly
plot([top_left(1), top_right(1), bottom_right(1), bottom_left(1), top_left(1)], ...
     [top_left(2), top_right(2), bottom_right(2), bottom_left(2), top_left(2)], ...
     'Color', color, 'LineWidth', 2);

        
        % Optionally, label each space
        text(xmin, ymin - 5, num2str(A{i}(j)), 'Color', 'w', 'FontSize', 10, 'FontWeight', 'bold');
    end

    % Title to indicate which image is being displayed
    title(['Parking Lot: ', imageFilename]);
    hold off;
end
