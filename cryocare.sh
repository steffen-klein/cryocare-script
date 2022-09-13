#!/bin/bash

cryoCARE_extract_train_data.py --conf train_data_config.json
cryoCARE_train.py --conf train_config.json
cryoCARE_predict.py --conf predict_config.json
mrcbyte denoised.mrc denoised_8bit.mrc
