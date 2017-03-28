block_size = 4;
gauss_BER = zeros(5,3);
burst_BER = zeros(5,3);
BER_gauss_before_decode = zeros(5,3);
BER_burst_before_decode = zeros(5,3);
gauss_BER_ratio = zeros(1,5);
burst_BER_ratio = zeros(1,5);
% Transmitter
iter = 5;
n = 1000;
for j=1:iter
    original_message = randi([0 1],1,64);
    for i=1:n
        encoded_message_2dparity = two_d_parity_encoder(original_message, block_size);
        encoded_message_TMR = bitwise_TMR_encoder(original_message);
        encoded_message_hamm = hamming_7_4_encoder(original_message);
        % Error channel
        encoded_message_2dparity_with_gauss_error = gauss_error(encoded_message_2dparity);
        encoded_message_2dparity_with_burst_error = burst_error(encoded_message_2dparity, block_size*2);
        encoded_message_TMR_with_gauss_error = gauss_error(encoded_message_TMR);
        encoded_message_TMR_with_burst_error = burst_error(encoded_message_TMR, block_size*2);
        encoded_message_hamm_with_gauss_error = gauss_error(encoded_message_hamm);
        encoded_message_hamm_with_burst_error = burst_error(encoded_message_hamm, block_size*2);
        % Check that error models are equivalent
        BER_gauss_before_decode(j,1) = BER_gauss_before_decode(j,1) + error_analysis(noisy_to_bits(encoded_message_2dparity_with_gauss_error), encoded_message_2dparity);
        BER_burst_before_decode(j,1) = BER_burst_before_decode(j,1) + error_analysis(noisy_to_bits(encoded_message_2dparity_with_burst_error), encoded_message_2dparity);
        BER_gauss_before_decode(j,2) = BER_gauss_before_decode(j,2) + error_analysis(noisy_to_bits(encoded_message_TMR_with_gauss_error), encoded_message_TMR);
        BER_burst_before_decode(j,2) = BER_burst_before_decode(j,2) + error_analysis(noisy_to_bits(encoded_message_TMR_with_burst_error), encoded_message_TMR);
        BER_gauss_before_decode(j,3) = BER_gauss_before_decode(j,3) + error_analysis(noisy_to_bits(encoded_message_hamm_with_gauss_error), encoded_message_hamm);
        BER_burst_before_decode(j,3) = BER_burst_before_decode(j,3) + error_analysis(noisy_to_bits(encoded_message_hamm_with_burst_error), encoded_message_hamm);
        % Receiver
        decoded_message_gauss_2dparity = two_d_parity_decoder(noisy_to_bits(encoded_message_2dparity_with_gauss_error), block_size);
        decoded_message_burst_2dparity = two_d_parity_decoder(noisy_to_bits(encoded_message_2dparity_with_burst_error), block_size);
        decoded_message_gauss_TMR = bitwise_TMR_decoder(noisy_to_bits(encoded_message_TMR_with_gauss_error));
        decoded_message_burst_TMR = bitwise_TMR_decoder(noisy_to_bits(encoded_message_TMR_with_burst_error));
        decoded_message_gauss_hamm = hamming_7_4_decoder(noisy_to_bits(encoded_message_hamm_with_gauss_error));
        decoded_message_burst_hamm = hamming_7_4_decoder(noisy_to_bits(encoded_message_hamm_with_burst_error));
        gauss_BER(j,1) = gauss_BER(j,1) + error_analysis(original_message, decoded_message_gauss_2dparity);
        burst_BER(j,1) = burst_BER(j,1) + error_analysis(original_message, decoded_message_burst_2dparity);
        gauss_BER(j,2) = gauss_BER(j,2) + error_analysis(original_message, decoded_message_gauss_TMR);
        burst_BER(j,2) = burst_BER(j,2) + error_analysis(original_message, decoded_message_burst_TMR);
        gauss_BER(j,3) = gauss_BER(j,3) + error_analysis(original_message, decoded_message_gauss_hamm);
        burst_BER(j,3) = burst_BER(j,3) + error_analysis(original_message, decoded_message_burst_hamm);
    end
end
BER_gauss_before_decode = BER_gauss_before_decode/n;
BER_burst_before_decode = BER_burst_before_decode/n;

gauss_BER = (gauss_BER/n);
burst_BER = (burst_BER/n);

gauss_BER_ratio = rdivide(gauss_BER,BER_gauss_before_decode);
burst_BER_ratio = rdivide(burst_BER,BER_burst_before_decode);
mean_gauss_BER_ratio = mean(gauss_BER_ratio)
mean_burst_BER_ratio = mean(burst_BER_ratio)