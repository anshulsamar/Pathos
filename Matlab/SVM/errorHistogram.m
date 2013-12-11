addpath('../Parse/');
addpath('../Lib/liblinear-1.93');


disp('Loading constants')
loadconstants;
[test_Labels] = extractSemevalLabels(testLabelsPath, numTestHeadlines, numEmotions);
[predicted_label] = headlinesSVM();

test_Label2 = test_Labels(:,1);



actual_histogram = zeros(1,7);
predicted_histogram = zeros(1,7);
m = size(test_Label2,1)
 for i=1:m
	  if (test_Label2(i) == 0)
	    actual_histogram(1) = actual_histogram(1) + 1;
if (predicted_label(i) == 1)
  predicted_histogram(1) = predicted_histogram(1) + 1;
          end
	  elseif (test_Label2(i) < 10)
	    actual_histogram(2) = actual_histogram(2) + 1;
if (predicted_label(i) == 1)
  predicted_histogram(2) = predicted_histogram(2) + 1;
          end
	  elseif (test_Label2(i) < 20)
	    actual_histogram(3) = actual_histogram(3) + 1;
if (predicted_label(i) == 1)
  predicted_histogram(3) = predicted_histogram(3) + 1;
          end
	  elseif (test_Label2(i) < 30)
	    actual_histogram(4) = actual_histogram(4) + 1;
if (predicted_label(i) == 1)
  predicted_histogram(4) = predicted_histogram(4) + 1;
          end
	  elseif (test_Label2(i) < 40)
	    actual_histogram(5) = actual_histogram(5) + 1;
if (predicted_label(i) == 1)
  predicted_histogram(5) = predicted_histogram(5) + 1;
          end
	  elseif (test_Label2(i) < 50)
	    actual_histogram(6) = actual_histogram(6) + 1;
if (predicted_label(i) == 1)
  predicted_histogram(6) = predicted_histogram(6) + 1;
          end
 else
   actual_histogram(7) = actual_histogram(7) + 1;
if (predicted_label(i) == 1)
  predicted_histogram(7) = predicted_histogram(7) + 1;
          end
        end
end



disp(actual_histogram)
disp(predicted_histogram)  
