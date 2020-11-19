f = open("../results/FCFS-DTMC_ss.log", "r")
# Extracting data
probs, states1, job1_lens = [], [], []
for x in f:
    splittedLine = x.split("=")
    probs.append(float(splittedLine[1]))
    states1.append(int(splittedLine[0].split(",")[0][-1]))
    job1_lens.append(int(splittedLine[0].split(",")[1]))

weights = [isActive * p for (isActive, p) in zip(states1, probs)]    
weighted_sum_addends = [pa * l for (pa, l) in zip(weights, job1_lens)]    

rst = sum(weighted_sum_addends)/sum(weights)

print(rst)

