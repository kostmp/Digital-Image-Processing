%similar to my_bilinear but for bggr bayer type
function rgbim = mybilinear_bggr(red_image,green_image,blue_image,imageWidth,imageHeight)
for i=1:2:imageWidth-1
    for j=1:2:imageHeight-1
        if j == imageHeight-1 || i == imageWidth-1
            blue_image(i+1,j+1) = blue_image(i,j);
            blue_image(i,j+1) = blue_image(i,j);
            blue_image(i+1,j) = blue_image(i,j);
        else
            blue_image(i,j+1) = (blue_image(i,j) + blue_image(i,j+2))/2;
            blue_image(i+1,j) = (blue_image(i,j) + blue_image(i+2,j))/2;
            blue_image(i+1,j+1) = (blue_image(i,j) + blue_image(i,j+2) + blue_image(i+2,j) + blue_image(i+2,j+2))/4;
        end
    end
end

for i=2:2:imageWidth
    for j=2:2:imageHeight
        if i==2 || j==2
            red_image(i-1,j-1) = red_image(i,j);
            red_image(i-1,j) = red_image(i,j);
            red_image(i,j-1) = red_image(i,j);
        else
            red_image(i-1,j-1) = (red_image(i,j) + red_image(i,j-2) + red_image(i-2,j) + red_image(i-2,j-2))/4;
            red_image(i-1,j) = (red_image(i,j) + red_image(i-2,j))/2;
            red_image(i,j-1) = (red_image(i,j) + red_image(i,j-2))/2;
        end
    end
end
for i=1:imageWidth
    if mod(i,2) == 1
        for j=1:2:imageHeight-1
            if i==1 || i==imageWidth || j == 1
                green_image(i,j) = green_image(i,j+1);
            else 
                a = (green_image(i+1,j) + green_image(i-1,j) + green_image(i,j+1) + green_image(i,j-1))/4;
                green_image(i,j) = a;
            end
        end
    elseif mod(i,2) == 0
        for j=2:2:imageHeight
            if j == imageHeight || i == imageWidth
                green_image(i,j) = green_image(i,j-1);
            else
                a = (green_image(i+1,j) + green_image(i-1,j) + green_image(i,j+1) + green_image(i,j-1))/4;
                green_image(i,j) = a; 
            end
        end
    end
end

rgbim(:,:,1) = red_image;
rgbim(:,:,2) = green_image;
rgbim(:,:,3) = blue_image;
end