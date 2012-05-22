// ====================================================================
// Template toolbox_skeleton
// This file is released under the 3-clause BSD license. See COPYING-BSD.
// ====================================================================
//
//
function block = mysum(block, flag)
    if flag == 1 then
        v = 0;
        for j = 1:block.nin
            v = v + block.inptr(j)(1);
        end
        block.outptr(1)(1) = v;
    end
endfunction
// ====================================================================
