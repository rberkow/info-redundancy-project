function BER = error_analysis(org_sig, out_sig)
%% INPUTS
%   org_sig : original signal before encoding  
%   out_sig: decoded signal - afer error-correction 
%OUTPUTS
%   BER : Bit Error Rate - computed as the number of errors, divided  by
%   the number of bits 
%%
num_bits = length(org_sig);
err_count = 0;
for i = 1:num_bits
    if(org_sig(i)~=out_sig(i))
        err_count = err_count+1;
    end
end
BER = err_count/num_bits;
