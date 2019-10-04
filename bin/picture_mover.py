#!/usr/local/bin/env python

import os
import sys
import itertools


sources = []

def create_dir_struct():
    for year in range(2000, 2018):
        for month in range(1,13):
            month = "%02d" % month
            directory = "%s/%m" % (year, month)
            if not os.path.exists(directory):
                print("creating folder: %s" % directory)
                os.makedirs(directory)


def copy_files():
    spinner = itertools.cycle(['-', '/', '|', '\\'])
    for source in sources:
        for root, dirs, filenames in os.walk(source):
            for filename in filenames:
                sys.stdout.write(spinner.next())
                sys.stdout.flush()
                filepath = os.path.join(root,filename)
                if filename.startswith('20'):
                    # assuming the file is already named properly
                    year = filename[:4]
                    month = filename[5:7]
                else:
                    # assuming the file is not named properly...
                    pass




def main():
    create_dir_struct()


if __name__ == '__main__':
    main()