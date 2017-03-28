function [ c ] = hamming_7_4_block_encode( m )
%Hamming(7,4) encoding, encodes 4 bits of data into seven bits, where
% three bits are parity bits. 
%INPUTS:
% m: data bits to be encoded, must be length 4 
%
%OUTPUTS: 
% c: encoded data based on defined parity bits, is of length 7 
% p0 = a0+a1+a3
% p1 = a0+a2+a3
% p2 = a1+a2+a3
% e.g 1100 -> 001 parity bits 

    %4x7 matrix generator where column mapping is a3 a2 a1 a0 p2 p1 p0
    G = [1,0,0,0,1,1,1;0,1,0,0,1,1,0;0,0,1,0,1,0,1;0,0,0,1,0,1,1];
    c = m*G;
    %use mod 2 to turn addition into xor operation 
    c = mod(c,2);
end

