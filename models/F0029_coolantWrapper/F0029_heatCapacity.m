function cp = F0029_heatCapacity(T, par)

switch par.type

    case 1 
    % WEG50
    cp = 3.5025e+03;

    case 2
    % Dynalene HC50
    cp = F0030_heatCapacity(T);

    otherwise
    % default to WEG50
    cp = 3.5025e+03;

end

end