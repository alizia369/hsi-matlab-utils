

load illum_25000.mat;
radiances_25000 = zeros(size(reflectances)); % initialize array
for i = 1:33,
  radiances_25000(:,:,i) = reflectances(:,:,i)*illum_25000(i);
end
radiance_25000 = squeeze(radiances_25000(141, 75, :));
figure; plot(400:10:720, radiance_25000, 'b'); % blue curve
xlabel('wavelength, nm');
ylabel('radiance, arbitrary units');
hold on;


% Another Radiance

load illum_4000.mat;
radiances_4000 = zeros(size(reflectances)); % initialize array
for i = 1:33,
  radiances_4000(:,:,i) = reflectances(:,:,i)*illum_4000(i);
end
radiance_4000 = squeeze(radiances_4000(141, 75, :));
plot(400:10:720, radiance_4000, 'r'); % red curve