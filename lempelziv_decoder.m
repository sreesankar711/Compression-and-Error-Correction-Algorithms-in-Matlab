function [decoded_message,file]  = lempelziv_decoder(encoded_message,numbits)

j = 1;
code_words = {};
code_words{j} = '';
for i = 1:length(encoded_message)
    code_words{j} = [code_words{j} encoded_message(i)];
    if mod(i, numbits) == 0 && i<length(encoded_message)
        j = j + 1;
        code_words{j} = '';
    end
end

dictionary = containers.Map;

dictionary(dec2bin(1,numbits-1)) = code_words{1}(end);
decoded_message = code_words{1}(end);

for i = 2:length(code_words)
    code = code_words{i};
    if code(1:end-1) == dec2bin(0,numbits-1)
        dictionary(dec2bin(i,numbits-1)) = code(end);
        decoded_message = [decoded_message code(end)];
        
    else
        msg = [dictionary(char(code(1:end-1))) code(end)];
        dictionary(dec2bin(i,numbits-1)) =char(msg);
        decoded_message = [decoded_message msg];
    end
end

ascii = bin2dec(reshape(decoded_message, 8, [])');
decoded_message = char(ascii);

file = fopen('decoded.txt','w+');
fprintf(file,'%s',decoded_message);
fclose(file);
file = 'decoded.txt';

end