function w = F0028_absHumidity(p)

w = 0.622 .* p(3) ./ (sum(p) - p(3));

end