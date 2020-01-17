// Save an hyper stack to a folder - 28-04-2016
macro "Save Hyper Stack" {
	print("\\Clear");
	path = getDirectory("Ouput folder");
	saveHyperStack(path);
}

// Save the active hyperstack to the folder path
function saveHyperStack(path) {
	// Get the name of the stack without the extension
	name = getTitle();
	name = substring(name, 0, lastIndexOf(name, "."));
	name = name + "T";
	// Create a folder with the name of the hyper stack
	data_dir = path + name;
	File.makeDirectory(data_dir);
	setBatchMode(true);
	// Get the dimensions of the hyper stack
	getDimensions(width, height, channels, slices, frames);
	for (c = 1; c <= channels; c++) {
		// Create a folder for each channel
		channel_dir = data_dir + File.separator + name + ".ch_" +  c;		
		File.makeDirectory(channel_dir);
		for (z = 1; z <= slices; z++) {
			// create a folder for each time points			
			time_dir = channel_dir + File.separator + name + "." +  (z-1);
			File.makeDirectory(time_dir);
			 for (t = 1; t <= frames; t++){
				// save each plane of the stack	
				filename = time_dir + File.separator + name + IJ.pad((t-1), 3) + "." + (z-1);
				filename_ext = filename + ".tif";
				run("Duplicate...", "duplicate channels=" + c + " slices=" + z + " frames=" + t);				
				saveAs("Tiff", filename_ext);
				File.rename(filename_ext, filename)
				close();
			}
		}
	}
	setBatchMode(false);
}
