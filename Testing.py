import numpy as np
import cv2

import matplotlib.pyplot as plt

# Store filenames correctly using a list
filename = 'test_data/test_labels.txt'
imgPath = 'test_data/test_images/2012-09-20_10_09_24.jpg'

def loadData(inputDir): # use the test file to define the parking spots per image
    data = []
    numspots = {}
    with open(inputDir) as file:
        for line in file:
            data.append(line.split())
    for dat in data: # count the number of spots in each image
        if dat[0] not in numspots:
            numspots[dat[0]] = 1
        else:
            numspots[dat[0]] += 1
    labels = []
    xMin = []
    xMax = []
    yMin = []
    yMax = []
    for dat in data: # create a list of whether each parking spot is empty or occupied
        labels.append(dat[1])
        xMin.append(dat[2])
        yMin.append(dat[3])
        xMax.append(dat[4])
        yMax.append(dat[5])
    return data, labels, numspots, xMin, yMin, xMax, yMax
def plotImgSpots(imagePath, inputDir):
    data, labels, numspots, xMin, yMin, xMax, yMax = loadData(inputDir)

    fig, ax = plt.subplots()
    image_filename = imagePath # need to change this to coordinate with interface
    image_data = cv2.imread(imagePath, cv2.IMREAD_COLOR)

    # Loop through files to process and visualize parking spots
    for i in range(len(data)):
        ax.imshow(image_data)
        ax.axis('off')

        # Convert BGR image to RGB
        image_data = cv2.cvtColor(image_data, cv2.COLOR_BGR2RGB)

        # Display the image

        # Number of parking spots
        num_spots = numspots[image_filename[-23:]]

        # Loop through each parking spot
        if data[i][0] == image_filename[-23:]:
            xmin = xMin[i]
            ymin = yMin[i]
            xmax = xMax[i]
            ymax = yMax[i]
            width = float(xmax)-float(xmin)
            height = float(ymax)-float(ymin)

            # Define color: Green for empty (1), Red for occupied (2)
            if labels[i] == '1':
                color = 'g'  # Green for empty spaces
            else:
                color = 'r'  # Red for occupied spaces

            # Draw the rectangle
            ax.add_patch(plt.Rectangle((float(xmin),float(ymin)),width,height, edgecolor=color, linewidth=2, fill=False))

            # Optionally, label each space
            #ax.text(float(xmin), float(ymin) - 5, str(labels[i]), color='w', fontsize=10, fontweight='bold')

    # Title to indicate which image is being displayed
    ax.set_title(f'Parking Lot: {image_filename}')
    plt.show()

plotImgSpots(imgPath, filename)