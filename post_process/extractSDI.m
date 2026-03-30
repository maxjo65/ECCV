function data = extractSDI(nr_of_runs)
% A function that extract the run data from the simulink data inspector
% nr_of_runs specifies the latest # of runs that is output

% get all current run ID's
run_id     = Simulink.sdi.getAllRunIDs;

% if number of runs has been called
if nargin >= 1
    nr_of_runs = min(nr_of_runs, length(run_id));
    run_id     = run_id((end-(nr_of_runs-1)):end);
end

% data output variable
data = cell(length(run_id), 1);

% loop over runs
for m = 1:length(run_id)

    % get run object
    eccv_run = Simulink.sdi.getRun(run_id(m));

    % get run signals
    run_signals = getAllSignals(eccv_run)';

    % extract data
    names     = cell(length(run_signals) + 1, 1);
    run_data = zeros( run_signals(1).NumPoints, length(names) );

    % add time in first column
    names{1}       = 'Time';
    run_data(:,1) = run_signals(1).Values.Time;

    % loop over signals
    for n = 2:length(run_signals)+1
        % names{n}      = run_signals(n-1).BlockName;
        names{n}      = erase(run_signals(n-1).Name, ':1');
        run_data(:,n) = run_signals(n-1).Values.Data;
    end

    % convert to table
    run_data = array2table(run_data);
    run_data.Properties.VariableNames = names;

    % add to data cell
    data{m} = run_data;
end