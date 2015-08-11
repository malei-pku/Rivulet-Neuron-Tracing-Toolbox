% function trytip3d(I)
tic;
	disp('Loading Image and classifying...')
	% I = load_v3d_raw_img_file('/home/siqi/hpc-data1/Data/OP/OP_V3Draw/OP_2.v3draw');
	% I = squeeze(I>30);
	clsf = load('/home/siqi/hpc-data1/Data/OP/quad.mat');
    cl = clsf.obj;
	[I, ~] = binarizeimage('/home/siqi/hpc-data1/Data/OP/OP_V3Draw/OP_4.v3draw', cl, 2);
	I = I > 0.5;

    disp('Distance transform');
    bdist = getBoundaryDistance(I, true);
    disp('Looking for the source point...')
    [SourcePoint, maxD] = maxDistancePoint(bdist, I, true);
    disp('Make the speed image...')
    SpeedImage=(bdist/maxD).^4;
	SpeedImage(SpeedImage==0) = 1e-10;
	disp('marching...');
    oT = msfm(SpeedImage, SourcePoint, false, false);
    disp('Finish marching')

    disp('Calculating gradient...')
	% Calculate gradient of DistanceMap

    close all
    T = oT;
    tree = []; % swc tree
    prune = true;
	grad = distgradient(T);
    S = {};
    B = zeros(size(T));
    i = 1;
	figure(1)
	showbox(I, 0.5);
	drawnow

	% figure(2)
	% showbox(I, 0.5);
	% drawnow

    while(true)

	    StartPoint = maxDistancePoint(T, I, true);
	    % disp('SourcePoint')
	    % disp(SourcePoint)
	    % disp('StartPoint')
	    % disp(StartPoint)
	    % disp('T:')
	    % disp(T(StartPoint(1), StartPoint(2), StartPoint(3)))
	    % disp('B:')
	    % disp(B(StartPoint(1), StartPoint(2) ,StartPoint(3)))
	    % disp('I:')
	    % disp(I(StartPoint(1), StartPoint(2) ,StartPoint(3)))

	    if T(StartPoint(1), StartPoint(2), StartPoint(3)) == 0 || I(StartPoint(1), StartPoint(2), StartPoint(3)) == 0
	    	break;
	    end

	    disp('start tracing');
	    figure(1)
	    hold on
	    l = shortestpath2(T, grad, StartPoint, SourcePoint, 2, 'rk4');
	    hold off
	    disp('end tracing')

	    % Get radius of each point from distance transform
	    ind = sub2ind(size(bdist), int16(l(:, 1)), int16(l(:, 2)), int16(l(:, 3)));
	    radius = bdist(ind);
	    radius(radius < 1) = 2;
	    radius = ceil(radius);

    	% disp('found shorline with length')
    	% disp(size(l, 1))
	    if size(l, 1) < 4
	    	l = [StartPoint'; l];
	    	radius = zeros(size(l, 1), 1);
	    	radius(:) = 2;
	    end
	    % Remove the traced path from the timemap
	    tB = binarysphere3d(size(T), l, radius);
	    tB(StartPoint(1), StartPoint(2), StartPoint(3)) = 3;
	    T(tB==1) = -1;
	    S{i} = l;

	    % Add l to the tree
	    if prune && size(l, 1) > 4
		    tree = addbranch2tree(tree, l, radius);
		end

        B = B | tB;

        percent = sum(B(:) & I(:)) / sum(I(:))
        if percent > 0.95
        	break;
        end

        % figure(2)
        % % scatter3(B(:, 1), B(:, 2), B(:, 3));
        % showbox(B, 0.5);
        % drawnow

	    i = i + 1;
    end

    showswc(tree, I);
    % save_v3d_swc_file('shit.swc', tree);
toc