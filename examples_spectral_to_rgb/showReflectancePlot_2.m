%function [ output_args ] = showReflectancePlot_2( input_args )

%2_SHOWREFLECTANCEPLOT Summary of this function goes here
%   Detailed explanation goes here

reflectance = squeeze(reflectances(141, 75,:));
figure; plot(400:10:720, reflectance);
xlabel('wavelength, nm');
ylabel('unnormalized reflectance');


%end

