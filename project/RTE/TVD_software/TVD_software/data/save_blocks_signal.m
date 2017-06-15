%% save_blocks_signal

clear

N = 256;                        % N : signal length
s = MakeSignal('Blocks', N);    % s : noise-free signal
s = s(:);                       % convert to column 

randn('state',0);               % set seed of random number generator
                                % to reproduce noise signal
noise = 0.5 * randn(N, 1);
y = s + noise;                  % y : noisy signal

% Save data
save -ascii blocks.txt s
save -ascii blocks_noisy.txt y
