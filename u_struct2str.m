function out = u_struct2str(s)

fnames = fieldnames(s);
fnum   = numel(fnames);

% check all elements same size
sizes = zeros(fnum,1);
for i = 1 : fnum
    sizes(i) = size(s.(fnames{i}),1);
end
if any(diff(sizes))
    warning('cannot convert struct to string');
end

% do conversion
out = cell(sizes(1),1);
for i = 1 : sizes(1)
    str = '';
    try
        for j = 1 : fnum
            if isnumeric(s.(fnames{j})(i,:))
                str = [str num2str(s.(fnames{j})(i,:)) ','];
            elseif iscell(s.(fnames{j}){i,:})
                str = [str cell2mat(strcat(s.(fnames{j}){i},'|')) ','];
            else
                str = [str s.(fnames{j}){i} ','];
            end
        end
    catch err
    end
    out{i} = str;
end
        
end