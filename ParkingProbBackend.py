from PIL import Image, ExifTags
import cv2
import test_data

def extractExifData(imagePath):
    image = Image.open(imagePath)
    exifData = image._getexif()
    if exifData is not None:
        exif = {
            ExifTags.TAGS.get(tag,tag): value
            for tag, value in exifData.items()
            if tag in ExifTags.TAGS
        }
        return exif
    else: # should add other method to get exif data
        return {}
    

def IdentFreeParkingSpots(imagePath):
    inputImage = cv2.imread(imagePath)
    numFreeSpots = 0
    return numFreeSpots
    
    # crop the given image into each individual parking spot
def cropImage(image, xMin, yMin, xMax, yMax): 
    cropped = image[yMin:yMax, xMin:xMax]
    croppedImage = cv2.resize(cropped, (15, 15))
    return croppedImage

EMPTY = 1
OCCUPIED = 2
categories = [EMPTY, OCCUPIED]
inputDir = test_data


def loadData(inputDir): # use the test file to define the parking spots per image
    data = []
    numspots = {}
    with open('test_data/test_labels.txt') as file:
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

data,labels,numspots,xMin,yMin,xMax,yMax = loadData(inputDir)

def extractImgFeats(imagePath, xMin, yMin, xMax, yMax, data):
    image = cv2.imread(imagePath,cv2.IMREAD_GRAYSCALE)
    i = 0
    for xMin, yMin, xMax, yMax ,i in zip(xMin, yMin, xMax, yMax):
        if imagePath == data[0]:
            croppedImage = cropImage(image, xMin(i), yMin(i), xMax(i), yMax)
            flattenedImage = croppedImage.flatten()
        i += 1
    
    return 

svm = cv2.ml.SVM_create()