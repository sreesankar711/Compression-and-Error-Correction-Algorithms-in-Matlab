function output_bitstream = onebiterror(input,p)
    input = char(input + '0');
    output_bitstream = '';

    for i = 1:length(input)/7        
        current_code = input((i-1)*7+1:i*7);       
        error_prob = rand();
        
        if error_prob < p
            pos = randi(7);
            if current_code(pos) == '0'
                current_code(pos) = '1';
            else
                current_code(pos) = '0';
            end
        end
        output_bitstream = [output_bitstream current_code];
       
    end
    
end