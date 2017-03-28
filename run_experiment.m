block_size = 4;
% Transmitter
original_message = repmat([0 0 1 0 0 1 1 1], 1, 8);
gauss_BER = 0;
burst_BER = 0;
BER_gauss_before_decode = 0;
BER_burst_before_decode = 0;
n = 1000;

for i=1:n
    encoded_message = two_d_parity_encoder(original_message, block_size);
    % Error channel
    encoded_message_with_gauss_error = gauss_error(encoded_message);
    encoded_message_with_burst_error = burst_error(encoded_message, block_size*2);
    % Check that error models are equivalent
    BER_gauss_before_decode = BER_gauss_before_decode + error_analysis(noisy_to_bits(encoded_message_with_gauss_error), encoded_message);
    BER_burst_before_decode = BER_burst_before_decode + error_analysis(noisy_to_bits(encoded_message_with_burst_error), encoded_message);
    % Receiver
    decoded_message_gauss = two_d_parity_decoder(noisy_to_bits(encoded_message_with_gauss_error), block_size);
    decoded_message_burst = two_d_parity_decoder(noisy_to_bits(encoded_message_with_burst_error), block_size);
    gauss_BER = gauss_BER + error_analysis(original_message, decoded_message_gauss);
    burst_BER = burst_BER + error_analysis(original_message, decoded_message_burst);
end

BER_gauss_before_decode = BER_gauss_before_decode/n;
BER_burst_before_decode = BER_burst_before_decode/n;

gauss_BER = (gauss_BER/n);
burst_BER = (burst_BER/n);

gauss_BER_ratio = gauss_BER/BER_gauss_before_decode
burst_BER_ratio = burst_BER/BER_burst_before_decode