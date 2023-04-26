%similar to by_bilinear but for the grbg bayer type
function Ccam = my_bilinear_grbg(red_image,green_image,blue_image,M,N)
[imageWidth,imageHeight] = size(red_image);
for i=1:2:imageWidth-1
    for j=2:2:imageHeight
        if i == imageWidth-1
            if j == imageHeight
                red_image(i+1,j) = red_image(i,j);
                red_image(i+1,j-1) = red_image(i,j);
            else 
                red_image(i,j+1) = (red_image(i,j) + red_image(i,j+2))/2;
                red_image(i+1,j) = red_image(i,j);
                red_image(i+1,j-1) = red_image(i,j);
            end
        else
            if j==imageHeight
                red_image(i+1,j) = (red_image(i,j) + red_image(i+2,j))/2;
            else
                red_image(i,j+1) = (blue_image(i,j) + red_image(i,j+2))/2;
                red_image(i+1,j) = (red_image(i,j) + red_image(i+2,j))/2;
                red_image(i+1,j+1) = (red_image(i,j) + red_image(i,j+2) + red_image(i+2,j) + red_image(i+2,j+2))/4;
                if j==2
                    red_image(i,j-1) = red_image(i,j);
                    red_image(i+1,j-1) = red_image(i,j);
                end
            end
    end
end
end
for i=2:2:imageWidth
    for j=1:2:imageHeight-1
        if j==imageHeight-1
            blue_image(i,j+1) = blue_image(i,j);
            blue_image(i-1,j+1) = blue_image(i,j);
            if i == 2
                blue_image(i-1,j) = blue_image(i,j);
            else
                blue_image(i-1,j) = (blue_image(i,j)+blue_image(i-2,j))/2;
            end
        
        else
            if i == imageWidth
                blue_image(i,j+1) = blue_image(i,j);
            else
                blue_image(i+1,j+1) = (blue_image(i,j) + blue_image(i,j+2) + blue_image(i+2,j) + blue_image(i+2,j+2))/4;
                blue_image(i+1,j) = (blue_image(i,j) + blue_image(i+2,j))/2;
                blue_image(i,j+1) = (blue_image(i,j) + blue_image(i,j+2))/2;
            end
        end
    end
end
for i=1:imageWidth
    if mod(i,2) == 0
        for j=1:2:imageHeight-1
            if j==1
                if i == imageWidth
                    green_image(i,j) = green_image(i-1,j);
                else
                    green_image(i,j) = (green_image(i-1,j)+green_image(i+1,j))/2;
                end
            else
                if i == imageWidth
                    green_image(i,j) = (green_image(i,j-1)+green_image(i,j+1))/2;
                else
                    green_image(i,j) = (green_image(i,j+1) + green_image(i,j-1) + green_image(i-1,j)+green_image(i+1,j))/4;
                end
            end
        end
    else
        for j=2:2:imageHeight
            if i==1
                if j == imageHeight
                    green_image(i,j) = green_image(i,j-1);
                else
                    green_image(i,j) = (green_image(i,j-1)+green_image(i,j+1))/2;
                end
             else
                if j == imageHeight
                    green_image(i,j) = (green_image(i-1,j) + green_image(i+1,j))/2;
                else
                    green_image(i,j) = (green_image(i,j+1) + green_image(i,j-1) + green_image(i-1,j)+green_image(i+1,j))/4;
                end
                end
        end
    end
end

Ccam(:,:,1) = red_image;
Ccam(:,:,2) = green_image;
Ccam(:,:,3) = blue_image;
end