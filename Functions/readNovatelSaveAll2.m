function [output,lr] = readNovatelSaveAll2(fname,output_file,...
    outputClock_file,outputRXStat_file,outputTime_file,...
    outputClockSteer_file,outputRange_file,outputBestXYZ_file,...
    outputBestpos_file)

    % open file
    fid = fopen(fname);
    
    % check if file exists
    if fid == -1
        disp('[ readNovatelRange.m ]  Error!  File does not exist.');
        return;
    end
    
    lr = zeros(1,8);
    
    fprintf('\n Opening .txt files... \n')
    
    output_all = fopen(output_file,'a');
    output_clock = fopen(outputClock_file,'a');
    output_time = fopen(outputTime_file,'a');
    output_stat = fopen(outputRXStat_file,'a');
    output_clocksteer = fopen(outputClockSteer_file,'a');
    output_range = fopen(outputRange_file,'a');
    output_bestxyz = fopen(outputBestXYZ_file,'a');
    output_bestpos = fopen(outputBestpos_file,'a');
    
    fprintf('\n Parsing... \n')
    while ~feof(fid)
        tline = fgetl(fid);
        text_save = tline;   
        fprintf(output_all,'%s\r\n',text_save);
        output = output_file;
        lr(1) = lr(1)+1;
        if strfind(tline, 'CLOCKMODELA')
            fprintf(output_clock,'%s\r\n',text_save);
            output = output_clock;
            lr(2) = lr(2)+1;
        elseif strfind(tline, 'TIMEA')
            fprintf(output_time,'%s\r\n',text_save);
            output = output_time;
            lr(3) = lr(3)+1;
        elseif strfind(tline, 'RXSTATUSA')
            fprintf(output_stat,'%s\r\n',text_save);
            output = output_stat;
            lr(4) = lr(4)+1;
        elseif strfind(tline, 'CLOCKSTEERINGA')
            fprintf(output_clocksteer,'%s\r\n',text_save);
            output = output_clocksteer;
            lr(5) = lr(5)+1;
        elseif strfind(tline, 'RANGEA')
            fprintf(output_range,'%s\r\n',text_save);
            output = output_range;
            lr(6) = lr(6)+1;
        elseif strfind(tline, 'BESTXYZA')
            fprintf(output_bestxyz,'%s\r\n',text_save);
            output = output_bestxyz;
            lr(7) = lr(7)+1;
        elseif strfind(tline, 'BESTPOSA')
            fprintf(output_bestpos,'%s\r\n',text_save);
            output = output_bestpos;
            lr(8) = lr(8)+1;
        else
            x = 12;
        end
        if floor(lr(1)/50000) == lr(1)/50000
            fprintf('\n %1.0f Total lines read. \n% 1.0f clock model \n %1.0f time \n %1.0f status \n %1.0f clock steering \n %1.0f range \n %1.0f best xyz \n %1.0f best pos \n',...
                lr(1),lr(2),lr(3),lr(4),lr(5),lr(6),lr(7),lr(8))
            toc
        end
    end

    fprintf('\n Closing .txt files ... \n')
    fclose(output_clock);
    fclose(output_time);
    fclose(output_stat);
    fclose(output_clocksteer);
    fclose(output_range);
    fclose(output_bestxyz);
    fclose(output_all);
    fclose(fid);
    % close all;
end