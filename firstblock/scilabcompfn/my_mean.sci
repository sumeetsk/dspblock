// ====================================================================
// Template toolbox_skeleton
// This file is released under the 3-clause BSD license. See COPYING-BSD.
// ====================================================================
//
//
function block = my_mean(block, flag)
    if flag == 1 then
        averagealong = block.ipar(1);
        //0: columns
        //1: rows
        //2: all

        nrows = block.insz(1);
        ncols = block.insz(2);

        M = zeros(nrows, ncols);
        for i = 1:nrows
            for j = 1:ncols
                M(i,j) = block.inptr(1)((j-1)*nrows+i);
            end
        end

        if averagealong == 0        //colums
            N = mean(M,'c');
            outsize = ncols;
        elseif averagealong == 1    //rows
            N = mean(M, 'r');
            outsize = nrows;
        elseif averagealong == 2    //all
            N = mean(M);
            outsize = 1;
        else
            //return error
        end

        for i=1:outsize
            block.outptr(1)(i) = N(i);
        end
        //output N
    end
endfunction
// ====================================================================
