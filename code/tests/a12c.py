def split_data(data):
    # Extracting data
    probs, job1_lens = [], []
    for x in data:
        splittedLine = x.split("=")
        if (len(splittedLine)>1):
            probs.append(float(splittedLine[1]))
            job1_lens.append(int(splittedLine[0].split(",")[1]))
    return (probs, job1_lens)


def compute_client_zero_jobs(probs, job_lens, clientName):
    job_zero_len = [1 if l==0 else 0 for l in job_lens]
    probs = [is_zero_len * p for (is_zero_len, p) in zip(job_zero_len, probs)]
    rst =  sum(probs)
    print("Probability that {} has zero tasks/job {}".format(clientName, rst))

    return rst

def main():
    file1 = open("../results/FCFS-DTMC_transient10.log", "r")
    (probs, job_lens) = split_data(file1)

    compute_client_zero_jobs(probs, job_lens, "Client1")

if __name__ == "__main__":
    main()
