function [ c ] = bitwise_TMR_encoder( m )
%Encodes the data with triple modular bitwise redundancy
%INPUTS:
%   m: data bits to be encoded (row vector)  
%OUTPUTS:
%   c: codeword. each input will have a corresponding 3 bits in the 
%   output. ie. m = 01 -> c = 000111

    c = repelem(m,3);  

end

