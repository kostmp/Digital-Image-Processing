%this function implements nearest neighbor for 'rggb' type
function rgbim = mynearest(red_image,green_image,blue_image,M,N)
%the rggb type is:
%red    green
%green  blue

%for every (i,j) pixel that is not assigned, gives the nearest value
%this is done for every channel separately
for i=1:M
    if mod(i,2) == 1
        %assigns value to i=1,3,5,7... row of the red or blue or green
        %image for every j column
        for j=2:2:N
            red_image(i,j) = red_image(i,j-1);
            green_image(i,j-1) = green_image(i,j);
            blue_image(i,j) = blue_image(i+1,j);
            blue_image(i,j-1) = blue_image(i+1,j);
        end
    elseif mod(i,2) == 0
        %assigns value to i=2,4,6,8... row of the red or blue or green
        %image for every j column
        for j=2:2:N
            green_image(i,j) = green_image(i,j-1);
            blue_image(i,j-1) = blue_image(i,j);
            red_image(i,j) = red_image(i-1,j);
            red_image(i,j-1) = red_image(i-1,j);
        end
    end
end
%the three different separate images(red,green,blue) becomes the RGB image
rgbim(:,:,1) = red_image;
rgbim(:,:,2) = green_image;
rgbim(:,:,3) = blue_image;
end