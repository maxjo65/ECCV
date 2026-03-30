function dp = F0024_pressureWP150(q, n)

% parameters
a = [-123461.665683305;
    69.1858073291126; 3.37203190426057; -3645.86929609208];

% function
dp = a(1) + a(2) .* n + a(3) .* q.* n + a(4) .* q.^2;

end