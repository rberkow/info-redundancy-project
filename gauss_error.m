function out_sig = gauss_error(in_sig,packet_length)
% INPUTS
%   in_sig : a vector of bits either 0 or 1  
%   packet_length: length of one packet
%OUTPUTS
%   out_sig : an output vector of the same length
%   with gaussian noise introduced 

%create channel which will introduce gaussian noise 
channel = comm.AWGNChannel('EbNo', 40, 'BitsPerSymbol', packet_length);
%pass the signal through the channel 
out_sig = channel.step(in_sig); 