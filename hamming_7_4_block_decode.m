function [ c ] = hamming_7_4_block_decode( r )
%Decodes the hamming(7,4) encoded signal 
%INPUTS:
% r: block from received message encoded using hamming_7_4_encode
%   with errors 
%OUTPUTS:
% c: corrected block, can only correct one bit error
%   this is done by looking at produced syndromes 
% e.g. original message 1100 -> 1100001 (with parity) one-bit error
%      received message 1000001, syndrome 111, output 1100
    
    %matrix used to generate the syndrom vector 
    G = [1,1,1,0,1,0,0;1,1,0,1,0,1,0;1,0,1,1,0,0,1];
    %use transpose matrix of r
    S = G*r';
    %mod 2 on syndrome for bitwise xor
    S = mod(S,2);
    %use syndrom to evaluate error 
    if(S(1)==1)
        %1xx
        if(S(2)==1)
            %11x
            if(S(3)==1)
                %111 -> a3 error 
                r(1) = ~r(1);
            else
                %110 -> a2 error
                r(2) = ~r(2);
            end
        else
            %10x
            if(S(3)==1)
                %101 -> a1 error
                r(3) = ~r(3);
            end
        end
    else
        %0xx
        if(S(2)==1 && S(3)==1)
            %011 -> a0 error 
            r(4) = ~r(4);
        end
    end
    %all other syndromes mean either no error, or error in parity bits
    c = r(1:4);
end

