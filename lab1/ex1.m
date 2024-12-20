pkg load signal;

clear all; close all; clc;

f= 1000;
T= 1/f;

fs = 60 * f;
ts = 1/fs;
phi = 0;

t = 0 : ts : 1;

s1_t = 6*sin(2*pi*f*t);
s2_t = 2*sin(2*pi*3*f*t);
s3_t = 4*sin(2*pi*5*f*t);

sinal_somado = s1_t + s2_t + s3_t;

figure;
subplot(4,1,1); hold on; grid on;
plot(t, s1_t);
xlim([0 3*T]);
xlabel('Tempo (s)');
ylabel('Amplitude (V)');
title('Senos no tempo');

subplot(4,1,2); hold on; grid on;
plot(t, s2_t);
xlim([0 3*T]);
xlabel('Tempo (s)');
ylabel('Amplitude (V)');

subplot(4,1,3); hold on; grid on;
plot(t, s3_t);
xlim([0 3*T]);
xlabel('Tempo (s)');
ylabel('Amplitude (V)');

subplot(4,1,4); hold on; grid on;
plot(t, sinal_somado);
xlim([0 3*T]);
xlabel('Tempo (s)');
ylabel('Amplitude (V)');

% dominio da frequencia
passo_f = length(t)/(fs+1);
f_axis = -fs/2 : passo_f : fs/2;

X_fs1 = fft(s1_t)/length(s1_t);
X_fs1 = fftshift(X_fs1);

X_fs2 = fft(s2_t)/length(s2_t);
X_fs2 = fftshift(X_fs2);

X_fs3 = fft(s3_t)/length(s3_t);
X_fs3 = fftshift(X_fs3);

X_fst = fft(sinal_somado)/length(sinal_somado);
X_fst = fftshift(X_fst);

% falta colocar label
figure;
subplot(4,1,1); hold on; grid on;
plot(f_axis, abs(X_fs1));
xlabel('Frequência (Hz)');
ylabel('Magnitude');
title('Domínio da Frequência');

subplot(4,1,2); hold on; grid on;
plot(f_axis, abs(X_fs2));
xlabel('Frequência (Hz)');
ylabel('Magnitude');

subplot(4,1,3); hold on; grid on;
plot(f_axis, abs(X_fs3));
xlabel('Frequência (Hz)');
ylabel('Magnitude');

subplot(4,1,4); hold on; grid on;
plot(f_axis, abs(X_fst));
xlabel('Frequência (Hz)');
ylabel('Magnitude');

% calculando a potencia
potencia_media = 1/length(sinal_somado) * (norm(sinal_somado)).^2

% densidade espectral de potencia
[densidade_espectral, frequencias] = pwelch(sinal_somado, [], [], [], fs, 'shift', 'semilogy');

figure; hold on; grid on;
plot(frequencias, 10*log10(densidade_espectral));
xlim([-7000 7000]);
xlabel('Frequência (Hz)');
ylabel('Densidade espectral de potência (dB/Hz)');
title('Densidade Espectral de Potência usando pwelch');