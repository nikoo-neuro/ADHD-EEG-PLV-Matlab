% ADHD_PLV_SVM.m

% Description: Full pipeline for classification of ADHD using PLV features


clear; clc; close all;

%% Load Data
load('PLV_vectors.mat');    % Matrix: [n_samples x n_features]
load('labels.mat');         % Vector: [n_samples x 1]

X = zscore(PLV_vectors);    % Normalize features
y = labels;                 % Binary labels (ADHD = 1, Control = 0)

%% Cross-validation (5-fold)
cv = cvpartition(y, 'KFold', 5);
acc = zeros(cv.NumTestSets, 1);
sensitivity = zeros(cv.NumTestSets, 1);
specificity = zeros(cv.NumTestSets, 1);
AUC = zeros(cv.NumTestSets, 1);

figure; hold on;

for i = 1:cv.NumTestSets
    % Training and test split
    X_train = X(training(cv, i), :);
    y_train = y(training(cv, i));
    X_test = X(test(cv, i), :);
    y_test = y(test(cv, i));
    
    % Train SVM (Linear Kernel)
    model = fitcsvm(X_train, y_train, ...
        'KernelFunction', 'linear', ...
        'Standardize', true, ...
        'ClassNames', [0 1]);
    
    % Predict
    [y_pred, scores] = predict(model, X_test);
    
    % Metrics
    acc(i) = sum(y_pred == y_test) / length(y_test);
    
    tp = sum((y_pred == 1) & (y_test == 1));
    tn = sum((y_pred == 0) & (y_test == 0));
    fp = sum((y_pred == 1) & (y_test == 0));
    fn = sum((y_pred == 0) & (y_test == 1));
    
    sensitivity(i) = tp / (tp + fn);
    specificity(i) = tn / (tn + fp);
    
    % ROC curve
    [Xroc, Yroc, ~, auc] = perfcurve(y_test, scores(:,2), 1);
    plot(Xroc, Yroc);
    AUC(i) = auc;
end

%% Final results
fprintf('\nAverage Accuracy: %.2f%%\n', mean(acc) * 100);
fprintf('Average Sensitivity: %.2f%%\n', mean(sensitivity) * 100);
fprintf('Average Specificity: %.2f%%\n', mean(specificity) * 100);
fprintf('Mean AUC: %.3f\n\n', mean(AUC));

xlabel('False Positive Rate');
ylabel('True Positive Rate');
title('ROC Curves across 5 folds');
legend('Fold 1','Fold 2','Fold 3','Fold 4','Fold 5', 'Location','SouthEast');
grid on;
