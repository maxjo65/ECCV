function [V, Q_gen] = F0031_ITPEMFC(I, p_O2, T, RH, par)
        
    % reshape inputs
    dims = size(I);
    
    I    = I(:);
    p_O2 = p_O2(:);
    T    = T(:);
    RH   = RH(:);

    % constants
    R     = 8.314;     % [J/(K mol)] - Gas constant
    F     = 96485;     % [C/mol]     - Faradays constant
    n     = 2;         % [-]         - moles of electrons transfered per mole hydrogen reacted
    E0    = 1.229;     % [V]         - standard potential
    p0    = 1e5;       % [Pa]        - std. pressure
    dh    = 285.8e3;   % [J/mol]     - heat of formation (liquid)
    t_m   = 10e-6;     % [cm]        - membrane thickness
   
    % parameters
    x    = par.x;
    A_fc = par.A_fc;

    % current density
    j = I ./ A_fc;

    % reversible voltage
    E = E0 - 8.5e-4 .* (T-298.15) + R.*T./(n*F) .* log( sqrt( p_O2./p0 ));

    % calculate parameters from linear model
    p = p_O2;
    
    A = [p, p.^2, T, T.^2, RH, RH.^2, 1./p, 1./T, 1./RH];
    C = [ones(length(j),1) .* A, (1 - exp(-10 .* j)) .* A, t_m .* j .* A];

    % Loss model: y = [1, C] * x;
    n_loss = [ones(length(j),1), C] * x;

    % Output
    V = E - n_loss;

    % Heat generation
    P_elec = j .* A_fc .* V;              % [W] - electric power
    P_tot  = j .* A_fc ./ (2*F) .* dh;   % [W] - total power
    Q_gen  = P_tot - P_elec;         % [W] - heat generation
        
    % reshape outputs
    V     = reshape(V,     dims);
    Q_gen = reshape(Q_gen, dims); 

end