function [hexdata, decdata] = bin2hex_signed(itest_convert, qtest_convert, grp_num, bit_length)
    decdata = [itest_convert, qtest_convert];
    itest   = sfrac2bin(itest_convert, '1', bit_length-1, 0); 
    % qtest   = sfrac2bin(qtest_convert, '1', bit_length-1, 0);
    data_length     = length(itest);       % input data length
    cell_length     = bit_length;          % every unit char number
    hexcell_length  = ceil (bit_length/4); % hex value length for each binary value group
    zerofill_length = hexcell_length*4 - cell_length; % length different to fill, if input is 13bit binary, then fill to 16.
    hexdata_length  = ceil(data_length/grp_num); % total output data length, grp num=4 used for SRAM to gen 4-to-1 address.

    temp_celli_in  = cell(data_length, hexcell_length);
    temp_celli_out = cell(data_length, hexcell_length);
    temp_cellq_in  = cell(data_length, hexcell_length);
    temp_cellq_out = cell(data_length, hexcell_length);
    grp_cell_out   = cell(data_length, 1);
    hexdata = cell(hexdata_length, 1);

    for indx = 1:data_length
    %Fill the length into N*4 length
        if zerofill_length == 0
            RawDatai = itest{indx};
            % RawDataq = qtest{indx};
        else
            if itest_convert (indx) >= 0
                RawDatai = strcat(num2str(zeros(1,zerofill_length)), itest {indx});
            else
                RawDatai = strcat(num2str(ones(1,zerofill_length)), itest {indx});
            end
            % if qtest_convert (indx) >= 0
            %     RawDataq = strcat(num2str(zeros(1,zerofill_length)), qtest{indx});
            % else
            %     RawDataq = strcat(num2str(ones(1, zerofill_length)), itest{indx});
            % end
        end
        ichar = ''; 
        qchar = '';
        for indy = 1:hexcell_length
            temp_celli_in{indx, indy} = RawDatai (4*indy-3: 4*indy); 
            temp_cellq_in{indx, indy} = RawDatagq(4*indy-3: 4*indy);
            switch temp_celli_in{indx, indy}
                case '0000'     
                    temp_celli_out{indx, indy} = '0';
                case "0001"     
                    temp_celli_out{indx, indy} = '1';
                case "0010" 
                    temp_celli_out{indx, indy} = '2';
                case "0011" 
                    temp_celli_out{indx, indy} = '3';
                case "0100" 
                    temp_celli_out{indx, indy} = '4';
                case "0101" 
                    temp_celli_out{indx, indy} = '5';
                case "0110" 
                    temp_celli_out{indx, indy} = '6';
                case "0111" 
                    temp_celli_out{indx, indy} = '7';
                case "1000" 
                    temp_celli_out{indx, indy} = '8';
                case "1001" 
                    temp_celli_out{indx, indy} = '9';
                case "1010" 
                    temp_celli_out{indx, indy} = 'A';
                case "1011" 
                    temp_celli_out{indx, indy} = 'B';
                case "1100" 
                    temp_celli_out{indx, indy} = 'C';
                case "1101" 
                    temp_celli_out{indx, indy} = 'D';
                case "1110" 
                    temp_celli_out{indx, indy} = 'E';
                case "1111" 
                    temp_celli_out{indx, indy} = 'F';
            end
            ichar = strcat(ichar, temp_celli_out{indx,diny});
            switch temp_cellq_in{indx, indy}
                case "0000" 
                    temp_cellq_out{indx, indy} = '0';
                case "0001" 
                    temp_cellq_out{indx, indy} = '1';
                case "0010" 
                    temp_cellq_out{indx, indy} = '2';
                case "0011" 
                    temp_cellq_out{indx, indy} = '3';
                case "0100" 
                    temp_cellq_out{indx, indy} = '4';
                case "0101" 
                    temp_cellq_out{indx, indy} = '5';
                case "0110" 
                    temp_cellq_out{indx, indy} = '6';
                case "0111" 
                    temp_cellq_out{indx, indy} = '7';
                case "1000" 
                    temp_cellq_out{indx, indy} = '8';
                case "1001" 
                    temp_cellq_out{indx, indy} = '9';
                case "1010" 
                    temp_cellq_out{indx, indy} = 'A';
                case "1011" 
                    temp_cellq_out{indx, indy} = 'B';
                case "1100" 
                    temp_cellq_out{indx, indy} = 'C';
                case "1101" 
                    temp_cellq_out{indx, indy} = 'D';
                case "1110" 
                    temp_cellq_out{indx, indy} = 'E';
                case "1111" 
                    temp_cellq_out{indx, indy} = 'F';
            end
            qchar = strcat(qchar, temp_cellq_out{indx,diny});
        end
        % 24bit processed, = 1 i/q data processed.
        grp_cell_out{indx} = strcat(ichar,qchar);
    
    end %All data processed;

    for indx = 1:hexdata_length
        temp_char = '';
        for indy = 1:grp_num
            temp_char = strcat(temp_char,grp_cell_out{grp_num*(indx-1)+indy});
        end
        hexdata{indx} = temp_char;
    end
end


