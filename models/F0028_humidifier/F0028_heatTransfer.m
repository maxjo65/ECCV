function dQ = F0028_heatTransfer(Ta1, Tb1, Wcpmin, e)

% effective heat transfer
dQ = e .* Wcpmin .* (Tb1 - Ta1);

end