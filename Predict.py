"""
This module descibes how to load a custom dataset from a single file.

As a custom dataset we will actually use the movielens-100k dataset, but act as
if it were not built-in.
"""

from __future__ import (absolute_import, division, print_function,
                        unicode_literals)
import os

from surprise import BaselineOnly,KNNWithMeans,SVD,KNNBaseline,SVDpp,NMF,CoClustering,KNNBasic,NormalPredictor,KNNWithZScore,SlopeOne
from surprise import Dataset
from surprise import Reader
from surprise.model_selection import cross_validate

# path to dataset file - for any dataset

file_path = os.path.expanduser('~/.Datasets/GoodBooks.txt')
# file_path = os.path.expanduser('~/.Datasets/Ciao.txt')
# file_path = os.path.expanduser('~/.Datasets/ML-1M.txt')
# file_path = os.path.expanduser('~/.Datasets/ML-100K.txt')
# file_path = os.path.expanduser('~/.Datasets/Yahoo!Music.txt')


reader = Reader(line_format='user item rating', sep='\t', rating_scale=(1, 5))

data = Dataset.load_from_file(file_path, reader=reader)

trainset = data.build_full_trainset()
my_seed = 0

# Build one of ten utilized algorithms with their default parameters and train it. For neighborhood-based algorithms (User- and Item-based KNN), we utilize Cosine as the similarity metric and set neighborhood size as 40. 
algo = NMF()
algo.fit(trainset)


# Write the prediction scores calculated for users for each item to the corresponding txt file. In this version, we use GoodBooks dataset and NMF algorithm. 
myfile = open('GoodBooks-NMF.txt', 'w')

for u in range(19146):
    idu=u+1
    uid = str(idu)
    print(idu)
    for i in range(4190):
        idi=i+1
        iid = str(idi)
        pred = algo.predict(uid, iid, verbose=False)
        myfile.write("%.5s\t%.5s\t%.5s\n" % (idu,idi,pred.est))

myfile.close()


