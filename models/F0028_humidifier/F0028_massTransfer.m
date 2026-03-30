function dW = F0028_massTransfer(wa1, wb1, Wmin, e)

% effective latent heat transfer
dW = e .* Wmin .* (wb1 - wa1);

end