function out_sig = gauss_error(in_sig)
% INPUTS
%   in_sig : a vector of bits either 0 or 1  
%OUTPUTS
%   out_sig : an output vector of the same length
%   with gaussian noise introduced 

%create channel which will introduce gaussian noise 
channel = comm.AWGNChannel('EbNo', 10);
%pass the signal through the channel 
out_sig = channel.step(in_sig); 
channel.reset();