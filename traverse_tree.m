function traverse_tree(node, code, codes)
if isempty(node.left) && isempty(node.right)
    codes(node.letter) = code;
else
    traverse_tree(node.left, [code '0'], codes);
    traverse_tree(node.right, [code '1'], codes);
end
end
