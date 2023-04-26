%similar to mynearest.m but for grbg bayer type
function rgbim = mynearest_grbg(red_image,green_image,blue_image,M,N)
for i=1:M
    if mod(i,2) == 1
        for j=2:2:N
            green_image(i,j) = green_image(i,j-1);
            red_image(i,j-1) = red_image(i,j);
            blue_image(i,j) = blue_image(i+1,j-1);
            blue_image(i,j-1) = blue_image(i+1,j-1);
        end
    elseif mod(i,2) == 0
        %for j=1:imageHeight
         %   red_image(i,j) = red_image(i-1,j);
        %end
        for j=2:2:N
            blue_image(i,j) = blue_image(i,j-1);
            green_image(i,j-1) = green_image(i,j);
            red_image(i,j) = red_image(i-1,j);
            red_image(i,j-1) = red_image(i-1,j);
        end
    end
end
rgbim(:,:,1) = red_image;
rgbim(:,:,2) = green_image;
rgbim(:,:,3) = blue_image;
end