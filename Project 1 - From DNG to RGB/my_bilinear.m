%linear interpolation for rggb type
function Ccam = my_bilinear(red_image,green_image,blue_image,M,N)
[imageWidth,imageHeight] = size(red_image);

%fills all the pixels (i,j) in red image
for i=1:2:imageWidth-1
    for j=1:2:imageHeight-1
        %special cases where pixel (i,j) is at the bottom edges
        if j == imageHeight-1 || i == imageWidth-1
            red_image(i+1,j+1) = red_image(i,j);
            red_image(i,j+1) = red_image(i,j);
            red_image(i+1,j) = red_image(i,j);
        else
            red_image(i,j+1) = (red_image(i,j) + red_image(i,j+2))/2;
            red_image(i+1,j) = (red_image(i,j) + red_image(i+2,j))/2;
            red_image(i+1,j+1) = (red_image(i,j) + red_image(i,j+2) + red_image(i+2,j) + red_image(i+2,j+2))/4;
        end
    end
end

%assigns values to all (i,j) pixels the blue image
for i=2:2:imageWidth
    for j=2:2:imageHeight
        %special cases at the upper edges
        if i==2 || j==2
            blue_image(i-1,j-1) = blue_image(i,j);
            blue_image(i-1,j) = blue_image(i,j);
            blue_image(i,j-1) = blue_image(i,j);
        else
            blue_image(i-1,j-1) = (blue_image(i,j) + blue_image(i,j-2) + blue_image(i-2,j) + blue_image(i-2,j-2))/4;
            blue_image(i-1,j) = (blue_image(i,j) + blue_image(i-2,j))/2;
            blue_image(i,j-1) = (blue_image(i,j) + blue_image(i,j-2))/2;
        end
    end
end

%assigns values to all (i,j) pixels in green image
for i=1:imageWidth
    if mod(i,2) == 1  %fills the i=1,3,5... rows of pixels in green image
        for j=1:2:imageHeight-1
            %special cases at the upper edges
            if i==1 || i==imageWidth || j == 1
                green_image(i,j) = green_image(i,j+1);
            else 
                a = (green_image(i+1,j) + green_image(i-1,j) + green_image(i,j+1) + green_image(i,j-1))/4;
                green_image(i,j) = a;
            end
        end
    elseif mod(i,2) == 0 %assigns values to even rows of green image
        for j=2:2:imageHeight
            %special cases at the bottom edges
            if j == imageHeight || i == imageWidth
                green_image(i,j) = green_image(i,j-1);
            else
                a = (green_image(i+1,j) + green_image(i-1,j) + green_image(i,j+1) + green_image(i,j-1))/4;
                green_image(i,j) = a; 
            end
        end
    end
end
%combine the three images
Ccam(:,:,1) = red_image;
Ccam(:,:,2) = green_image;
Ccam(:,:,3) = blue_image;
rgb2xyz = [+3.2406 -1.5372 -0.4986;-0.9689 1.8758 0.0415;0.0557 -0.2040 1.0570];
rgb2xyz = rgb2xyz^-1;
end