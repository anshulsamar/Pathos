%If you run NB, make sure to change accuracy marker back to 0


function[precision, recall, accuracy] = stats(testLabels, predicted_label)

  precisionNumerator = 0;
  precisionDenominator = 0;
  recallNumerator = 0;
  recallDenominator = 0;
  accuracyNumerator = 0;
  accuracyDenominator = size(testLabels,1);

  for i=1:size(testLabels,1)

    if (testLabels(i) == 1 && predicted_label(i) == 1)
      accuracyNumerator = accuracyNumerator + 1;
    elseif (testLabels(i) <= 0 && predicted_label(i) <= 0)
      accuracyNumerator = accuracyNumerator + 1;
    end

    if (testLabels(i) == 1)
      recallDenominator = recallDenominator + 1;
      if (predicted_label(i) == 1)
	recallNumerator = recallNumerator + 1;
      end
    end

    if (predicted_label(i) == 1)
      precisionDenominator = precisionDenominator + 1;
      if (testLabels(i,1) == 1)
	precisionNumerator = precisionNumerator + 1;
      end
    end
  end


  precision = precisionNumerator/precisionDenominator
 recall = recallNumerator/recallDenominator
  accuracy = accuracyNumerator/accuracyDenominator

end

