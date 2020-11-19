import os
import re
import a12c
from matplotlib import pyplot as pyp

def gen_cmd_data(time):
    command = os.popen('prism -tr {} ../models/FCFS-DTMC.pm'.format(time))
    cmd = command.read()
    # print(cmd)        
    cmd_out = []
    for cl in cmd.split("\n"):
        match = re.search('^\d{1,2}:.*$', cl)
        if (match is not None):
            cmd_out.append(cl)
    # print(cmd_out)
    return cmd_out

def get_res_up_to(time_up_to):
    rst = []
    range_of_interest = range(time_up_to+1)
    client_name = "Client1"
    for t in range_of_interest:
        print("Time: {}".format(t))
        data = gen_cmd_data(t)
        probs, job1_lens = a12c.split_data(data)
        rst.append(a12c.compute_client_zero_jobs(probs, job1_lens, client_name))
    
    p = pyp.plot([i for i in range_of_interest], rst,
                 'go-', label='Transient, time up to {}'.format(time_up_to),
                 linewidth=2)
    pyp.ylabel("P that {} has no tasks".format(client_name))
    pyp.xlabel("time")  
    pyp.show()


def main():
    get_res_up_to(10)
    
if __name__ == "__main__":
    main()
