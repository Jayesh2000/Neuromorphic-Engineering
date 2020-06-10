function mem = mem_der(v, i, e_l)
c = 300e-12;
g_l = 30e-9;
mem = (-1*(g_l/c)).*(v - e_l) + i./c;
end