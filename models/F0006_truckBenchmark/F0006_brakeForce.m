function Fb = F0006_brakeForce(brake, par)
% inputs:
% brake [0,1] - brake signal

% parameters:
m    = par.m;
g    = 9.82;
gain = par.gain;

% output
Fb = min(min(max(brake,0),1) .* gain, m.*g);
end