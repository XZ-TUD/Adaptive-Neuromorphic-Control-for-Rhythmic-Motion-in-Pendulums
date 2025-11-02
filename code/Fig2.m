% This MATLAB script visualizes the effect of synaptic gains (g_s+, g_s-, g_us+)
% on the neuron's v_i-nullcline. This illustrates how these parameters
% modulate the system's rhythmic behavior by shifting the nullcline.

clear;
clc;

% --- Parameters ---
% A high g_f- is needed to create the S-shaped nullcline
gf_minus = 1.5;

% Define a range for the membrane potential, v_i
vi_range = linspace(-3, 3, 500);

% Define the full v_i-nullcline equation as a function handle.
% We assume I_syn,ij and I_i are zero for this illustrative purpose.
% The variables v_s and v_us are treated as constants for each plot.
nullcline_func = @(vi, vs, vus, gs_plus, gs_minus, gus_plus) ...
    gf_minus * tanh(vi) - gs_plus * tanh(vs) + gs_minus * tanh(vs + 0.9) ...
    - gus_plus * tanh(vus + 0.9);

% Plot the line y=vi to find the fixed points
figure('Name', 'Synaptic Gain Effect on Nullcline');
plot(vi_range, vi_range, 'k--', 'LineWidth', 1.5, 'DisplayName', '$y = v_i$ (Fixed Points)');
hold on;

% --- Scenario 1: Effect of g_s+ (Inhibitory Gain) ---
% A larger g_s+ shifts the nullcline downwards, promoting a silent state.
vs_const = 0.5;
vus_const = 0;
gs_minus_const = 0.5;
gus_plus_const = 0.5;

gs_plus1 = 0.5;
nullcline1 = nullcline_func(vi_range, vs_const, vus_const, gs_plus1, gs_minus_const, gus_plus_const);
plot(vi_range, nullcline1, 'b', 'LineWidth', 2, 'DisplayName', ['$g_s^+ = ', num2str(gs_plus1), '$']);

gs_plus2 = 1.5;
nullcline2 = nullcline_func(vi_range, vs_const, vus_const, gs_plus2, gs_minus_const, gus_plus_const);
plot(vi_range, nullcline2, 'r', 'LineWidth', 2, 'DisplayName', ['$g_s^+ = ', num2str(gs_plus2), '$']);


% --- Scenario 2: Effect of g_s- (Excitatory Gain) ---
% A larger g_s- shifts the nullcline upwards, promoting a bursting state.
gs_plus_const2 = 0.5;
gs_minus1 = 0.2;
nullcline3 = nullcline_func(vi_range, vs_const, vus_const, gs_plus_const2, gs_minus1, gus_plus_const);
plot(vi_range, nullcline3, 'g--', 'LineWidth', 2, 'DisplayName', ['$g_s^- = ', num2str(gs_minus1), '$']);

gs_minus2 = 1.5;
nullcline4 = nullcline_func(vi_range, vs_const, vus_const, gs_plus_const2, gs_minus2, gus_plus_const);
plot(vi_range, nullcline4, 'm--', 'LineWidth', 2, 'DisplayName', ['$g_s^- = ', num2str(gs_minus2), '$']);


% --- Scenario 3: Effect of g_us+ (Ultra-slow Adaptive Gain) ---
% An increasing v_us shifts the nullcline downwards over time.
gus_plus_const2 = 2.0;
vs_const2 = 1.5;
vus1 = 0.0; % Initial value
nullcline5 = nullcline_func(vi_range, vs_const2, vus1, gs_plus_const2, gs_minus_const, gus_plus_const2);
plot(vi_range, nullcline5, 'c', 'LineWidth', 2, 'DisplayName', ['$g_{us}^+ = ', num2str(vus1), '$']);

vus2 = 1.5; % Value after a long period of activity
nullcline6 = nullcline_func(vi_range, vs_const2, vus2, gs_plus_const2, gs_minus_const, gus_plus_const2);
plot(vi_range, nullcline6, 'k', 'LineWidth', 2, 'DisplayName', ['$g_{us}^+ = ', num2str(vus2), '$']);


hold off;
set(gca, 'FontSize', 14, 'FontName', 'Times New Roman');
% title('Synaptic Gain Effects on $v_i$-Nullcline', 'Interpreter', 'latex');
xlabel('Membrane Potential, $v_i$', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Times New Roman');
ylabel('Nullcline Value', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Times New Roman');
legend('show', 'Location', 'southeast', 'Interpreter', 'latex', 'FontSize', 8, 'FontName', 'Times New Roman');
grid on;
