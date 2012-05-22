function [x,y,typ] = scilab_sum(job,arg1,arg2)

    x=[];y=[];typ=[];


    select job

    case 'plot' then
        standard_draw(arg1);

    case 'getinputs' then
        [x,y,typ]=standard_inputs(arg1);

    case 'getoutputs' then
        [x,y,typ]=standard_outputs(arg1);

    case 'getorigin' then
        [x,y]=standard_origin(arg1);

    case 'set' then
        x=arg1;

    case 'define' then
        model=scicos_model();
        model.sim   = list('mysum', 5);
        model.in    = [1; 1];
        model.intyp = [1; 1];
        model.out   = 1;
        model.outtyp= 1;

        model.blocktype='c';
        model.dep_ut=[%t %f]; //depends on input, not on time

        exprs=string([]);
        //gr_i=['txt=[''mysum''];';
              //'xstringb(orig(1),orig(2),txt,sz(1),sz(2),''fill'')'];
        gr_i = [];

        x=standard_define([2 2],model,exprs,gr_i)
    end


endfunction
