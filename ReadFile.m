% Store filenames correctly using a cell array
filename = {'2012-09-11_15_36_32.txt', ...
            '2012-09-15_06_01_59.txt', ...
            '2012-09-20_10_09_24.txt', ...
            '2012-11-08_13_15_44.txt', ...
            '2012-12-12_17_40_14.txt'};

% Define column indices
VacancyLabel = 1;
Xmin = 2;
Xmax = 3;
Ymin = 4;
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
    A{i} = data(:, VacancyLabel);
    B{i} = data(:, Xmin);
    C{i} = data(:, Xmax);
    D{i} = data(:, Ymin);
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





