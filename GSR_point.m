function out = GSR_point(in)

    point = in;
    x_d = in(1);
    y_d = in(2);
    theta_d = 0;
    dx_d = 0;
    dy_d = 0;
    ddx_d = 0;
    ddy_d = 0;
    om_d = 0;
    v_d = 0;

    out = [theta_d; x_d; y_d; dx_d; dy_d; ddx_d; ddy_d; om_d; v_d];


end