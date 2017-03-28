function bit_sig = noisy_to_bits(in_sig)
%% takes noisy signal and rounds each value to nearest bit value of 0 or 1  
%INPUTS
%   in_sig : noisy signal  
%OUTPUTS
%   bit_sig : converted noisy signal to bit version of signal 
%%
    n = length(in_sig);
    for i=1:n
        if(in_sig(i)>=0.5)
            bit_sig(i) = 1;
        else
            bit_sig(i) = 0;
        end
    end