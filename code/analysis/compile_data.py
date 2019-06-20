# -*- coding: utf-8 -*_
"""
Reads in a set of compiled data for all mutants, runs processing, and saves
relevant information to .csv. 
"""
import numpy as np
import pandas as pd
from tqdm import tqdm
import vdj.io
import glob
import imp
import re
imp.reload(vdj.io)

# Glob the file names of all .mat files in data
files = glob.glob('../../data/mat_files/*.mat')

# Instantiate the empty lists to store dataframes
dwell_dfs, f_looped_dfs, fates_dfs = [], [], []
samples_dfs, stats_dfs = [], []
for f in tqdm(files, desc='Processing .mat TPM files...'):
    
    # Load and extract data
    tpm = vdj.io.ProcessTPM(f)
    dwell = tpm.dwell_time()

    # Add divalent salt information
    if '_Ca_' not in f.split('/')[-1]:
        salt = 'Mg'
    else:
        salt = 'Ca'
    dwell['salt'] = salt

    # Add HMGB1 concentration information
    if '_HMGB1_' not in f.split('/')[-1]:
        hmgb1 = 80
    else:
        hmgb1 = int(f.split('_')[2][:-2])
    dwell['hmgb1'] = hmgb1

    # Append the generated dataframes to the data lists
    dwell_dfs.append(dwell)

# Concatenate the data and save to CSVs
dwell = pd.concat(dwell_dfs)
dwell.to_csv('../../data/compiled_dwell_times.csv', index=False)

