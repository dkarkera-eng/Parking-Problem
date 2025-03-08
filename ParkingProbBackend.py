from PIL import Image, ExifTags

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
        return numspots