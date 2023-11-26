% 
% T = 1000; t = (1:T)/T;
% f_channel1 = (cos(2*pi*2*t)) + (1/16*(cos(2*pi*36*t))); % Channel 1 contains 2 Hz and 36Hz tones
% f_channel2 = (1/4*(cos(2*pi*24*t))) + (1/16*(cos(2*pi*36*t))); % Channel 2 contains 24 Hz and 36Hz tones
% f = [f_channel1;f_channel2]; % Making a bivariate signal
% [u, u_hat, omega] = MVMD(f, 2000, 0, 3, 0, 1, 1e-7); 
% Example 2: Real World Data (EEG Data)
% load('alpa_band_EEG01.mat');
[u, u_hat, omega] = MVMD(alpha_band, 2000, 0, 6, 0, 1, 1e-7);
%%
plot(omega)

%%
u = u';
for i = 1:size(u,2)
    subplot(size(u,2), 1, i);
    plot(u(:, i));
    title(['Plot ', num2str(i)]);
end
