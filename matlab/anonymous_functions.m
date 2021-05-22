% Explore anonymous functions. 
% Syntax is @(<independant variables>)<function text>;
func1 = @(x)sin(x.*x);

func1(2)

func2 = @(x,y)y*x^2;

func2(2,3)

fplot(func1,[-12 6])
