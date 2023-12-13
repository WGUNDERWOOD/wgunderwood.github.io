import numpy as np
from numpy import random as rd
import pandas as pd


def get_waiting_time_info(average_interval, start_time):

  n_arrivals = int(5 * start_time / average_interval + 100)

  intervals = rd.exponential(scale = average_interval, size = n_arrivals)
  arrival_times = np.cumsum(intervals)
  arrival_index = np.argmax(arrival_times >= start_time)

  arrival_time = arrival_times[arrival_index]
  previous_arrival_time = arrival_times[arrival_index - 1]
  waiting_time = arrival_time - start_time
  elapsed_time = start_time - previous_arrival_time
  observed_interval = arrival_time - previous_arrival_time
  proportion_elapsed = elapsed_time / observed_interval
  ratio_elapsed_waiting = elapsed_time / waiting_time
  difference_elapsed_waiting = elapsed_time - waiting_time


  waiting_time_info = [
    elapsed_time,
    waiting_time,
    observed_interval,
    proportion_elapsed,
    ratio_elapsed_waiting,
    difference_elapsed_waiting,
    arrival_index
  ]

  return waiting_time_info


def get_waiting_time_info_table(average_interval, start_time, n_trials):

  waiting_time_info_list = [get_waiting_time_info(average_interval, start_time) for i in range(n_trials)]

  colnames = [
    "waiting_time",
    "elapsed_time",
    "observed_interval",
    "proportion_elapsed",
    "ratio_elapsed_waiting",
    "difference_elapsed_waiting",
    "arrival_index"
  ]

  waiting_time_info_table = pd.DataFrame(
    waiting_time_info_list,
    columns = colnames
  )

  return waiting_time_info_table
