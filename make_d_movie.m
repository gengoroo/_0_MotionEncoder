function [fn_black, fn_white, pn_d_movie,pn_filter] = make_d_movie(fn_full)

    %addpath('C:\Users\gengoro\Dropbox (Scripps Research)\_OriginalSoftwares\MATLAB program CF\_DeepLearning\MovieFilter\_SOM');

    [pn, fn] = fileparts(fn_full);
    vid1 = VideoReader(fn_full);
    nFrames = vid1.NumberOfFrames;

    pn_filter = [pn, '\filter\', fn(1:end-4)];
    pn_d_movie = [pn_filter, '\d_movie'];
    mkdir(pn_d_movie);
    fn_black = [fn(1:end-4) '_black.avi'];
    fn_white = [fn(1:end-4) '_white.avi'];
    writerObj_black = VideoWriter([pn_d_movie '\' fn_black]);
    writerObj_white = VideoWriter([pn_d_movie '\' fn_white]);
    writerObj_black.FrameRate = vid1.FrameRate;
    writerObj_white.FrameRate = vid1.FrameRate;
    open(writerObj_black);
    open(writerObj_white);

    for ii=1:nFrames
      im=read(vid1,ii);
      %im=imresize(im,0.5);
      %imc=imcrop(im,[60 60 300 300]);% The dimention of the new video
      if size(im,3) == 3
          img=rgb2gray(im);
      else
          img = im(ListDim1,ListDim2,:);
      end
      IM(:,:,ii) = img;
    end
    dIM = int8(IM(:,:,2:end)) - int8(IM(:,:,1:end-1));

    dIM_black = uint8(round((abs(dIM) - dIM)/2));
    dIM_white = uint8(round((abs(dIM) + dIM)/2));

    for ii=1:nFrames-1
      writeVideo(writerObj_black,dIM_black(:,:,ii));  
      writeVideo(writerObj_white,dIM_white(:,:,ii));  
        if rem(ii,100)==0
            fprintf('.');
        end
    end
    fprintf('\n');
    %release(videoPlayer);

    % 再生
    %obj_track_movie(fn_full);
    %obj_track_movie([pn_save '\' fn_black]);
    %obj_track_movie([pn_save '\' fn_white]);

end