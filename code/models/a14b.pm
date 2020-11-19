dtmc

module a14b
    s : [0..1];
    
    [] s=0 ->  0.5 : (s'=0) + 
       	       0.5 : (s'=1);
    [] s=1 -> 1: (s'=1);

endmodule

label "phi" = s=0;
