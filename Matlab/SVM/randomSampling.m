function[] = randomSampling()

addpath('../Parse/');
addpath('showcell/');

angryHeadlines = extractHeadlinesFromTextFile('~/CS229/Pathos/Matlab/Training/Latest/Original/angryHeadlinesTau.txt',  4817);
x = randperm(4817);
angryHeadlines = angryHeadlines(x);
angryHeadlines = angryHeadlines(1:100,:);
showcell(angryHeadlines);

nonAngryHeadlines = extractHeadlinesFromTextFile('~/CS229/Pathos/Matlab/Training/Latest/Original/nonAngryHeadlinesTau.txt',  2402);
x = randperm(2402);
nonAngryHeadlines = nonAngryHeadlines(x);
nonAngryHeadlines = nonAngryHeadlines(1:100,:);
showcell(nonAngryHeadlines);

end
