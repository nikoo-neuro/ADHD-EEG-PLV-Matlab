% run_PLV_analysis.m

% Description:
% This script performs PLV-based functional connectivity analysis on EEG data:
% 1. Preprocess EEG
% 2. Compute PLV matrix
% 3. Visualize PLV matrix
% 4. Extract vectorized PLV features

%% Step 0: Load Data
load('eeg_trial1.mat');    % Assumed shape: eeg_data = [channels x time]
fs = 250;                  % Sampling frequency (example: 250 Hz)

%% Step 1: Preprocess EEG (Bandpass + Notch)
filtered_eeg = preprocess_eeg_ADHD(eeg_data, fs);

%% Step 2: Compute PLV Matrix
n_channels = size(filtered_eeg, 1);
analytic_signal = hilbert(filtered_eeg')';      % Hilbert transform
phase_data = angle(analytic_signal);            % Instantaneous phase

PLV_matrix = zeros(n_channels, n_channels);     % Initialize

for i = 1:n_channels
    for j = i:n_channels
        delta_phase = phase_data(i,:) - phase_data(j,:);
        plv = abs(mean(exp(1i * delta_phase)));
        PLV_matrix(i,j) = plv;
        PLV_matrix(j,i) = plv;
    end
end

%% Step 3: Visualize PLV Matrix
channel_labels = {'Fp1','Fp2','F3','F4','C3','C4','P3','P4','O1','O2'}; % example
figure;
imagesc(PLV_matrix);
colormap(jet);
colorbar;
title('PLV Connectivity Matrix');
axis square;
set(gca, 'XTick', 1:length(channel_labels), 'XTickLabel', channel_labels);
set(gca, 'YTick', 1:length(channel_labels), 'YTickLabel', channel_labels);
xtickangle(45);

%% Step 4: Vectorize PLV Features (Upper Triangle)
upper_idx = find(triu(ones(n_channels), 1));
PLV_vector = PLV_matrix(upper_idx);

% Save for future classification
save('PLV_vector_subject1.mat', 'PLV_vector');
