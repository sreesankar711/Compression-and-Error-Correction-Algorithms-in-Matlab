function encoded_bitstream = hamming_encoder(encoded_message)

    pad = mod(4 - mod(numel(encoded_message), 4), 4);

    encoded_message = [encoded_message, repmat('0', 1, pad)];

    G = [1 1 1 0 0 0 0;
         1 0 0 1 1 0 0;
         0 1 0 1 0 1 0;
         1 1 0 1 0 0 1];

    codes = {};
    for i = 1:length(encoded_message)/4
      codes{i} = encoded_message((i-1)*4+1:i*4);
    end

    encoded_bitstream = [];

    for i = 1:length(codes)
        word = [];
        for j = 1:4
            word = [word str2num(codes{i}(j))];
        end
        encoded_bitstream = [encoded_bitstream mod(word * G, 2)];
    end

end