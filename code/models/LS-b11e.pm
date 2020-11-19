dtmc

const int T;

module client1
  state1 : [0..1] init 0; // State of the job (inactive/active)
  task1  : [0..5] init 0; // Length of the job
  
  // Create a new job - length chose non-deterministically
  [create] state1=0 -> 0.2: (state1'=1) & (task1'=1) +
  	    	       0.2: (state1'=1) & (task1'=2) +	
  	    	       0.2: (state1'=1) & (task1'=3) +
  	    	       0.2: (state1'=1) & (task1'=4) +
  	    	       0.2: (state1'=1) & (task1'=5) ;
		       
  // Serve the job
  [serve1] state1=1 & task1>0 -> (task1'=task1-1);

  // Complete the job
  [finish1] state1=1 & task1=0 -> (state1'=0);

endmodule

module client2 = client1 [state1=state2,
                          task1=task2,
                          create=create,
                          serve1=serve2,
                          finish1=finish2 ]
endmodule


module client3 = client1 [state1=state3,
                          task1=task3,
                          create=create,
                          serve1=serve3,
                          finish1=finish3 ]
endmodule


module monitor
       finished : bool init false;

       [finish1] finished=false -> (finished'=true);
       [finish1] finished=true -> true;
       
endmodule


module scheduler
       t1 : [-1..2] init 0;
       t2 : [-1..2] init 0;
       t3 : [-1..2] init 0;

       [] t1=0 & t2=0 & t3=0 -> 1/3: (t1' = 2) +
       		       	        1/3: (t2' = 2) +
			        1/3: (t3' = 2) ;

       [] t1=-1 & t2=0 & t3=0 ->  1/2: (t2' = 2) +
		                  1/2: (t3' = 2) ;

       [] t1=0 & t2=-1 & t3=0 ->  1/2: (t1' = 2) +
			          1/2: (t3' = 2) ;

       [] t1=0 & t2=0 & t3=-1 ->  1/2: (t1' = 2) +
			          1/2: (t2' = 2) ;

       [] t1=0 & t2=-1 & t3=-1 -> 1: (t1' = 2) ;
       
       [] t1=-1 & t2=0 & t3=-1 -> 1: (t2' = 2) ;

       [] t1=-1 & t2=-1 & t3=0 -> 1: (t3' = 2) ;

       [] t1=-1 & t2=-1 & t3=-1 -> 1: (t1'=0) & (t2'=0) & (t3'=0);
       

       // Serve the i-th task where ti is enabled,
       // then unset ti
       [serve1] t1>0 -> (t1'=t1-1);
       [serve2] t2>0 -> (t2'=t2-1);
       [serve3] t3>0 -> (t3'=t3-1);

       // Complete the job and disable the current ticket
       [finish1] t1>0 -> (t1'=-1);
       [finish2] t2>0 -> (t2'=-1);
       [finish3] t3>0 -> (t3'=-1);       
       
endmodule

system
  scheduler || client1 || client2 || client3 || monitor
endsystem

