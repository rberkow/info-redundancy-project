function [encoded] = two_d_parity_encoder(m, block_size)
% TWO_D_PARITY_ENCODER inputs:
    % m: message (must be divisible by 4 - our block length)
    % block_length: block length (typically 4)
    %                  ouputs:
    % encoded: the encoded message. Parity bits will be interspersed
    
    oep = block_size;
    if mod(max(size(m)),oep) ~= 0
        error('message length must be divisible by 4');
    end
    s = max(size(m));
    n_blocks = s/oep;
    n_parities = oep+1;
    encoded = zeros(1, s + n_parities*n_blocks);
    for i=0:n_blocks-1
        % Sorry about this incredibly ugly indexing
        encoded(i*(oep + n_parities)+1:((i+1)*(oep+n_parities))) = two_d_parity_block(m(i*oep+1:(i+1)*oep),oep/2);
    end
end