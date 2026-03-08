#!/bin/bash
set -e
tofu fmt
tofu apply -parallelism=1
