%%%%%%
% Practicum 3
% Ellisa Booker
%%%%%
clear all;
close all;
%% Signal Generation Code

N = 1e5;                          	% number of bits transmitted 
SNR_dB = 5;                       	% signal-to-noise ratio in dB   
v = 10^(SNR_dB/20);                 	% transmit signal magnitude 
signal = randi([0 1], N, 1);      	% bit stream with 0's & 1's 
noise = randn(N,1);               	% additive Gaussian noise 
received = (signal*2-1)*v + noise; 	% received noisy signal 
detect = (received > 0);          	% detected result 
num_error = sum(abs(detect-signal));  % # of erroneously detected bits fprintf('%d bits are transmitted; %d error bits\n', N, num_error) 
fprintf('%d bits are transmitted; %d error bits\n', N, num_error)

%%
%Part 1 and 2

theoreticalBER = normcdf(-v)
simulatedBER = num_error/N

%%
%Part 3

expBER(1:21)=0; %Declaring arrays of BERs
therBER(1:21)=0;


% Find BER values for SNR between -10 and 10
j = 1;
for i=-10:10 
    %Regenerate new signal with i = SNR_db
    
    v = 10^(i/20);
    signal = randi([0 1], N, 1);      	% bit stream with 0's & 1's 
    noise = randn(N,1);               	% additive Gaussian noise 
    received = (signal*2-1)*v + noise; 	% received noisy signal 
    detect = (received > 0);          	% detected result 
    num_error = sum(abs(detect-signal));  % # of erroneously detected bits fprintf('%d bits are transmitted; %d error bits\n', N, num_error) 

    %Recalculate experimental and theoretical BER, then insert into array
    expBER(j) = normcdf(-v);
    therBER(j) = num_error/N;
     
    %Increment array index counter 
     j = j+1;
end

%% Plotting Section

figure(1)
semilogy([-10:10], expBER) %Plot experimental BER

hold on

semilogy([-10:10],therBER,'o') %Plot theoretical BER

xlim([-10 10]) %Graph from -10 < x < 20dB
ylim([10^-3 1]) %Graph from 10^-3 < Y < 10^0

xlabel('Input SNR (dB)') %Label axis
ylabel('BER')

grid on

hold off
