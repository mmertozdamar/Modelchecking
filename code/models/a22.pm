dtmc

module encoding

state : [0..3] init 1;

[] (state=0) -> 4/10:(state'=1)
              + 6/10:(state'=3);

[] (state=1) -> 1/2:(state'=1)
              + 1/2:(state'=2);

[] (state=2) -> 2/10:(state'=2)
              + 4/10:(state'=3)
              + 4/10:(state'=0);

[] (state=3) -> 1:(state'=2);

endmodule
