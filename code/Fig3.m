% simulate_input_effect.m
% MATLAB script to visualize the effect of an external input current, I_i(t),
% on the neural nullcline and system dynamics. This script illustrates
% a neural bifurcation theorem by showing how a positive input current can
% trigger a transition from a silent to an active state.

clear; clc; close all;

% --- 1. Define Model Parameters ---
% Parameters for a generic firing-rate model that produces an S-shaped nullcline.
% We use these to ensure the presence of three fixed points.
a = 1.8;        % Scaling factor for the sigmoid function
b = 2.5;        % Slope of the sigmoid function
c = 1;          % Leak term (controls the slope of the nullcline)

% External input currents for different scenarios
I_i_silent = 0.1;   % Small positive input current (for silent state)
I_i_active = 1;   % Larger positive input current (triggers spiking)

% --- 2. Define the Nullcline Function ---
% The v_i-nullcline is defined by the fixed points of the system.
% The equation is of the form: v = f(v) + I_i
% where f(v) = a * tanh(b*v) - c*v.
% We will plot y = a * tanh(b*v) - c*v + I_i and find intersections with y=v.
nullcline_func = @(v, I_i) a * tanh(b * v) - c * v + I_i;

% --- 3. Generate Data Points for Plotting ---
% Create a range of v values for the x-axis
v_range = -2:0.01:2;

% Calculate the nullcline y-values for the silent case (I_i = 0.1)
nullcline_y_silent = nullcline_func(v_range, I_i_silent);

% Calculate the nullcline y-values for the active case (I_i = 0.5)
nullcline_y_active = nullcline_func(v_range, I_i_active);

% --- 4. Plot the Phase Portrait ---
figure;
hold on;
grid on;

% Plot the nullcline for the silent state (I_i = 0.1)
plot(v_range, nullcline_y_silent, 'b-', 'LineWidth', 2, 'DisplayName', 'Nullcline ($I_i=0.1$)');

% Plot the identity line (y=v_i)
plot(v_range, v_range, 'k--', 'LineWidth', 1.5, 'DisplayName', 'Identity Line ($y=v_i$)');

% Plot the nullcline for the active state (I_i = 0.5)
plot(v_range, nullcline_y_active, 'r-', 'LineWidth', 2, 'DisplayName', 'Nullcline ($I_i=0.5$)');

% Find and plot the fixed points for the silent case
intersections_silent = intersections(v_range, nullcline_y_silent, v_range, v_range, false);
scatter(intersections_silent, intersections_silent, 100, 'ko', 'filled', 'DisplayName', 'Fixed Points ($I_i=0.1$)');

% Find and plot the fixed points for the active case
intersections_active = intersections(v_range, nullcline_y_active, v_range, v_range, false);
scatter(intersections_active, intersections_active, 100, 'ro', 'filled', 'DisplayName', 'Fixed Points ($I_i=0.5$)');

% --- 5. Add Labels and Legend ---
xlabel('Membrane Potential, $v_i$', 'Interpreter', 'latex');
ylabel('Nullcline Value', 'Interpreter', 'latex');
% title('Effect of External Input $I_i(t)$ on the $v_i$-Nullcline', 'Interpreter', 'latex');
legend('show', 'Location', 'northwest', 'Interpreter', 'latex');
axis([-2 2 -2 2]);

hold off;

% A simple helper function to find intersections of two curves
function x0 = intersections(x1, y1, x2, y2, plot_flag)
    [x0, ~] = polyxpoly(x1, y1, x2, y2);
    if nargin < 5 || plot_flag
        plot(x0, x0, 'ro')
    end
end
