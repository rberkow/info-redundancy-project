function bit_sig = noisy_to_bits(in_sig)
    n = length(in_sig);
    for i=1:n
        if(in_sig(i)>=0.5)
            bit_sig(i) = 1;
        else
            bit_sig(i) = 0;
        end
    end