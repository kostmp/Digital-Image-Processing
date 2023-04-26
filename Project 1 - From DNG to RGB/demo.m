clear all; %clear previous values
[rawim ,XYZ2Cam ,wbcoeffs ] = readdng('RawImage.DNG'); %read raw format of .DNG image
%define parameters of M, N, bayertype ('rggb,'gbrg','grbg','bggr') and
%method (linear or nearest)
bayertype = 'rggb';
method = 'linear';
M=4000;
N=6000;
disp('This will take a while... :)');
%from raw format of dng to RGB format
[Csrgb , Clinear , Cxyz, Ccam] = dng2rgb(rawim , XYZ2Cam , wbcoeffs ,bayertype , method , M, N);
%show Ccam figure with its histograms for R,G,B respectively
figure('Name','Ccam','NumberTitle','off');, imshow(Ccam);
R=imhist(Ccam(:,:,1));
G=imhist(Ccam(:,:,2));
B=imhist(Ccam(:,:,3));
figure('Name','Histogram of Ccam','NumberTitle','off');
plot(R,'r');
hold on;
plot(G,'g');
plot(B,'b');
legend('Red Channel','Green Channel', 'Blue Channel');
hold off;

%show the image Cxyz with its histograms R,G,B
figure('Name','Cxyz','NumberTitle','off'), imshow(Cxyz);
R=imhist(Cxyz(:,:,1));
G=imhist(Cxyz(:,:,2));
B=imhist(Cxyz(:,:,3));
figure('Name','Histogram of Cxyz','NumberTitle','off');
plot(R,'r');
hold on;
plot(G,'g');
plot(B,'b');
legend('Red Channel','Green Channel', 'Blue Channel');
hold off;

%show Clinear image with its histograms R,G,B
figure('Name','Clinear','NumberTitle','off');, imshow(Clinear);
R=imhist(Clinear(:,:,1));
G=imhist(Clinear(:,:,2));
B=imhist(Clinear(:,:,3));
figure('Name','Histogram of Clinear','NumberTitle','off');
plot(R,'r');
hold on;
plot(G,'g');
plot(B,'b');
legend('Red Channel','Green Channel', 'Blue Channel');
hold off;


%show Csrgb image with its histograms
figure('Name','Csrgb','NumberTitle','off');, imshow(Csrgb);
R=imhist(Csrgb(:,:,1));
G=imhist(Csrgb(:,:,2));
B=imhist(Csrgb(:,:,3));
figure('Name','Histogram of Csrgb','NumberTitle','off');
plot(R,'r');
hold on;
plot(G,'g');
plot(B,'b');
legend('Red Channel','Green Channel', 'Blue Channel');
hold off;
