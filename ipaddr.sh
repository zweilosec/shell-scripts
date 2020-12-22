#!/bin/bash

ifconfig | grep "inet " | cut -d" " -f2
