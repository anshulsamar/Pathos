function[precision, recall, accuracy] = stats(testLabels, predicted_label)

  precisionNumerator = 0;
  precisionDenominator = 0;
  recallNumerator = 0;
  recallDenominator = 0;
  accuracyNumerator = 0;
  accuracyDenominator = 0;

  for i=1:size(testLabels(:,1),1)

    if (testLabels(i,1) == 1 && predicted_label(i) == 1)
      accuracyNumerator = accuracyNumerator + 1;
      accuracyDenominator = accuracyDenominator + 1;
    elseif (testLabels(i,1) == 0 & predicted_label(i) == 0)
      accuracyNumerator = accuracyNumerator + 1;
      accuracyDenominator = accuracyDenominator + 1;
    else
      accuracyDenominator = accuracyDenominator + 1;
    end

    if (testLabels(i,1) == 1)
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

