function [ c ] = two_d_parity(m)
% TWO_D_PARITY inputs:
    % m: data bits to be encoded (row vector)
    % c: codeword. parity bits will be interspersed in the data
    % eg. m = 0000 encoding: 00 1
    %                        00 1
    %                        11 0
    % c = 001001110
    % only works on messages with length a multiple of 4
    
    oep = 4; % one error can be corrected per 4 bits
    
    if mod(max(size(m)),oep) ~= 0
        error('message length must be divisible by 4');
    end
    s = max(size(m)); % should equal 64
    n = s/oep + oep + 1; % number of parities: 64/4 = 16 + 4 + 1 = 21
    parities = zeros(1,n);
    for i = 1:n-oep
        parities(i) = mod(sum(m(i:i+oep-1)),2);
    end
    for i = 1:oep
        parities(s/oep+i) = mod(sum(m(i:oep:s)),2);
    end
      c = [m parities];
end