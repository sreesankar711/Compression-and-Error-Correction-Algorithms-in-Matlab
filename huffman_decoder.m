function [decoded_message,file] = huffman_decoder(encoded_message ,encodingtable)

lines = strsplit(encodingtable, '\n');

decoding_dict = containers.Map;
for i = 1:length(lines)
    if isempty(lines{i})
        continue;
    end
    
    line_parts = strsplit(lines{i}, ' ');
    ascii_val = line_parts{1};
    code = line_parts{2};
    code_decimal = bin2dec(code);
    decoding_dict(code) = char(bin2dec(ascii_val));
end

decoded_message = '';
curr = '';
for i = 1:length(encoded_message)
    curr = [curr encoded_message(i)];
    if isKey(decoding_dict, curr)
        decoded_message = [decoded_message decoding_dict(curr)];
        curr = '';
    end
end

file = fopen('decoded.txt','w+');
fprintf(file,'%s',decoded_message);
fclose(file);
file = 'decoded.txt';

end