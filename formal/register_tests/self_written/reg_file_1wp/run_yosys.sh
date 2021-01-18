#!/bin/bash

yosys -m ghdl equiv_check.ys | tee equiv.log
