
s = xml2struct('data/dl/[2015-2-10][14-27-44].xml');
im = imread('data/dl/[2015-2-10][14-27-44].png');

rects=[];
  
for j = 1:numel(s.annotation.object)
    bndbox = s.annotation.object{j}.bndbox;
    xmin = str2num(bndbox.xmin.Text);
    ymin = str2num(bndbox.ymin.Text);
    xmax = str2num(bndbox.xmax.Text);
    ymax = str2num(bndbox.ymax.Text);
    rects=[rects; xmin ymin xmax ymax];
end

[H, W ,~] = size(im);
im2 = rot90(im);
s2 = s;
s2.annotation.size.width.Text
im3 = rot90(im,2);
s3 = s;
im4 = rot90(im,3); %counterclock
s4 = s;
%imshow(im2);
%hold on,
for j = 1:numel(s.annotation.object)
    % no rot
    %rectangle('Position', [ rects(j,1), rects(j,2), rects(j,3)-rects(j,1)+1, rects(j,4)-rects(j,2)+1], 'EdgeColor', 'g');

    % counterclock 90
    x1 = rects(j,2);
    y2 = W - rects(j,1);
    x2 = rects(j,4);
    y1 = W - rects(j,3);
    b = s2.annotation.object{j}.bndbox;
    b.xmin.Text = num2str(x1);
    b.ymin.Text = num2str(y1);
    b.xmax.Text = num2str(x2);
    b.ymax.Text = num2str(y2);
    s2.annotation.object{j}.bndbox = b;
    
    % counterclock 180
    x1 = W - rects(j,3);
    y1 = H - rects(j,4);
    x2 = W - rects(j,1);
    y2 = H - rects(j,2);
    b = s3.annotation.object{j}.bndbox;
    b.xmin.Text = num2str(x1);
    b.ymin.Text = num2str(y1);
    b.xmax.Text = num2str(x2);
    b.ymax.Text = num2str(y2);
    s3.annotation.object{j}.bndbox = b;
    
    % counterclock 270
    x1 = H - rects(j,4);
    y1 = rects(j,1);
    x2 = H - rects(j,2);
    y2 = rects(j,3);
    b = s4.annotation.object{j}.bndbox;
    b.xmin.Text = num2str(x1);
    b.ymin.Text = num2str(y1);
    b.xmax.Text = num2str(x2);
    b.ymax.Text = num2str(y2);
    s4.annotation.object{j}.bndbox = b;

    %rectangle('Position', [ x1, y1, x2-x1+1, y2-y1+1], 'EdgeColor', 'g');
end



