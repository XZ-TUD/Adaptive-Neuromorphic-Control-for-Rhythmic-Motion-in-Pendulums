% This MATLAB script visualizes the effect of the self-excitation gain
% (g_f_minus) by plotting the system's nullcline. This demonstrates
% the saddle-node bifurcation at g_f^- = 1 and the transition to bistability.

clear;
clc;

% Define a range for the membrane potential, v_i
vi_range = linspace(-3, 3, 500);

% Define a function for the nullcline, which is the right-hand side of
% the fast dynamics equation simplified for no synaptic input:
% f(vi) = g_f^- * tanh(vi)
nullcline_func = @(gf, vi) gf * tanh(vi);

% Plot the identity line y = vi, which is where the fixed points are located
figure('Name', 'Bifurcation Analysis of Self-Excitation');
plot(vi_range, vi_range, 'k--', 'LineWidth', 1.5, 'DisplayName', '$y = v_i$ (Fixed Point Condition)');
hold on;

% --- Scenario 1: g_f^- < 1 (Single Stable Fixed Point)
gf1 = 0.8;
nullcline1 = nullcline_func(gf1, vi_range);
plot(vi_range, nullcline1, 'b', 'LineWidth', 2, 'DisplayName', ['$g_f^- = ', num2str(gf1), '$']);
plot(0, 0, 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 8, 'DisplayName', 'Stable Fixed Point');


% --- Scenario 2: g_f^- = 1 (Bifurcation Point)
gf2 = 1.0;
nullcline2 = nullcline_func(gf2, vi_range);
plot(vi_range, nullcline2, 'm', 'LineWidth', 2, 'DisplayName', ['$g_f^- = ', num2str(gf2), '$ (Bifurcation)']);
plot(0, 0, 'mo', 'MarkerFaceColor', 'm', 'MarkerSize', 8, 'DisplayName', 'Degenerate Fixed Point');


% --- Scenario 3: g_f^- > 1 (Bistable Regime)
gf3 = 1.5;
nullcline3 = nullcline_func(gf3, vi_range);
plot(vi_range, nullcline3, 'r', 'LineWidth', 2, 'DisplayName', ['$g_f^- = ', num2str(gf3), '$']);

% Find the fixed points numerically for this case
% We define the root-finding function: f(x) = x - gf*tanh(x)
root_func = @(x) x - gf3 * tanh(x);

% Use fsolve to find the two non-zero roots, providing initial guesses
% to guide the solver to the correct solutions.
stable_fp1 = fsolve(root_func, 1);
stable_fp2 = fsolve(root_func, -1);

% Plot the unstable fixed point at the origin
plot(0, 0, 'ro', 'MarkerSize', 8, 'DisplayName', 'Unstable Fixed Point');

% Plot the two stable fixed points
plot(stable_fp1, stable_fp1, 'r.', 'MarkerSize', 20, 'DisplayName', 'Stable Fixed Points');
plot(stable_fp2, stable_fp2, 'r.', 'MarkerSize', 20); % Don't need a second legend entry


hold off;
set(gca, 'FontSize', 14, 'FontName', 'Times New Roman');

% title('Saddle-Node Bifurcation due to Self-Excitation Gain ($g_f^-$)', 'Interpreter', 'latex');
xlabel('Membrane Potential, $v_i$', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Times New Roman');
ylabel('Nullcline Value', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Times New Roman');
legend('show', 'Location', 'southeast', 'Interpreter', 'latex', 'FontSize', 8, 'FontName', 'Times New Roman');
grid on;
