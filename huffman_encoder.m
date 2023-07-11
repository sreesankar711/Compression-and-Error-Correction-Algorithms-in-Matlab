function [encodingtable, encoded_message] = huffman_encoder(input)


ascii = uint8(input);

binary = dec2bin(ascii,8);

freq_map = containers.Map('KeyType','double','ValueType','double');
for i = 1:length(ascii)
    char = ascii(i);
    if isKey(freq_map, char)
        freq_map(char) = freq_map(char) + 1;
    else
        freq_map(char) = 1;
    end
end

keys = freq_map.keys;
values = freq_map.values;
%disp('Letter-frequency mappings:');
% for i = 1:length(keys)
%     fprintf('%d -> %d\n', keys{i}, values{i});
% end


letters = cell2mat(freq_map.keys);
frequencies = cell2mat(freq_map.values);
[sorted_frequencies, sorted_indices] = sort(frequencies);
sorted_letters = letters(sorted_indices);
% disp('Letters in terms of freq:');
% disp(sorted_letters);


num_nodes = length(sorted_frequencies);
nodes = struct('letter', {}, 'freq', {}, 'left', {}, 'right', {});
for i = 1:num_nodes
    nodes(i).letter = sorted_letters(i);
    nodes(i).freq = sorted_frequencies(i);
end


while num_nodes > 1
    left_node = nodes(1);
    right_node = nodes(2);
    new_node = struct('letter', [], 'freq', left_node.freq + right_node.freq, 'left', left_node, 'right', right_node);
    
    nodes(1:2) = [];
    nodes = [nodes new_node];
    
    frequencies = [nodes.freq];
    [sorted_frequencies, sorted_indices] = sort(frequencies);
    nodes = nodes(sorted_indices);
    
    num_nodes = length(sorted_frequencies);
end


codes = containers.Map('KeyType','double','ValueType','char');
traverse_tree(nodes, '', codes);


keys = codes.keys;
values = codes.values;
% disp('Huffman codes:');
% for i = 1:length(keys)
%     fprintf('%d -> %s\n', keys{i}, values{i});
% end


encoded_message = '';
for i = 1:length(input)
    letter = input(i);
    encoded_message = [encoded_message codes(double(letter))];
end

encodingtable = '';
for i = 1:length(keys)
    ascii_val = dec2bin(keys{i}, 8);
    code = values{i};
    encodingtable = [encodingtable sprintf('%s %s\n', ascii_val, code)];
end


end