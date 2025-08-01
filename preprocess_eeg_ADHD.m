% preprocess_eeg_ADHD.m

function eeg_clean = preprocess_eeg_ADHD(eeg_data, fs)
% Inputs:
%   eeg_data: EEG matrix (channels x samples)
%   fs: Sampling frequency in Hz
% Output:
%   eeg_clean: Preprocessed EEG matrix (ready for PLV analysis)

    % Step 1: Apply notch filter to remove 50 Hz powerline noise
    wo = 50 / (fs / 2);            % Normalized frequency
    bw = wo / 35;                  % Bandwidth
    [b_notch, a_notch] = iirnotch(wo, bw);
    eeg_notched = filtfilt(b_notch, a_notch, eeg_data')';
    
    % Step 2: Apply 4th-order Butterworth bandpass filter (0.1–45 Hz)
    [b_bp, a_bp] = butter(4, [0.1 45] / (fs / 2), 'bandpass');
    eeg_clean = filtfilt(b_bp, a_bp, eeg_notched')';
end
