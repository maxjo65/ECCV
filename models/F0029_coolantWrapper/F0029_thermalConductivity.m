function lam = F0029_thermalConductivity(T, par)

switch par.type

    case 1 
    % WEG50
    lam = 0.4137;

    case 2
    % Dynalene HC50
    lam = F0030_thermalConductivity(T);

    otherwise
    % default to WEG50
    lam = 0.4137;

end

end