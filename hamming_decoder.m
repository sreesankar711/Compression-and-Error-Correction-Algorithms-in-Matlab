function decoded_bitstream = hamming_decoder(encoded_bitstream)

    H = [1 0 1 0 1 0 1;
         0 1 1 0 0 1 1;
         0 0 0 1 1 1 1];

    syndromes = {};
    for i = 1:length(encoded_bitstream)/7
        word = encoded_bitstream((i-1)*7+1:i*7);
        syndrome = mod(word * H', 2);
        syndromes{i} = syndrome;
    end


    decoded_bitstream = [];
    for i = 1:length(syndromes)
        if sum(syndromes{i}) == 0
            decoded_word = encoded_bitstream((i-1)*7+1:i*7);
            decoded_bitstream = [decoded_bitstream, decoded_word([3, 5, 6, 7])];
        else
            error_pos = bin2dec(num2str(fliplr(syndromes{i})));
            corrupted_word = encoded_bitstream((i-1)*7+1:i*7);
            if corrupted_word(error_pos) == '0'
                corrupted_word(error_pos) = '1';
            else
                corrupted_word(error_pos) = '0';
            end
            decoded_word = corrupted_word([3, 5, 6, 7]);
            decoded_bitstream = [decoded_bitstream decoded_word];
        end
    end
    if isnumeric(decoded_bitstream)
        decoded_bitstream = char(decoded_bitstream + '0');
    end
end