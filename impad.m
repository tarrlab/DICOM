function img = impad(iFile, bg)
% img = impad(iFile, bg)
%
%   impad reads in an image from a file and pads it to be
%   square using the specified background graylevel
%
%   version = 0.2
%
% HISTORY
%
%   10/7/04    mjt     wrote it
%   10/9/04    mjt     sped up image copy and creation

try
    in = imread(iFile);
    dim = size(in); % dimensions of image
    depth = max(size(dim)); % grayscale (2) or color image (3)
    if (length(dim) < 3)
        dim(3) = 1;
    end
    
    if (dim(1) == dim(2))
        img = uint8(zeros(dim(1),dim(2),dim(3)));
        img = in;
    else
        pad = max(dim(1:2));
        img = repmat(uint8(bg),[pad pad dim(3)]);

        % faster code courtesy of Frans Cornelissen and Daw-An Wu
        startX = 1 + floor(abs(pad - dim(1)) / 2);
        endX = startX + dim(1) - 1 ;
        % xsize = endX - startX;

        startY = 1 + floor(abs(pad - dim(2)) / 2);
        endY = startY + dim(2) - 1;
        % ysize = endY - startY;

        img(startX:endX,startY:endY,:) = in(:,:,:);
        
    end

catch
    % This "catch" section executes in case of an error in the "try" section
    % above. Importantly, it closes the onscreen window if its open.
    ShowCursor;
    Screen('CloseAll');
    rethrow(lasterror);
    clear all
end % try..catch..
