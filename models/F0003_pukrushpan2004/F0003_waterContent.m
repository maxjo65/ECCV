function lambda = F0003_waterContent(a)
lambda = zeros(length(a),1);
% lambda( a <= 1) = 0.043 + 17.81.*a - 39.85.*a.^2 + 36.*a.^3;
% lambda( a > 1)  = 14 + 1.4*(a-1);

lambda = 0.043 + 17.81.*a - 39.85.*a.^2 + 36.*a.^3;

end