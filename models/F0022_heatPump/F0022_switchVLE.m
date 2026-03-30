function y = F0022_switchVLE(x)
% step function on 0-1
y = tanh( 1000*(x-0.01) ) / 2  - tanh( 1000*(x-0.99) ) / 2;

end