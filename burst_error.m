function out_sig = burst_error(in_sig, packet_length)
% INPUTS
%   in_sig : a vector of bits of either 0 or 1  
%   packet_length: length of one packet
%OUTPUTS
%   out_sig : an output vector of the same length
%   with burst error introduced 


%gb: probability of transferring from Good state to Bad state
%bg: probability of transferring from Bad state to Good state

%given these values a pattern of "packet" loss will 
%be generated and applied to the input signal 
gb = 0.1;
bg = 0.25;
num_packets = length(in_sig)/packet_length; 

good_state = 1; % 1 if in good state, 0 if in bad state 

%error channel that is used to introduce error into pakcets 
good_channel = comm.AWGNChannel('EbNo', 40);
bad_channel = comm.AWGNChannel('EbNo', 0);
out_sig = in_sig;
size = 1;
while size <= num_packets
    start_index = (size-1)*packet_length+1;
    end_index = start_index + packet_length-1;
    if good_state == 1 
        %inroduce small error into packet
        out_sig(start_index:end_index) = good_channel.step(in_sig(start_index:end_index)); 
        good_state = rand(1) > gb;
    elseif good_state == 0
        %introduce large error into packet 
        out_sig(start_index:end_index) = bad_channel.step(in_sig(start_index:end_index)); 
        good_state = rand(1) > (1-bg);
    else
        %error invalid value for good_state  
    end
    size = size+1;
end

        