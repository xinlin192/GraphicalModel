
% subroutine to test the emptiness of certain message
function emptiness = isMessageEmpty(message)
    emptiness = isempty(message.var) && isempty(message.card) && (isempty(message.val) || message.val == 0);
end 
