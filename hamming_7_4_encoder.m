function [ c ] = hamming_7_4_encoder( m )
%Uses hamming(7,4) to encode signal
%INPUTS: 
% m: message to be encoded, must be a multiple of 4 
%OUTPUTS:
% c: encoded message, for every 4 bits of input, the output will have 7 

    n = length(m)/4;
    c = zeros(1,7*n);
    for i=1:n
        ind_m = 4*(i-1)+1;
        ind_c = 7*(i-1)+1;
        c(ind_c:(ind_c+6))=hamming_7_4_block_encode(m(ind_m:(ind_m+3)));
    end
    
end

