function [ corrected ] = two_d_parity_block_decode(r, oep)
% TWO_D_PARITY_BLOCK_DECODE inputs:
    % r: block from received message encoded using two_d_parity_encoder(), with errors
    %                       outputs:
    % c: decoded block 
    
    m = max(size(r));
    s = oep*((m-oep-1)/(oep+1));
    n = m - s;
    rx_parities = r(s+1:end);
    parities = zeros(1,n);
    for i = 1:n-oep
        parities(i) = mod(sum(r(i:i+oep-1)),2);
    end
    for i = 1:oep
        parities(s/oep+i) = mod(sum(r(i:oep:s)),2);
    end
    parities(end) = mod(sum(parities(1:s/oep)),2);
    
    errs = xor(parities,rx_parities);
    err_indices = find(errs);
    if max(size(err_indices)) > 3
        corrected = r(1:s); % too many errors to correct, just return orignal message
        return;
    end
    c = r;
    if size(err_indices) > 1 % if less than 1, no errors are present
        row = err_indices(1);
        col = err_indices(2) - s/oep;
       
        error_i = col + (oep*(row-1));
        c(error_i) = ~r(error_i);
    end
    corrected = c(1:s);
end