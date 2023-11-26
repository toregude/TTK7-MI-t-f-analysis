feet = load('mat/erp_feet.mat');
hand = load('mat/erp_hands.mat');

feet_data = feet.evoked_data;
hand_data = hand.evoked_data;
%%
K = 5;
[u_f, u_hat_f, omega_f] = MVMD(feet_data', 2000, 0, K, 0, 1, 1e-7);
[u_h u_hat_h, omega_h] = MVMD(hand_data', 2000, 0, K, 0, 1, 1e-7);

% [u_feet, u_hat_feet, omega_feet] = MVMD(erps_feet', 2000, 0, 6, 0, 1, 1e-7);
% %%
% % Create a dictionary with 6 arrays
% output_data = containers.Map;
% output_data('u_hands') = u_hands;
% output_data('u_hat_hands') = u_hat_hands;
% output_data('omega_hands') = omega_hands;
% output_data('u_feet') = u_feet;
% output_data('u_hat_feet') = u_hat_feet;
% output_data('omega_feet') = omega_feet;
% 
% % Save the dictionary to a MAT file
% save('output_data.mat', 'output_data');
% 
% 
% % Save the arrays individually to a MAT file

%%
%save('output_data.mat', 'u_hands', 'u_hat_hands', 'omega_hands', 'u_feet', 'u_hat_feet', 'omega_feet');

%%

ch1 = 13;
ch2= 13;
figure;
subplot(K+1,1,1);
hold on;
plot(feet_data(ch1,:));
plot(hand_data(ch2,:));

% subplot(K+1-4,2,2);
% plot(evoked_data(ch2,:));

for i = 1:K
    subplot(K+1, 1, i+1);
    hold on;
    plot(u_f(i,:,ch1));
    plot(u_h(i,:,ch2));

    % subplot(K+1-4, 2, 2*i+2);
    % plot(u(i,:,ch2));
end

%%
% Generate a sample signal
Fs = 512;          % Sampling frequency

[pxx1, f1] = pwelch(feet_data(ch1,:), [], [], [], Fs);
[pxx2, f2] = pwelch(hand_data(ch2,:), [], [], [], Fs);
figure;
ylim = [-40,0];

subplot(K+1,1,1);
hold on;
plot(f1(1:100), (pxx1(1:100)));
plot(f2(1:100), (pxx2(1:100)));
grid on;
ylim = [-40,0];
% subplot(K+1-4,2,2);
% plot(evoked_data(ch2,:));

for i = 1:K
    % Compute power spectral density using pwelch
    [pxx1, f1] = pwelch(u_f(i,:,ch1), [], [], [], Fs);
    [pxx2, f2] = pwelch(u_h(i,:,ch2), [], [], [], Fs);

    subplot(K+1, 1, i+1);
    hold on;
    plot(f1(1:100), (pxx1(1:100)));
    


    plot(f2(1:100), (pxx2(1:100)));
    ylim = [-40,0];
    grid on;
ylim = [-40,0];

    % subplot(K+1-4, 2, 2*i+2);
    % plot(u(i,:,ch2));
end

