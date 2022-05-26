
clear img
clear img2
clear img3
clear img4

yes = 0;

img = imread('map2.jpg');
[a, b, c] = size(img);
img4 = img;

if yes == 1
    figure(1)
    hold on
    subplot(2, 3, 1);
    image(img)
    axis([0 b 0 a]);
    title('(A)', 'Units', 'normalized', 'Position', [0.5, -0.22, 0]);
end

for i = 1:a
    for j = 1:b
        if (sum(img(i,j,:)) > 3*252)
             % White pixel - do what you want to original image
             img(i,j,:) = [255 255 255]; % make it black, for example
        else
            img(i,j,:) = [0 0 0];
        end
    end
end

if yes == 1
    subplot(2, 3, 2);
    axis([0 b 0 a]);
    image(img);
    title('(B)', 'Units', 'normalized', 'Position', [0.5, -0.22, 0]);
end
%img2 = img;
%img2 = bwmorph(img, 'fill');
se = strel('disk',5);
img2 = imclose(img, se);
se = strel('disk',0);
img2 = imopen(img2,se);

if yes == 1
    subplot(2, 3, 3)
    hold on
    axis([0 b 0 a]);
    image(img2);
    title('(C)', 'Units', 'normalized', 'Position', [0.5, -0.22, 0]);
end

skel = bwmorph(img2(:, :, 1),...        % gets the skelaton from the weight roads 
     'skel', Inf);        
    
img3(:, :, 1)= skel;
img3(:, :, 3)= skel;
img3(:, :, 2)= skel;

if yes == 1
    subplot(2, 3, 4)
    image(img3)
    axis([0 b 0 a]);
    title('(D)', 'Units', 'normalized', 'Position', [0.5, -0.22, 0]);
end
                                         %Map (image) to Graph toolbox
[~,node,link] = Skel2Graph3D(skel,5);    %convverts the skelaton to graph
                                             %skel2graph 3d toolbox
                                             %the factor to the right in
                                             %both of them doesn't make
                                             %difference


x = extractfield(node, 'comx')';
y = extractfield(node, 'comy')';
sn = extractfield(link, 'n1')';
en = extractfield(link, 'n2')';

endNodes = table([sn en],'Variablenames', {'EndNodes'});
Nodes = table(zeros(size(x, 1), 0));
G = graph(endNodes, Nodes);
height(G.Nodes)
%     for i = 1:height(G.Nodes)
%         if(degree(G, i) == 0)
%             G = rmnode(G, i);
%         end
%     end
if yes == 1
    subplot(2, 3, 5);
    axis([0 b 0 a]);
    plot(G, 'xdata', y, 'ydata', x);
    title('(E)', 'Units', 'normalized', 'Position', [0.5, -0.22, 0]);
end

if yes == 1
    subplot(2, 3, 6);
    hold on;
    axis([0 b 0 a]);
    image(img4);
    plot(G, 'xdata', y, 'ydata', x);
    title('(F)', 'Units', 'normalized', 'Position', [0.5, -0.22, 0]);
else 
    figure (1);
    hold on;
    axis([0 b 0 a]);
    image(img4);
    plot(G, 'xdata', y, 'ydata', x);
    title('Helwan');
end
    
    
    