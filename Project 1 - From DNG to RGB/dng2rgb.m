function [Csrgb , Clinear,Cxyz, Ccam] = dng2rgb(rawim , XYZ2Cam , wbcoeffs ,bayertype , method , M, N)
    %define the dimensions M,N to be the initials
    [rows,cols] = size(rawim);
    M=rows;
    N=cols;
 
    switch bayertype         %depend on the bayertype 
        case 'rggb'
            %white balancing the raw image
            mask = wbmask(size(rawim,1),size(rawim,2),wbcoeffs,bayertype);
            balanced_bayer = rawim.* mask;
            %define matrices for red,green and blue images to have the type
            %of the bayer type
            bayer_red = repmat([1 0; 0 0], ceil(M/2),ceil(N/2));
            bayer_blue = repmat([0 0; 0 1], ceil(M/2),ceil(N/2));
            bayer_green = repmat([0 1; 1 0], ceil(M/2),ceil(N/2));
            red_image = balanced_bayer.*bayer_red;
            blue_image = balanced_bayer.*bayer_blue;
            green_image = balanced_bayer.*bayer_green;
            %depends on the method calls the right function for demosaicing
            if strcmp(method,'nearest')
                Ccam = mynearest(red_image,green_image,blue_image,M,N);
            elseif strcmp(method,'linear')
                Ccam = my_bilinear(red_image,green_image,blue_image,M,N);
            end
        case 'bggr'
            mask = wbmask(size(rawim,1),size(rawim,2),wbcoeffs,bayertype);
            balanced_bayer = rawim.* mask;
            bayer_red = repmat([0 0; 0 1], ceil(M/2),ceil(N/2));
            bayer_blue = repmat([1 0; 0 0], ceil(M/2),ceil(N/2));
            bayer_green = repmat([0 1; 1 0], ceil(M/2),ceil(N/2));
            red_image = balanced_bayer.*bayer_red;
            blue_image = balanced_bayer.*bayer_blue;
            green_image = balanced_bayer.*bayer_green;
            if strcmp(method,'nearest')
                Ccam = mynearest_bggr(red_image,green_image,blue_image,M,N);
            elseif strcmp(method,'linear')
                Ccam = mybilinear_bggr(red_image,green_image,blue_image,M,N);
            end
        case 'gbrg'
            mask = wbmask(size(rawim,1),size(rawim,2),wbcoeffs,bayertype);
            balanced_bayer = rawim.* mask;
            bayer_red = repmat([0 0; 1 0], ceil(M/2),ceil(N/2));
            bayer_blue = repmat([0 1; 0 0], ceil(M/2),ceil(N/2));
            bayer_green = repmat([1 0; 0 1], ceil(M/2),ceil(N/2));
            red_image = balanced_bayer.*bayer_red;
            blue_image = balanced_bayer.*bayer_blue;
            green_image = balanced_bayer.*bayer_green;
            if strcmp(method,'nearest')
                Ccam = mynearest_gbrg(red_image,green_image,blue_image,M,N);
            elseif strcmp(method,'linear')
                Ccam = my_bilinear_gbrg(red_image,green_image,blue_image,M,N);
            end
        case 'grbg'
            mask = wbmask(size(rawim,1),size(rawim,2),wbcoeffs,bayertype);
            balanced_bayer = rawim.* mask;
            bayer_red = repmat([0 1; 0 0], ceil(M/2),ceil(N/2));
            bayer_blue = repmat([0 0; 1 0], ceil(M/2),ceil(N/2));
            bayer_green = repmat([1 0; 0 1], ceil(M/2),ceil(N/2));
            red_image = balanced_bayer.*bayer_red;
            blue_image = balanced_bayer.*bayer_blue;
            green_image = balanced_bayer.*bayer_green;
            if strcmp(method,'nearest')
                Ccam = mynearest_grbg(red_image,green_image,blue_image,M,N);
            elseif strcmp(method,'linear')
                Ccam = my_bilinear_grbg(red_image,green_image,blue_image,M,N);
            end
    end
    %this matrix is for the transform from XYZ to RGB
    rgb2xyz = [+3.2406 -1.5372 -0.4986;-0.9689 1.8758 0.0415;0.0557 -0.2040 1.0570];
    rgb2xyz = rgb2xyz^-1; %RGB to XYZ transformation
    Cxyz=apply_cmatrix(Ccam,XYZ2Cam^-1); %computes image Cxyz
    rgb2cam = XYZ2Cam * rgb2xyz; % Assuming previously defined matrices
    rgb2cam = rgb2cam ./ repmat(sum(rgb2cam,2),1,3); % Normalize rows to 1
    cam2rgb = rgb2cam^-1;
    %Clinear image
    Clinear = apply_cmatrix(Ccam, cam2rgb);
    Clinear = max(0,min(Clinear,1)); 
%bright the image
    grayim = rgb2gray(Clinear);
    grayscale = 0.25/mean(grayim(:));
    bright_srgb = min(1,Clinear*grayscale);

    %nonlinear correction
    Csrgb = bright_srgb.^(1/2.2);

end