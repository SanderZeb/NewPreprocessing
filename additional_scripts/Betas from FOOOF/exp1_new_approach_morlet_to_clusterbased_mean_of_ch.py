import numpy as np
from scipy.io import loadmat, savemat
from fooof import FOOOF
import h5py

# Set parameters
selected_channels = [18, 31, 55, 19, 56, 30, 26, 28, 63, 24, 61, 25, 62]
participants_to_drop = [6, 26, 41, 42, 84, 113, 121, 122]
peaks = 5
lower_freqs = 6
upper_freqs = 40
min_peak_height = 0.0
peak_threshold= 2.0
aperiodic_mode = 'fixed'
threshold_to_drop = 0.1
peak_width_limits = (2.0, 7.0)

# Load frequencies
freqs_dict = loadmat(r'D:\freqs_morlet.mat') 
freqs = np.squeeze(freqs_dict['freqs']).astype('float')

# Loop over participants
for participant in range(1,129):
    if participant not in participants_to_drop:
        continue
    
    print(f'current participant {participant}')
    # Initialize data array for selected channels
    data_selected_channels = []
    
    # Load data for selected channels and compute average
    for channel in selected_channels:
        filename = f'D:\\Drive\\1 - Threshold\\tfdata\\tfdata_chan_{channel}_participant_{participant}.mat'
        with h5py.File(filename, 'r') as f:
            data_real = np.array(f['tfdata']['real'])
            data_imag = np.array(f['tfdata']['imag'])
            data = data_real + 1j * data_imag
        data_selected_channels.append(data)
    data_avg = np.mean(data_selected_channels, axis=0)
    
    # Compute PSD
    psd = np.abs(data_avg)**2

    
    # Initialize FOOOF object
    fm = FOOOF(peak_width_limits=peak_width_limits)
    
    # Loop over timepoints and trials
    aperiodic_results = np.zeros((35,200,data_avg.shape[0]))
    periodic_results = np.zeros((35,200,data_avg.shape[0]))
    for t in range(200):
        for trial in range(data_avg.shape[0]):
            # Fit FOOOF model
            fm.fit(freqs, psd[trial,t,:], freq_range=[lower_freqs, upper_freqs])
            
            # Store results
            aperiodic_results[:,t,trial] = fm._ap_fit
            periodic_results[:,t,trial] = fm._peak_fit
            
    # Save results
    savemat(fr'D:\Drive\1 - Threshold\tfdata\fooof\fooof_participant_{participant}_aperiodic.mat', {'data': aperiodic_results})
    savemat(fr'D:\Drive\1 - Threshold\tfdata\fooof\fooof_participant_{participant}_periodic.mat', {'data': periodic_results})
