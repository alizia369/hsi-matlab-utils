

RGB = XYZ2sRGB_exgamma(XYZ);
RGB = max(RGB, 0);
RGB = min(RGB, 1);


%figure; imshow(RGB.^0.4, 'Border','tight'); 

%briten image
z = max(RGB(244,17,:));
RGB_clip = min(RGB, z)/z;
figure; imshow(RGB_clip.^0.4, 'Border','tight');
