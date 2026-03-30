function mu = F0030_viscosity(T)

% parameters
x = [1.136876600758141e-06; 2.307436101200067e+03];

% viscosity
mu = x(1) .* exp( x(2) ./ T );

end