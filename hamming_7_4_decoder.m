function [ corrected ] = hamming_7_4_decoder( r )
%Decodes signal that was encoded using hamming(7,4), corrects 
%if 1 or less bit errors per 7 bit word 
%INPUTS: 
% r: message to be decoded, with errors, must be multiple of 7 
%OUTPUTS:
% corrected: decoded message, with detected errors corrected 

    n = length(r)/7;
    corrected = zeros(1,n*4);
    
    for i = 1:n
        ind_r = (i-1)*7 + 1;
        ind_c = (i-1)*4 + 1;
        corrected(ind_c:(ind_c+3)) = hamming_7_4_block_decode(r(ind_r:(ind_r+6)));
    end
end

