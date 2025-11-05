# f = (g + h) − (i + j);
# f, g, h, i, and j are assigned to the registers $s1, $s2, $s3, $s4 and $s0
add $t0, $s2, $s3 # t0 = g + h
add $t1, $s4, $s0 # t1 = i + j
sub $s1, $t0, $t1 # f = t0 - t1
