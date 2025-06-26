#-----------------------------------------------------------------------
#Description : Opening a file and searching for a pattern in read mode
#Function Used : search()
#-----------------------------------------------------------------------
import re
import sys
import os
import time
from datetime import datetime

## Variables
reg_list_array = []
debug = 0

# Get regression list as input
regression_list = str(sys.argv[1])
if debug:
    print(regression_list)

# Reading the file
path = "../../src/hvlTop/tb/regressionTest/" + regression_list
if debug:
    print(path)

with open(path, 'r') as f:
    for line in f:
        match = re.search('#', line)
        if match:
            continue

        match = re.search(r'\bJtag\w*', line)
        if match:
            reg_list_array.append(match.group(0))
            if debug:
                print(match.group(0))

# Prepare the trace file to record the test names
trace_file_path = "test_names_trace.txt"
with open(trace_file_path, 'a') as trace_file:
    for testname in reg_list_array:
        timestr = time.strftime("%d%m%Y-%H%M%S")
        if debug:
            print("time string : ", timestr)

        test_folder = testname + "_" + timestr

        line = "make simulate test_folder=" + test_folder + " test=" + testname
        if debug:
            print(line)
        
        # Write the test name to the trace file
        trace_file.write(testname + "\n")

        os.system(line)

# print(f"Test names have been traced in {trace_file_path}")
