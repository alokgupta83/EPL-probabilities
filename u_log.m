function u_log(msg)

% check if there is anything to log
if isempty(msg)
    msg = '';
end

% convert struct to array of strings
if isstruct(msg)
    msg = u_struct2str(msg);
end

% check msg string or array of strings
if ~ischar(msg) && ~iscellstr(msg)
    warning('cannot log');
    return
end

% get where log request came from
fromFct = '';
try 
    tmp = dbstack;
    fromFct = tmp(2).file;
catch err
end
% convert string to cell of string for ease later
if ischar(msg)
    msg = {msg};
end

% file name
fdate = datestr(now,'yyyymmdd');
fname = [pwd '\logs\' fdate '.csv'];

% append to file (or create if need be
fileID = fopen(fname,'a');

for i = 1 : numel(msg)
    ts     = datestr(now,'HH:MM:SS.FFF');
    prefix = [ts ', ' fromFct ', ' num2str(i)];
    try
        log = [prefix ', ' msg{i}];
        fprintf(fileID,'%s\n',log);
    catch err
        log = [prefix ', ' err.message];
        fprintf(fileID,'%s\n',log);
    end
end
fprintf(fileID,'%s\n','');

% close file
fclose(fileID);

end