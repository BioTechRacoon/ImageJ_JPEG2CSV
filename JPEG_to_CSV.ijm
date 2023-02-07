// Macro to convert random JPEG images to CSV

// User interface
Dialog.create("Settings:");
Dialog.addString("Extension", "png");
Dialog.addNumber("Start X", 110);
Dialog.addNumber("Start Y", 238);
Dialog.addNumber("End X", 834);
Dialog.addNumber("End Y", 622);
Dialog.addNumber("Circularity Tolerance", 0.90);

Dialog.show();

// Define variables
extension = Dialog.getString();
X1 = Dialog.getNumber();
Y1 = Dialog.getNumber();
X2 = Dialog.getNumber();
Y2 = Dialog.getNumber();
tolerance = Dialog.getNumber();

// Ask for the folder with the images to be analyzed
dir = getDirectory("Please indicate the folder containing your "+extension+" files");


// Find all images
list = getFileList(dir);


// Run the process on all images
for (i = 0; i < list.length; i++) {
// Only consider .png
if (endsWith(list[i], "."+extension)) {
// Call the function
process(dir, list[i]);
}
}

// Processing starts here
function process(dir, file) {
run("Open...", "path=["+dir+file+"]");
ImageGraph = getTitle();

run("8-bit");
run("Convert to Mask");
makeRectangle(X1, Y1, X2, Y2);
run("Crop");

setAutoThreshold("Default");
setThreshold(129, 255);

run("Convert to Mask");

// Set measurements: only pick center of mass to get X/Y coordinates
run("Set Measurements...", "center redirect=None decimal=3");
run("Analyze Particles...", "circularity='" + tolerance + "-1.00 display overlay add composite'");

selectWindow("ROI Manager");
run("Select All");

roiManager("Measure");
}
