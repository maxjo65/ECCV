function mu = F0029_viscosity(T, par)

switch par.type

    case 1 
    % WEG50
    mu = 0.0014;

    case 2
    % Dynalene HC50
    mu = F0030_viscosity(T);

    otherwise
    % default to WEG50
    mu = 0.0014;

end

end