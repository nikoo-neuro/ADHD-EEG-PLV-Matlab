# ADHD-EEG-PLV-Matlab
MATLAB code for PLV-based prediction of neurofeedback response in ADHD using EEG signals.
# EEG Phase Locking Value for Predicting Neurofeedback Response in ADHD (MATLAB)

This repository contains MATLAB code based on the published study:

*Utilizing Phase Locking Value to Determine Neurofeedback Treatment Responsiveness in ADHD*  
Authors: M.R. Yousefi, N. Khanahmadi, A. Dehghani  
Journal of Integrative Neuroscience, 2024  
🔗 [DOI: 10.31083/j.jin2306121](https://doi.org/10.31083/j.jin2306121)



 Project Description

This project uses EEG signal preprocessing and Phase Locking Value (PLV) features to predict the treatability of ADHD patients before neurofeedback treatment. Using MATLAB, the pipeline involves:

- Multi-stage EEG preprocessing (notch, Butterworth, wavelet filters)
- Alpha and beta band isolation
- PLV computation via Hilbert transform
- Electrode selection using t-test and Genetic Algorithm
- Classification with SVM + Boosting (accuracy: 90.6%)



 Folder Structure

- `matlab/`: MATLAB scripts for preprocessing, PLV, feature selection, classification  
- `figures/`: EEG signal examples, classifier accuracy plots  
- `data/`: Info about Mendeley dataset (data not shared)  
- `publication/`: PDF of published paper



 Citation
 If you use this work, please cite:
 
Khanahmadi, N., Yousefi, M.R., Dehghani, A. (2024). Utilizing Phase Locking Value to Determine Neurofeedback Treatment Responsiveness in ADHD. Journal of Integrative Neuroscience. https://doi.org/10.31083/j.jin2306121



 Contact

- ORCID: [0000-0001-9900-3700](https://orcid.org/0000-0001-9900-3700)  
- Email: nikoo.ahmadi92@gmail.com  
- [LinkedIn](https://www.linkedin.com/in/nikoo-khanahmadi)



If you use this work, please cite:

