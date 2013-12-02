function [theta] = newton(X, y)
disp('theta function');
[m,n] = size(X);
X = [ones(size(X,1),1), X];
tolerance = zeros(n+1, 1) + 0.00001;
count = 0;
oldtheta = zeros(n+1, 1);
count = 1;
theta = zeros(n+1, 1);
while true
grad = zeros(n+1, 1);
hes = zeros(n+1, n+1);

for j = 1:n+1
    for i = 1:m
        grad(j) = grad(j) + ((y(i) - sigmoid(X(i,:)*theta)) .* X(i, j));
    end
disp(j)
end

for j = 1:n+1
	for k = 1:n+1
	    for i = 1:m
                hes(j, k) = hes(j, k) + (-1 .* X(i, k) .* X(i, j) .* sigmoid(X(i,:)*theta) .* (1 - sigmoid(X(i, :)*theta)));
        end
    end
end

theta = theta - inv(hes)*grad;
disp(theta)
disp(abs(theta - oldtheta) < tolerance);
if (sum(abs(theta - oldtheta) < tolerance) == (n + 1))
    break;
end
oldtheta = theta;
end
