
% imdb = struct();
imageDir = '/mnt/6B133E147DED759E/采集数据/国外街景/cubes_train';
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
        if ~strcmp(s.annotation.object.name.Text,'face')
            bndbox = s.annotation.object.bndbox;
            xmin = str2num(bndbox.xmin.Text);
            ymin = str2num(bndbox.ymin.Text);
            xmax = str2num(bndbox.xmax.Text);
            ymax = str2num(bndbox.ymax.Text);
            rects=[rects; xmin ymin xmax ymax];
        end
    else
        for j = 1:numel(s.annotation.object)
            if ~strcmp(s.annotation.object{j}.name.Text,'face')
                bndbox = s.annotation.object{j}.bndbox;
                xmin = str2num(bndbox.xmin.Text);
                ymin = str2num(bndbox.ymin.Text);
                xmax = str2num(bndbox.xmax.Text);
                ymax = str2num(bndbox.ymax.Text);
                rects=[rects; xmin ymin xmax ymax];
            end
        end
    end
    labels.rects{i} = rects;
        
end

save (['data/cube/imdb.mat'], 'imageDir', 'images', 'labels');