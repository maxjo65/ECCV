% Generate a simulink library from model folder
addpath(genpath('models'));

% open library target
open_system('base_lib');

% unlock library
set_param('base_lib','Lock','off')

% paths to blocks
subsystemBlockPath = 'simulink/Commonly Used Blocks/Subsystem';
libraryBlockPath = 'simulink/User-Defined Functions/MATLAB Function';

% list of folders
D = dir('models');
N = length(D);

% Folder positions
X = ones(5,5) .* linspace(0,500,5);
Y = ones(5,5) .* linspace(0,450,5)';

% Block positions
x = ones(10,10) .* linspace(0,2000,10);
y = ones(10,10) .* linspace(0,2000,10)';

% generate library folders
for j = 3:N
    % file paths
    folder_name   = D(j).name;
    lib_name     = 'base_lib/';
    newFolderPath = [lib_name, folder_name];

    % check if block exists
    check = getSimulinkBlockHandle(newFolderPath);

    % add/replace block to/in library
    if check == -1
        add_block(subsystemBlockPath, newFolderPath);
    end

    
    % delete contents
    Simulink.SubSystem.deleteContents(newFolderPath)

    % set position
    set_param(newFolderPath, ...
        'position', [Y(j-2), X(j-2), Y(j-2)+100, X(j-2)+100]) ;

    d = dir(['models/', folder_name]);
    n = length(d);

    % generate library
    for i = 3:n
        % file paths
        model_name   = d(i).name;

        if strcmp(model_name(end), 'm')

            lib_name     = 'base_lib/';
            block_name   =  model_name(1:(end-2));
            newBlockPath = [lib_name, folder_name, '/', model_name];

            % check if block exists
            check = getSimulinkBlockHandle(newBlockPath);

            % add/replace block to/in library
            if check == -1
                add_block(libraryBlockPath, newBlockPath);
            end

            % connect block to model
            blockHandle = find(slroot, '-isa', 'Stateflow.EMChart', ...
                'Path', newBlockPath);
            blockHandle.Script = fileread(model_name);

            % set position
            set_param(newBlockPath, ...
                'position', [y(i-2), x(i-2), y(i-2)+200, x(i-2)+200]) ;

            % set color
            set_param(newBlockPath, 'BackgroundColor', 'Cyan');

            % set parameter input to non-tuneable parameter
            inputs = blockHandle.Inputs;
            for j = 1:length(inputs)
                if strcmp(inputs(j).name, 'par')
                    blockHandle.Inputs(j).Tunable = 0;
                    blockHandle.Inputs(j).Scope   = 'Parameter';
                end
            end

        end
    end
end

% lock & close library
set_param('base_lib','Lock','on')
save_system;
close_system;





