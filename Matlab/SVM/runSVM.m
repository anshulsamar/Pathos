status = system('rm *.mat')
disp('Loading constants')
loadconstants;
[predicted_labels] = headlinesSVM()
