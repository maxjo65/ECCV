function dp = F0025_pressureVA195(q, n)

% parameters
a = [2.142485036049257e+02; -1.348961865573845e+03];

% function
dp2 = a(1) + a(2) .* q;

% affinity law
dp = dp2 .* (n./5000).^2;

end