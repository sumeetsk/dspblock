function [x,y,typ] = xcos_mean(job,arg1,arg2)

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
        graphics = arg1.graphics;
        exprs = graphics.exprs;
        model = arg1.model;

        while %t do
            [ok, averagealong, exprs] = getvalue('Average matrix along? \n columns: 0 \n rows: 1 \n average all entries: 2',..
            ['Average along'],..
            list('vec',1),..
            exprs);

            if ~ok
                break;
            end

            if (averagealong ~= 0 | averagealong ~= 1 | averagealong ~= 2)
                message(['Average along must be 0, 1 or 2']);
                ok = %f;
            end

            if ok
                [model, graphics, ok] = set_io(model, graphics, in, out, [], []);

                if averagealong == [] then averagealong = 0;end
                model.ipar      = [averagealong];
                model.label     = nom;
                graphics.id     = nom;
                graphics.exprs  = exprs;
                x.graphics      = graphics;
                x.model         = model;
                break;
            end
        end

    case 'define' then
        averagealong = 0;

        model=scicos_model();
        model.sim   = list('my_mean', 5);
        model.in    = [-1];
        model.in2   = [-2];
        model.intyp = [1];
        if averagealong == 0
            model.out   = [1];
            model.out2  = [-2];
        end
        if averagealong == 1
            model.out   = [-1];
            model.out2  = [1];
        end
        if averagealong == 2
            model.out   = [1];
            model.out2  = [1];
        end
        model.outtyp= [1];

        model.blocktype='c';
        model.dep_ut=[%t %f]; //depends on input, not on time

        exprs=string([]);
        gr_i = [];

        x=standard_define([2 2],model,exprs,gr_i);
    end
endfunction

