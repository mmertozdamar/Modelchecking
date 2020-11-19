dtmc

const s = 0;
const i = 1;
const r = 2;

module sir

state : [s..r] init 0;

[      ] (state = s) -> 0.5: (state' = s) +
       	 	      	0.5: (state' = i);
[      ] (state = i) -> 0.5: (state' = i) +
       	 	      	0.5: (state' = r);
[      ] (state = r) -> 1: (state' = r);

endmodule    
