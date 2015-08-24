Let's say I give you a news headline to read. Can I predict whether or not
you will be angry after reading it?

Determining the emotion sparked by a piece of text is a difficult subset sentiment  a
field which has largely focused on binary classification of text as
positive or negative. Classifying sentences in one of six major emotion
categories (anger, disgust, fear, joy, sadness, and surprise) can make
significant contributions to political polling, marketing, and stock
market predictions. In this study, we focus on the first of these six
emotions, anger, and develop a model to predict whether or not a reader
will feel anger after reading a headline. Our model involves NLP tools -
stemming, named entity recognition, and part of speech tagging - and a bag
of words model run on a SVM with a linear kernel and a Naive Bayes
Classifier with Laplace smoothing. We developed experimental models to
test on smaller subsets of data including: PCA, to reduce dimensionality
of data, a synonym algorithm, to expand each headline allowing our model
to classify with respect to more words, and a co-occurrence model, to
score each headline based on co-occurrences of words with the word `anger'
in the New York Times archives. We attained accuracy between 70 - 75% across multiple data set sizes and
up to 86% on experimental models with a smaller set. 

With these models, we hope to gain greater insight into
methods that one can use to detect emotion within text.

All the code is above and the code for our parser will be uploaded soon. 
See our paper to learn more. 

This project was built by Anshul Samar and Bharad Raghavan for CS229 (Machine Learning) at Stanford University.
