function [motionmatx, motionmaty, xdat, ydat] = Pathdata(g, s, x, y, spd, lod)
      
    if(lod == 0) 
        t = getEnodes(s);
        [SP, xdat, ydat] = getpath(g, s, t, x, y); 
        [motionmatx, motionmaty] = getpathdata(SP, x, y, spd);
        motion = [motionmatx'; motionmaty'];
        save motion.dat motion -ascii;
    else
        load motion.dat motion;
        motionmatx = motion(1 : size(motion, 1) / 2, :)';
        motionmaty = motion((size(motion, 1) / 2) + 1 : size(motion, 1), :)';
        xdat = motion(1, : )';
        ydat = motion((size(motion, 1) / 2) + 1, :)';
    end
end