feet = load('mat/erp_feet.mat');
hand = load('mat/erp_hands.mat');

feet_data = feet.evoked_data;
hand_data = hand.evoked_data;

% Fs = 512;          % Sampling frequency
% cutoff_frequency = 40;  % Cutoff frequency in Hz
% 
% % Design a Butterworth low-pass filter
% order = 4;  % Filter order
% [b, a] = butter(order, cutoff_frequency/(Fs/2), 'low');
% 
% 
% for i = 1:size(hand_data, 1)
%     feet_data(i, :) = filter(b, a, feet_data(i, :));
%     hand_data(i, :) = filter(b, a, hand_data(i, :));
% end
%%
K = 4;
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
t = linspace(-1,round((length(hand_data(1,:))-512)/512),length(hand_data(1,:)));
ch1 = 2;
ch2= 2;
figure('Position', [10 10 1000 1000]);
subplot(K+1-2,1,1);
hold on;
plot(t,feet_data(ch1,:));
plot(t,hand_data(ch2,:));
legend('Feet', 'Hand')
title("ERP Subject 2");
xlabel('Seconds');
ylabel('μV');
grid on;
% subplot(K+1-4,2,2);
% plot(evoked_data(ch2,:));
titles = ["IMF 4 Subject 2", "IMF 3 Subject 2"];
for i = 1:K-2
    subplot(K+1-2, 1, i+1);
    hold on;
    plot(t,u_f(i,:,ch1));
    plot(t,u_h(i,:,ch2));
    legend('Feet', 'Hand');
    title(titles(i));
    grid on;
    xlabel('Seconds');
    ylabel('μV');

    % subplot(K+1-4, 2, 2*i+2);
    % plot(u(i,:,ch2));
end
% saveas(gcf, 'IMF2.png');
% Generate a sample signal
Fs = 512;          % Sampling frequency

[pxx1, f1] = pwelch(feet_data(ch1,:), [], [], [], Fs);
[pxx2, f2] = pwelch(hand_data(ch2,:), [], [], [], Fs);
figure('Position', [10 10 1000 1000]);


subplot(K+1-2,1,1);
hold on;
plot(f1(1:60), (pxx1(1:60)));
plot(f2(1:60), (pxx2(1:60)));
grid on;
ylim = [-40,0];
legend('Feet', 'Hand');
title("PDS of ERP Subject 2");
xlabel('Hz');
ylabel('(μV)^2/Hz');
% subplot(K+1-4,2,2);
% plot(evoked_data(ch2,:));
titles = ["PDS of IMF 4 Subject 2", "PDS of IMF 3 Subject 2"];
for i = 1:K-2
    % Compute power spectral density using pwelch
    [pxx1, f1] = pwelch(u_f(i,:,ch1), [], [], [], Fs);
    [pxx2, f2] = pwelch(u_h(i,:,ch2), [], [], [], Fs);

    subplot(K+1-2, 1, i+1);
    hold on;
    plot(f1(1:60), (pxx1(1:60)));

    plot(f2(1:60), (pxx2(1:60)));
    grid on;
    legend('Feet', 'Hand')
    title(titles(i));
    xlabel('Hz');
    ylabel('(μV)^2/Hz');

    
    % subplot(K+1-4, 2, 2*i+2);
    % plot(u(i,:,ch2));
end
% saveas(gcf, 'ERP2.png');


[S_h, F_h, T_h] = spectrogram(hand_data(ch1,:), 50, 48, 64, Fs);
freq_limit_index = find(F_h <= 30, 1, 'last');
S_h = S_h(1:freq_limit_index, :);
F_h = F_h(1:freq_limit_index);
T_h = T_h -1;

[S_f, F_f, T_f] = spectrogram(feet_data(ch1,:), 50, 48, 64, Fs);
freq_limit_index = find(F <= 30, 1, 'last');
S_f = S_f(1:freq_limit_index, :);
F_f = F_f(1:freq_limit_index);
T_f = T_f -1;


figure('Position', [10 10 1000 1000]);


subplot(K+1-2,2,1);
hold on;
helperCWTTimeFreqPlot(S_f, T_f, F_f, 'surf', 'STFT of ERP Feet Subject 2', 'Seconds', 'Hz');


grid on;
% title("PDS of ERP");

subplot(K+1-2,2,2);
hold on;
helperCWTTimeFreqPlot(S_h, T_h, F_h, 'surf', 'STFT of ERP Hand Subject 2', 'Seconds', 'Hz');
grid on;
% title("PDS of ERP");

titles = ["STFT of IMF 4 Feet Subject 2", "STFT of IMF 4 Hand Subject 2", "STFT of IMF 3 Feet Subject 2", "STFT of IMF 3 Hand Subject 2"];
for i = 1:K-2
    [S_h, F_h, T_h] = spectrogram(u_h(i,:,ch1), 50, 48, 64, Fs);
    freq_limit_index = find(F_h <= 30, 1, 'last');
    S_h = S_h(1:freq_limit_index, :);
    F_h = F_h(1:freq_limit_index);

    T_h = T_h-1;


    [S_f, F_f, T_f] = spectrogram(u_f(i,:,ch1), 50, 48, 64, Fs);
    freq_limit_index = find(F_h <= 30, 1, 'last');
    S_f = S_f(1:freq_limit_index, :);
    F_f = F_f(1:freq_limit_index);

    T_f = T_f-1;


    subplot(K+1-2, 2, 2*i+1);
    hold on;
    helperCWTTimeFreqPlot(S_f, T_f, F_f, 'surf', 'STFT of ERP (30 Hz)', 'Seconds', 'Hz');
    grid on;
    title(titles(2*i-1));

    subplot(K+1-2, 2, 2*i+2);
    hold on;
    helperCWTTimeFreqPlot(S_h, T_h, F_h, 'surf', 'STFT of ERP (30 Hz)', 'Seconds', 'Hz');
    grid on;
    title(titles(2*i));

end
saveas(gcf, 'CWT2.png');

