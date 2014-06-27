%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EMG filtring: high pass 10Hz  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% EMG channel number
% EMGL : canal 129
% EMGR : canal 130

function eeg = filtrageEMG(BVexportfolder,filename)
  
    % selection of emg channels
    eeg = pop_loadbv(BVexportfolder,filename);
    emgl = eeg.data(129,:);
    emgr = eeg.data(130,:);

    %% Filter design
    % Transfer Function design
    % filter characteristics : IIR Butterworth
    n = 3; % filter order
    Wn = 10/512; % normalised cutoff frequency defined as Wn = 2 * Fc/sampling Frequence
    ftype = 'high';

    [b,a] = butter(n,Wn,ftype);  % filter coefficients
    h1=dfilt.df2(b,a);     % transfer function

    % Plot the filter 
    % hfvt=fvtool(h1,h2,'FrequencyScale','log');
    % legend(hfvt,'TF Design','ZPK Design')

    % Apply the filter to EMG data
    emgl_filtered = filter(b,a,emgl);
    emgr_filtered = filter(b,a,emgr);

    % save filtered data to the structure
    eeg.data(129,:) = emgl_filtered;
    eeg.data(130,:) = emgr_filtered;
end

