clear all
close all


% Simulate data
mynoise = noise(512,100,512);                 % One second, 10 epochs, srate = 512 Hz
peak1 = peak(512,100,512,10,100,5);             % 10 Hz peak at 100 samples (195 ms)
peak2 = peak(512,100,512,10,200,5);
mysignal = 2*peak1 - 3*peak2 + mynoise;

figure; plot(mysignal)

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
%EEG = pop_importdata('dataformat','array','nbchan',0,'data','mysignal','srate',512,'pnts',512,'xmin',0);
EEG = pop_importdata('dataformat','array','nbchan',0,'data','mysignal','srate',512,'xmin',0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'setname','mysignal','gui','off'); 

eeglab redraw

% Lowpass

%FIR
EEG = pop_eegfilt( EEG, 0.1, 0, [], [0], 0, 0, 'fir1', 0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','mysignal_FIR0.1','gui','off'); 

%Butterworth
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET,'retrieve',1,'study',0); 
EEG  = pop_basicfilter( EEG,  1 , 'Cutoff',  0.1, 'Design', 'butter', 'Filter', 'highpass', 'Order',  6 ); % Ne marche pas (car pas d'event), à faire à la main
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','mysignal_butt0.1','gui','off'); 



figure; plot(ALLEEG(1,1).data(1,1:1000))
hold on
plot(ALLEEG(1,2).data(1,1:1000), 'r')
hold on
plot(ALLEEG(1,3).data(1,1:1000), 'g')
hgsave('testfiltfirbutt_01')


% Highpass

ALLEEG = pop_delset( ALLEEG, [2  3] );

%FIR
EEG = pop_eegfilt( EEG, 0, 120, [], [0], 0, 0, 'fir1', 0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','mysignal_FIR0.1','gui','off'); 

%Butterworth
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET,'retrieve',1,'study',0); 

EEG  = pop_basicfilter( EEG,  1 , 'Cutoff',  120, 'Design', 'butter', 'Filter', 'lowpass', 'Order',  6 );
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','mysignal_butt120','gui','off'); 

figure; plot(ALLEEG(1,1).data(1,1:1000))
hold on
plot(ALLEEG(1,2).data(1,1:1000), 'r')
hold on
plot(ALLEEG(1,3).data(1,1:1000), 'g')
hgsave('testfiltfirbutt_120')

%% 2 pics à 10 Hz

clear all 
close all

% Simulate data
mynoise = noise(50000,1,512);                 % 100 seconds, one epoch, srate = 512 Hz
peak1 = peak(50000,1,512,10,10000,5);             % 10 Hz peak at 1000 samples (195 ms)
peak2 = peak(50000,1,512,10,20000,5);
mysignal = 3*peak1 - 4*peak2 + mynoise;

figure; plot(mysignal)

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
%EEG = pop_importdata('dataformat','array','nbchan',0,'data','mysignal','srate',512,'pnts',512,'xmin',0);
EEG = pop_importdata('dataformat','array','nbchan',0,'data','mysignal','srate',512,'xmin',0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'setname','mysignal','gui','off'); 

eeglab redraw

% Lowpass

%FIR

EEG = pop_eegfilt( EEG, 0.1, 0, [], [0], 0, 0, 'fir1', 0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','mysignal_FIR0.1','gui','off'); 

%Butterworth 0.1
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET,'retrieve',1,'study',0); 
EEG  = pop_basicfilter( EEG,  1 , 'Cutoff',  0.1, 'Design', 'butter', 'Filter', 'highpass', 'Order',  6 ); % Ne marche pas (car pas d'event), à faire à la main
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','mysignal_butt0.1','gui','off'); 

%Butterworth 0.5
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET,'retrieve',1,'study',0); 
EEG  = pop_basicfilter( EEG,  1 , 'Cutoff',  0.5, 'Design', 'butter', 'Filter', 'highpass', 'Order',  6 ); % Ne marche pas (car pas d'event), à faire à la main
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','mysignal_butt0.5','gui','off'); 

%Butterworth 1
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET,'retrieve',1,'study',0); 
EEG  = pop_basicfilter( EEG,  1 , 'Cutoff',  1, 'Design', 'butter', 'Filter', 'highpass', 'Order',  6 ); % Ne marche pas (car pas d'event), à faire à la main
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','mysignal_butt1','gui','off'); 


figure; plot(ALLEEG(1,1).data(1,1:30000))
hold on
plot(ALLEEG(1,2).data(1,1:30000), 'r')
hold on
plot(ALLEEG(1,3).data(1,1:30000), 'g')
hold on
plot(ALLEEG(1,4).data(1,1:30000), 'black')
hold on
plot(ALLEEG(1,5).data(1,1:30000), 'yellow')
hgsave('testfiltfirbutt_01_2')


% Highpass

ALLEEG = pop_delset( ALLEEG, [2:5] );

%FIR
EEG = pop_eegfilt( EEG, 0, 120, [], [0], 0, 0, 'fir1', 0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','mysignal_FIR120','gui','off'); 

%Butterworth
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET,'retrieve',1,'study',0); 

EEG  = pop_basicfilter( EEG,  1 , 'Cutoff',  120, 'Design', 'butter', 'Filter', 'lowpass', 'Order',  6 );
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','mysignal_butt120','gui','off'); 

figure; plot(ALLEEG(1,1).data(1,1:30000))
hold on
plot(ALLEEG(1,2).data(1,1:30000), 'r')
hold on
plot(ALLEEG(1,3).data(1,1:30000), 'g')
hgsave('testfiltfirbutt_120_2')


%% 2 pics à 50 et 100 Hz

clear all 
close all

% Simulate data

mynoise = noise(50000,1,512);                 % 100 seconds, one epoch, srate = 512 Hz
peak1 = peak(50000,1,512,50,10000,5);             % 50 Hz peak at 10000 samples 
peak2 = peak(50000,1,512,100,20000,5);              % 100 Hz peak at 20000 samples 
mysignal = 4*peak1 - 5*peak2 + mynoise;

figure; plot(mysignal)

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
%EEG = pop_importdata('dataformat','array','nbchan',0,'data','mysignal','srate',512,'pnts',512,'xmin',0);
EEG = pop_importdata('dataformat','array','nbchan',0,'data','mysignal','srate',512,'xmin',0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'setname','mysignal','gui','off'); 

eeglab redraw


% Highpass

%FIR
EEG = pop_eegfilt( EEG, 0, 120, [], [0], 0, 0, 'fir1', 0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','mysignal_FIR120','gui','off'); 

%Butterworth
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET,'retrieve',1,'study',0); 

EEG  = pop_basicfilter( EEG,  1 , 'Cutoff',  120, 'Design', 'butter', 'Filter', 'lowpass', 'Order',  6 );
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','mysignal_butt120','gui','off'); 

figure; plot(ALLEEG(1,1).data(1,1:30000))
hold on
plot(ALLEEG(1,2).data(1,1:30000), 'r')
hold on
plot(ALLEEG(1,3).data(1,1:30000), 'g')
hgsave('testfiltfirbutt_120_50_100')

%% Test epochs

clear all
close all


% Simulate data
mynoise = noise(512,100,512);                 % One second, 10 epochs, srate = 512 Hz
peak1 = peak(512,100,512,10,100,5);             % 10 Hz peak at 100 samples (195 ms)
peak2 = peak(512,100,512,10,200,5);
mysignal = 2*peak1 - 3*peak2 + mynoise;

figure; plot(mysignal)

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_importdata('dataformat','array','nbchan',0,'data','mysignal','srate',512,'pnts',512,'xmin',0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'setname','mysignal','gui','off'); 

eeglab redraw

