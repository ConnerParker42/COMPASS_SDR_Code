# COMPASSLabCode

Code used to parse both raw IQ signal data as well as unwrapped phase data from COMPASS Lab SDRs.

## Table of Contents
- [Overview](#overview)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Folder Structure](#folder-structure)
- [Contact (Not the project title)](#contact)

## Overview

Takes either IQ signal data or phase data and calculates signal properties. ADEVs are the most useful graphs for overall performance

## Requirements

List any dependencies or toolboxes needed to run the code.

- MATLAB version: R2024a or higher
- Required Toolboxes:
  - Signal Processing Toolbox

## Installation

1. Clone this repository:
   ```bash
   git clone git@axelradlab.colorado.edu:copa5633/COMPASS_SDR_Code.git

## Usage

Each script is implemented such that they work with eachother, e.g. the data parsed for any of the parsing scripts gives the data as a cell array of time tables. This makes it easy to veiw in matlab but external functions may not work with this format

Before each execution of the main scripts listed below, ensure the read path is set to the folder containing the binary files from the Lab PC, also ensure the signal frequency, sampling rates (Both IQ and Unwarpped Phase) and beat frequency are set properly.
For the NCO script ensure the command phase file path, NCO sample rate are proper. The time interval should be set to the grab the data where both the TX and RX are working.

## Folder Structure

All function files and main files are in the same folder

Main files 
- n200_clockCharacterization.m
- n310_clockCharacterization.m
- n310_ensemble_estimates.m
- nco_characterization.m

The matlab file "tuneRequestTesting.m" is a testing script that shows the tune request process on both the N310 and the N200. Not useful for data processing but useful for helpful for understanding how the SDRs work.

## Contact 

Primary Author: [Conner Parker](mailto:conner.parker@colorado.edu) - (719) 205-7737