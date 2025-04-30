# COMPASS_SDR_CODE

All the code used for SDR testing and characterization

## Table of Contents
- [Overview](#overview)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Folder Structure](#folder-structure)
- [Contact (Not the project title)](#contact)

## Overview

GNU Radio Comp Folder has its own README.md but the other folders do not, that is what this README is for

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

The "Functions" folder has multiple functions for GPS parsing, these are residual from a previous repo but can be used if needed

"Doppler_Shift_NCO" has the matlab script and NAV file used to start and run a satellite scenario which generates a Doppler profile of the MAXWELL satellite, can also generate other simpler profiles

"SDR Frequency Offset" is a mathamatica file where I was testing tune request parameters to see which ones can be prefectly reprsented on the N200

## Folder Structure

- Doppler_Shift_NCO
    - satelliteScenarioTest.m
    - "GPS NAV file for day".rnx
- Functions
    - All GPS functions, there are a lot
- GNU Radio Comp
    - Refer to separate README
- SDR Frequency Offset.nb

## Contact 

Primary Author: [Conner Parker](mailto:conner.parker@colorado.edu) - (719) 205-7737