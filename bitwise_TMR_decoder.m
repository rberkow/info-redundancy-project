function [ corrected ] = bitwise_TMR_decoder( r )
%Decodes the bitwise TMR passed signal 
%INPUTS:
%   r: block from received message encoded using bitwise_TMR_block
%   with errors 
%OUTPUTS:
%   corrected: decoded and corrected block that selects majority bit
%   for every 3 bits, e.g 010 000 110 -> 001

m = max(size(r));
n = m/3;
corrected = zeros(1,n);
for i = 1:n
    bits_one = 0;
    start_ind = 3*(i-1)+1;
    end_ind = start_ind + 2;
    %in block of 3 bits in received message, determine
    %if it represents a 1 or 0 in original message 
    for j = start_ind:end_ind
        if(r(j)==1)
            bits_one = bits_one +1;
        end
    end
    if(bits_one>=2)
        corrected(i) = 1;
    else
        corrected(i) = 0;
    end
end

end

