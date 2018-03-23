
% imdb = struct();
imageDir = 'data/eu_plates';
images = struct();
labels = struct();

images.name = {};

filelist = dir([imageDir '/*.xml']);
r = randperm(numel(filelist));
filelist = filelist(r);

for i = 1:numel(filelist)
    
    s = xml2struct([imageDir '/' filelist(i).name]);

    
    %H = str2num(s.annotation.size.height.Text);
    %W = str2num(s.annotation.size.width.Text);

    %ext = s.annotation.path.Text(end-3:end);
    
    [~, name] = fileparts(fullfile(filelist(i).name));
    imagePath = fullfile([name, '.jpg']);
    
    info = imfinfo([imageDir '/' name '.jpg']);
    H = info.Height;
    W = info.Width;
    
    images.name{i} = imagePath;
    images.size(i,1:2) = [H W];
    images.set(i) = 1;
    if r(i) == 1 || r(i) == 5 || r(i) == 14 || r(i)==21 || r(i)==31
        images.set(i) = 2;
    end
    rects=[];
    
    
    if numel(s.annotation.object)==1
            bndbox = s.annotation.object.bndbox;
            xmin = str2num(bndbox.xmin.Text);
            ymin = str2num(bndbox.ymin.Text);
            xmax = str2num(bndbox.xmax.Text);
            ymax = str2num(bndbox.ymax.Text);
            rects=[rects; xmin ymin xmax ymax];
    else
        for j = 1:numel(s.annotation.object)
            bndbox = s.annotation.object{j}.bndbox;
            xmin = str2num(bndbox.xmin.Text);
            ymin = str2num(bndbox.ymin.Text);
            xmax = str2num(bndbox.xmax.Text);
            ymax = str2num(bndbox.ymax.Text);
            rects=[rects; xmin ymin xmax ymax];
        end
    end
    labels.rects{i} = rects;
        
end

save ([imageDir '/imdb.mat'], 'imageDir', 'images', 'labels');