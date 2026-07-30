function ads = timitHelper(dataFolder)

% Get file information from provided .tsv files
% trainTable = readtable(tempdir + fullfile("commonvoice","train","train.tsv"),FileType="text",Delimiter="tab");
trainTable = readtable(dataFolder + fullfile("allfilelist.txt"),FileType="text",Delimiter='/');
dataTable = trainTable;

%{
% Sort speakers by how many files they speak on
dataTable.client_id = string(dataTable.client_id);
dataTable.path = string(dataTable.path);
ids = unique(dataTable.client_id);
counts = zeros(length(ids),1);
for i = 1:length(ids)
    counts(i) = sum(strcmp(dataTable.client_id,ids(i)));
end
[s, idxs] = sort(counts);

% Take speakers with around 14-22 files 
assert(s(743) == 14 && s(752) == 22);
idxs = idxs(743:752);
ids = ids(idxs);
rows = ismember(dataTable.client_id,ids);
%}
rows = 1:height(trainTable);

% Get paths for each file in dataTable
% trainPaths = repelem(fullfile("allfilelist.txt"), height(trainTable))';
% valPaths = repelem(fullfile("commonvoice","validation","clips"), height(valTable))';
% paths = trainPaths;

% Only take paths for selected files
% files = string(tempdir) + fullfile(paths(rows),string(dataTable.path(rows))) + ".wav";
files = string(dataFolder) + fullfile(string(dataTable.client_id(rows)),string(dataTable.path(rows))) + ".wav";
% Get speaker IDs, create datastore, and assign speaker labels as 1-10
speakers = string(dataTable.client_id(rows));
ads = audioDatastore(files);
ads.Labels = categorical(speakers,unique(speakers),string(1:length(unique(speakers))));
end