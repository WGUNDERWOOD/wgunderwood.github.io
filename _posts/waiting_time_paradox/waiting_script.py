import sys
sys.path.append(".")

import numpy as np
from numpy import random as rd
import waiting_source as w


n_trials = 100000
start_time = 300
average_interval = 10

waiting_time_info_table = w.get_waiting_time_info_table(average_interval, start_time, n_trials)

print("number of trials")
print(n_trials)

print()

print("W")
print(np.mean(waiting_time_info_table["waiting_time"]))

print()

print("E")
print(np.mean(waiting_time_info_table["elapsed_time"]))

print()

print("Z_1")
print(np.mean(rd.exponential(scale = average_interval, size = n_trials)))

print()

print("I")
print(np.mean(waiting_time_info_table["observed_interval"]))

print()

print("N")
print(np.mean(waiting_time_info_table["arrival_index"]))
