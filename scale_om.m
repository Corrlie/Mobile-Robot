function out = scale_om(in)

% wejscia
p_om_dc = in(1);
l_om_dc = in(2);
om_k_max = in(3);

Om_DC = [p_om_dc; l_om_dc];

% wspolczynnik skalujacy
ks = max([1, (abs(p_om_dc))/om_k_max, (abs(l_om_dc))/om_k_max]);

Om_DS = (1/ks)*Om_DC;

out = Om_DS;

end