function RINEXOBS304_header(filename)

fileID = fopen(filename);

% check for file
if fileID == -1

    fprintf('Error, file does not exist\n')
    return;

end

% feof checks end of file
while ~feof(fileID)

    % grab line from text file
    tline = fgetl(fileID);
    headerCheck = isempty(strfind(tline,'END OF HEADER'));

    fprintf(tline)
    fprintf('\n')

    if headerCheck == 0

        break

    end

end

% close
fclose(fileID);

end