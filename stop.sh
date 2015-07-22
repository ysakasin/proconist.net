#!/bin/bash

cat ./tmp/pids/unicorn.pid | xargs kill -QUIT
