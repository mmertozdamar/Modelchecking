from matplotlib import pyplot as pyp
import argparse

parser = argparse.ArgumentParser(description='Process some integers.')
parser.add_argument('--data_file', type=str,
            help='filename of the data file', default='LS-b11a.log')
args = parser.parse_args()

probs = []
f = open("../results/{}".format(args.data_file))
for l in f:
    try:
        probs.append(float(l.split('\t')[1]))
    except ValueError:
        pass
        
f.close()
p = pyp.plot([i for i in range(21)], probs,
             'go-', linewidth=2)
pyp.ylabel("P(F<=T finished=true)")
pyp.xlabel("T")  
pyp.show()


