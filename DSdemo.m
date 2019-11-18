clear;
close all;

%% read data.
[ data, label ] = readdata();

%% parameters.
ncls = 30;

%% PLA
[ model, acc ] = DStrain( data, label );
disp(['The training accuracy for decision tree : ', num2str(acc)]);

%% Adaboost for Decision Tree
[ models, alphas, accplot ] = DSboosttrain( data, label, ncls );
figure(1);
plot(accplot); xlabel('number of classifiers'); ylabel('accuracy');
disp(['The training accuracy for decision tree (Adaboost) : ', num2str(accplot(end))]);