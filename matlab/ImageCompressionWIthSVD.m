% Explore using the SVD to only show important image data (leaving out low
% singular value data

imdata = imread('tabby_and_bab.jpg');
[U, S, V] = svd(double(imdata(:,:,1))); % Only use first layer, this is black and white data

outputfilename = "tabby_and_bab_svd_compression.mp4";
newVid = VideoWriter(outputfilename, 'MPEG-4'); % New
newVid.FrameRate = 4;
newVid.Quality = 100;
open(newVid);

for layers = 1:50

    rebuiltImage = zeros(size(imdata(:,:,1)));
    Vt = V';

    for i = 1:layers
        rebuiltImage = (rebuiltImage + (U(:,i)*S(i,i)*V(:,i)'));
    end

    writeVideo(newVid,uint8(round(rebuiltImage)));%within the for loop saving one frame at a time
    %imshow(uint8(round(rebuiltImage)));
    %title(num2str(layers));
   
    %pause(0.25);
end

close(newVid);