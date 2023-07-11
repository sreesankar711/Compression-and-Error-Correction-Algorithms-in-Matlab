function output_bitstream = biterror(input,p)
    
    input = char(input + '0');

    output_bitstream = '';

    for i = 1:length(input)              
        error_prob = rand();
        
        if error_prob < p
            if input(i) == '0'
                output_bitstream =[output_bitstream '1'];
            else
                output_bitstream = [output_bitstream '0'];
            end
        else
            output_bitstream =[output_bitstream input(i)];
        end
    end

end