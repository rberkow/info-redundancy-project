function [ corrected ] = two_d_parity_decoder(r, block_size)
% TWO_D_PARITY_DECODER inputs:
    % r: received codeword with errors potentially
    % block_size: size of block used in encoder (typically 4)
    %                  outputs:
    % corrected: the corrected message, parities removed
    n_parities = 5; % Just hard-coding this for now
    
    codeword_length = block_size + n_parities;
    n_blocks = max(size(r))/codeword_length;
    corrected = zeros(1, n_blocks*block_size);
    for i=0:n_blocks-1
        corrected(i*block_size+1:(i+1)*block_size) = two_d_parity_block_decode(r(i*codeword_length+1:(i+1)*codeword_length), block_size/2);
    end
end