function [encoded_message, numbits]  = lempelziv_encoder(input)

ascii = uint8(input);
input = dec2bin(ascii, 8)';
input = input(:)';

dictionary = containers.Map;   
i = 1;
c = 1;
code_words = {};
while i <= length(input)
    match = input(i);
    while isKey(dictionary, match) && i<length(input)
        i=i+1;
        match = [match input(i)];
    end 

    if ~isKey(dictionary, match)
        dictionary(match) = c;
        c = c + 1;
    end
    code_words{end+1} = match;
    match='';
    i=i+1;

end

keys = dictionary.keys;
values = dictionary.values;
length(dictionary);
numbits = ceil(log2(length(dictionary)+1)) + 1;
dictionary('')=0;

encoded_message = '';


for i=1:length(code_words)
    match = code_words{i};
    code = match(1:end-1);
    encoded_message = strcat(encoded_message, dec2bin(dictionary(code), numbits-1));
    encoded_message = strcat(encoded_message, match(end));
end

end





