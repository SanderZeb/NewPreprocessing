# -*- coding: utf-8 -*-
"""
Created on Mon Oct  3 14:15:34 2022

@author: user
"""

%matplotlib inline

import numpy as np
from scipy.io import loadmat, savemat
from fooof import FOOOF
from fooof import FOOOFGroup
import mat73
import os
from os import listdir
from os.path import isfile, join
import re





#data_dict = mat73.loadmat(r'D:\Drive\1 - Threshold\pwelch\pwelch_participant_1.mat')
freqs_dict = loadmat(r'D:\freqs.mat')

mypath = r'D:\Drive\1 - Threshold\pwelch'
onlyfiles = [f for f in listdir(mypath) if isfile(join(mypath, f))]

savepath = r'C:\Users\user\Desktop\Nowy folder'    
participants_path = os.path.join(savepath, 'participants')
try:
    os.mkdir(participants_path)
except FileExistsError:
    pass       

for file in onlyfiles:
    filepath = os.path.join(mypath, file)
    data_dict = mat73.loadmat(f'{filepath}')    
    participant = re.findall(r'\d+', file)
    os.chdir(participants_path)    
    
    psds = np.squeeze(data_dict['data_psds']).astype('float')
    freqs = np.squeeze(freqs_dict['freqs']).astype('float')
    channs = psds.shape[0]
    trials = psds.shape[1]
    
    temp_path = os.path.join(participants_path, participant[0])
    try:
        os.mkdir(temp_path)
    except FileExistsError:
        pass 
    os.chdir(temp_path)
    for channel in range(channs):
        for trial in range(trials):
            print(f'currently running for channel {channel} and trial {trial}')
            current_psds = psds[channel, trial, :]
            fm = FOOOF();
            fm.report(freqs, current_psds.T, [1, 30]);
            fooof_results = fm.get_results()
            fooof_results_dict = fooof_results._asdict()
            savemat(f'{file}_chann_{channel}_trial_{trial}.mat', fooof_results_dict)
