#!/bin/bash

cat ./unicorn.pid | xargs kill -QUIT
