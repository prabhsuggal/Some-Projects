%% Example: TV Denoising using MM
% TV denoising using an algorithm derived using majorization-minimization (MM)
% and solvers for sparse banded systems.
% See accompanying notes.
%
% Ivan Selesnick, selesi@nyu.edu, 2011.
% Revised 2017

%% Start

clear

printme = @(filename) print('-dpdf', sprintf('Example1_%s', filename));

%% Create data

s = load('blocks.txt');         % blocks signal
y = load('blocks_noisy.txt');   % noisy blocks signal

N = 256;                        % N : signal length
sigma = 0.5;                    % sigma : standard deviation of noise

figure(1)
clf
subplot(2,1,1)
plot(s)
ax = [0 N -3 6];
axis(ax)
title('Clean signal')

subplot(2,1,2)
plot(y)
axis(ax)
title('Noisy signal')

printme('fig1')

%% TV Denoising
% Run TV denoising algorithm (MM algorithm)

lam = 1.5;                         % lam: regularization parameter
Nit = 50;                          % Nit: number of iterations
[x, cost] = tvd_mm(y, lam, Nit);   % Run MM TV denoising algorithm

figure(2)
clf
subplot(2,1,1)
plot(1:Nit, cost, '.-')
title('Cost function history')
xlabel('Iteration')

subplot(2,1,2)
plot(x)
axis(ax)
title('TV denoising')

printme('fig2')

%% Compare two algorithms
% Compare convergence behavour of two algorithms:
% Iterative clipping and MM

[x, cost] = tvd_mm(y, lam, Nit);
[x2,cost2] = tvd_ic(y, 2*lam, Nit);

figure(1)
clf
plot(1:Nit, cost2/2,'--', 1:Nit, cost,'-')
legend('Iterative Clipping Algorithm','Majorization-Minimization Algorithm')
xlabel('Iteration')
title('Cost function history')

printme('fig3')


%% Optimality condition
% Illustrate optimality condition: abs(cumsum(x-y)) <= lambda

z = cumsum(x-y) / lam;

figure(1)
clf
subplot(2,1,1)
plot(z)
xlim([0 N])
line([0 N], [1 1], 'linestyle', '--')
line([0 N], -[1 1], 'linestyle', '--')
ylabel('s(n) / \lambda')
title('s(n) = cumsum(y-x)');

printme('optim')


%% Optimality scatter plot
% Illustrate optimality conidition using scatter plot diagram

z = cumsum(x-y);

m = 1.2*max(abs(diff(x)));

figure(1)
clf
plot([-m 0 0 m], [-1 -1 1 1], 'k', diff(x), z(1:end-1)/lam, 'or')
ylabel('cumsum(y-x) / \lambda')
xlabel('diff(x)')
xlim([-m m])

printme('optim_scatter')


