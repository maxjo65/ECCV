function rho = F0029_density(T, par)

switch par.type

    case 1 
    % WEG50
    rho = 1.0406e+03;

    case 2
    % Dynalene HC50
    rho = F0030_density(T);

    otherwise
    % default to WEG50
    rho = 1.0406e+03;

end

end