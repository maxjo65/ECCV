function cp = F0030_heatCapacity(T)

% parameters
x = [2123.4; 1.9697];

% heat capacity
cp = x(1) + x(2) .* T;


end