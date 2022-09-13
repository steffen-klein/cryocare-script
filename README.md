# CryoCare denoising for cryo-electron tomography #

This is a small colleciton of scripts which help with cryocare denoising of cryo-ET data. In short, frames will be sorted in even and odd, aligned using MotionCor2, manually reconstructed using imod, and finally denoised using cryocare:

## Credits ##


- [JugLab](https://github.com/juglab) for [cryoCARE](https://github.com/juglab/cryoCARE_pip)
- [Zheng et al](https://www.nature.com/articles/nmeth.4193) for [MotionCor2](https://emcore.ucsf.edu/ucsf-software)
- [Mastronarde and Held](https://doi.org/10.1016/j.jsb.2016.07.011) for [IMOD](https://bio3d.colorado.edu/imod/)

## Instructions ##

1. Run motioncor2.sh script to align frames and create EVN & ODD tilt series
	- Install MotionCor2 as described here: https://msg.ucsf.edu/software
	- Update the motioncor2 installation path in the script
	- Frames need to be saved as .tif files with the following naming scheme: TS_aa_bbb_cc.c.tif
		- with aa=tilt series, bbb=serialEM object and cc.c=titl angle.
	- Raw data needs to be organized in a specific way in order for the script to be functional:
		- ./01_raw_data <-- in this folder all realigned and ordered .st/mrc and .st/mrc.mdoc files are stored
		- ./01_raw_data/frames <-- in this folder all .tif files are stored
		- ./motioncor_batch.script <-- this is the correct location for this script
	- This script will generate a hidden temporary folder called .motioncor2_temp where all intermediate files are stored.
	- The final aligend files will be saved in the folder: ./02_motioncor2

2. Reconstruct tomogram
	- Manually reconstruct tomogram using etomo

3. Reconstruct even / odd tomograms
	- Copy the folder of the original reconstruction in two new folders
	- Replace the tilt series with the even / odd files
	- Reconstruct again with identical parameters.


4. Run cry-care
	- Install cry-care as described here: https://github.com/juglab/cryoCARE_pip
	- Create a new folder for cry-care
	- Copy all necessary files into the folder:
		- predict_config.json
		- train_config.json
		- train_data_config.json
		- cryocare.sh
		- The two reconstructed tomograms, they should be named EVN.mrc and ODD.mrc
	- Activate Honda environment: conda activate cryocare
	- Run the cryocare script: ./cryocare.sh
