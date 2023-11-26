load('erp_data.mat');
%%
[u_hands, u_hat_hands, omega_hands] = MVMD(erp_hands', 2000, 0, 6, 0, 1, 1e-7);
[u_feet, u_hat_feet, omega_feet] = MVMD(erps_feet', 2000, 0, 6, 0, 1, 1e-7);
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
save('output_data.mat', 'u_hands', 'u_hat_hands', 'omega_hands', 'u_feet', 'u_hat_feet', 'omega_feet');
