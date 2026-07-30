function fullPath = path_user(basePath)
    % This function inserts the current user into the basePath dynamically.
    
    % Get the current user's name
    currentUser = getenv('USERNAME');
    
    % Find the location of 'Users\' in the path and '\OneDrive'
    userStartIdx = strfind(basePath, 'Users\') + length('Users\');
    oneDriveIdx = strfind(basePath, '\OneDrive');
    
    % Construct the full path by inserting the current user's name
    if ~isempty(userStartIdx) && ~isempty(oneDriveIdx)
        fullPath = [basePath(1:userStartIdx-1), currentUser, basePath(oneDriveIdx:end)];
    else
        error('Base path format is not as expected. Please check the path structure.');
    end
end

%{
% Base path with placeholder user
basePath = 'C:\Users\Desmond\OneDrive\Resources\timit\';
% Get the updated full path
dataFolder = getMyOne(basePath);
% Display the resulting path
disp(dataFolder);
%}