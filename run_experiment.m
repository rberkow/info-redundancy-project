block_size = 4;
%% Transmitter
original_message = repmat([0 0 1 0 0 1 1 1], 1, 8);
encoded_message = two_d_parity_encoder(original_message, block_size);
%% Error channel
encoded_message_with_error = gauss_error(encoded_message);
%% Receiver
decoded_message = two_d_parity_decoder(round(encoded_message_with_error), block_size);
BER = error_analysis(original_message,decoded_message);