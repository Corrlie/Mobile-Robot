function out = Atan2c_fun(in)
%%% zmienne globalne
global theta0 is_init_atan2c prev_fi_arg
%%% wejscie
Fi = in;

fi0 = theta0; % pocz¹tkowe
if is_init_atan2c == 1
    prev_fi_arg = fi0;
end

prev_fi = atan2(sin(prev_fi_arg), cos(prev_fi_arg));
Delta_fi = Fi-prev_fi;

if Delta_fi>pi
    delta_fi = Delta_fi-2*pi;
elseif Delta_fi<-pi
    delta_fi = Delta_fi+2*pi;
else 
    delta_fi = Delta_fi;
end
fi = prev_fi_arg+delta_fi;
prev_fi_arg = fi;
is_init_atan2c = 0;
out = fi;

end
