#!/usr/bin/python3

import os
import argparse
from glob import glob
import tcb_platform

parser = argparse.ArgumentParser(description="Process docker-compose YML files.")
parser.add_argument("workdir", help="Directory to look for .yml files")
args = parser.parse_args()

yml_files = glob(os.path.join(args.workdir, "*.yml"))
yml_files = [f for f in yml_files if not f.endswith(".lock.yml")]

for compose_file in yml_files:
    print("canonicalize: ", compose_file)
    compose_file_lock = tcb_platform.canonicalize_compose_file(
        compose_file,
        force=True,
    )

    lock_file = compose_file.replace(".yml", ".lock.yml")

    if os.path.exists(lock_file):
        os.rename(lock_file, compose_file)
