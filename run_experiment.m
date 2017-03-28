block_size = 4;
% Transmitter
original_message = repmat([0 0 1 0 0 1 1 1], 1, 8);
gauss_BER = zeros(1,2);
burst_BER = zeros(1,2);
BER_gauss_before_decode = zeros(1,2);
BER_burst_before_decode = zeros(1,2);
n = 1000;

for i=1:n
    encoded_message = two_d_parity_encoder(original_message, block_size);
    encoded_message_TMR = bitwise_TMR_encoder(original_message);
    % Error channel
    encoded_message_with_gauss_error = gauss_error(encoded_message);
    encoded_message_with_burst_error = burst_error(encoded_message, block_size*2);
    encoded_message_with_gauss_error_TMR = gauss_error(encoded_message_TMR);
    encoded_message_with_burst_error_TMR = burst_error(encoded_message_TMR, block_size*2);
    % Check that error models are equivalent
    BER_gauss_before_decode(1) = BER_gauss_before_decode(1) + error_analysis(noisy_to_bits(encoded_message_with_gauss_error), encoded_message);
    BER_burst_before_decode(1) = BER_burst_before_decode(1) + error_analysis(noisy_to_bits(encoded_message_with_burst_error), encoded_message);
    BER_gauss_before_decode(2) = BER_gauss_before_decode(2) + error_analysis(noisy_to_bits(encoded_message_with_gauss_error_TMR), encoded_message_TMR);
    BER_burst_before_decode(2) = BER_burst_before_decode(2) + error_analysis(noisy_to_bits(encoded_message_with_burst_error_TMR), encoded_message_TMR);
    % Receiver
    decoded_message_gauss = two_d_parity_decoder(noisy_to_bits(encoded_message_with_gauss_error), block_size);
    decoded_message_burst = two_d_parity_decoder(noisy_to_bits(encoded_message_with_burst_error), block_size);
    decoded_message_gauss_TMR = bitwise_TMR_decoder(noisy_to_bits(encoded_message_with_gauss_error_TMR));
    decoded_message_burst_TMR = bitwise_TMR_decoder(noisy_to_bits(encoded_message_with_burst_error_TMR));
    gauss_BER(1) = gauss_BER(1) + error_analysis(original_message, decoded_message_gauss);
    burst_BER(1) = burst_BER(1) + error_analysis(original_message, decoded_message_burst);
    gauss_BER(2) = gauss_BER(2) + error_analysis(original_message, decoded_message_gauss_TMR);
    burst_BER(2) = burst_BER(2) + error_analysis(original_message, decoded_message_burst_TMR);
end

BER_gauss_before_decode = BER_gauss_before_decode/n;
BER_burst_before_decode = BER_burst_before_decode/n;

gauss_BER = (gauss_BER/n);
burst_BER = (burst_BER/n);

gauss_BER_ratio = rdivide(gauss_BER,BER_gauss_before_decode)
burst_BER_ratio = rdivide(burst_BER,BER_burst_before_decode)