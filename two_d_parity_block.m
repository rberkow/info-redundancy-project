function [ c ] = two_d_parity_block(m, oep)
% TWO_D_PARITY_BLOCK inputs:
    % m: data bits to be encoded (row vector) should be length 4
    % oep: this is the number of bits per row
    %          ouptuts:
    % c: codeword. parity bits will be interspersed in the data
    % eg. m = 0000 encoding: 00 1
    %                        00 1
    %                        11 0
    % c = 001001110
    % only works on messages with length a multiple of 2
    
    s = max(size(m)); % should equal 64
    n = s/oep + oep + 1; % number of parities: 64/4 = 16 + 4 + 1 = 21
    parities = zeros(1,n);
    for i = 1:n-oep
        parities(i) = mod(sum(m(i:i+oep-1)),2);
    end
    for i = 1:oep
        parities(s/oep+i) = mod(sum(m(i:oep:s)),2);
    end
    parities(end) = mod(sum(parities(1:s/oep)),2);
    c = [m parities];
end