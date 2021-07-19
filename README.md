# Application Specific Embedded Processor for Affine Transformations

This repo contains a SystemVerilog implementation of an embedded processor designed to perform Affine Transformation on 8-bit x and y coordinates.
The top level module is `picoMIPS4test.sv`.
Each module comes with a `_stim.sv` module implementing a comprehensive testbench.
An assembler written in Python is provided to simplify programming.
Further details can be found in the [Project Report](Report.pdf). 

This project was submitted for the award of an MEng in Electronics with Computer Systems during my 4th year at the University of Southampton.
It was the second of two courseworks submitted for an embedded processor design module.
For the first coursework a generic embedded processor based on the [picoMIPS Architecture](https://eprints.soton.ac.uk/366664/1/xPaper_01.pdf). 
The second coursework involved redesigning that processor to be application specific.
The generic processor can be viewed by rewinding this repository to commit 1115a19.

**Disclaimer:** This project has been made public purely for the purposes of creating a portfolio. 
If you are currently a student and Southampton do not attempt to submit some or all of this project as your own work. 
It will be flagged as plagiarism and there will be serious consequences.

## Directory Structure:

### rtl
Contains all SystemVerilog files and the Python assembler.
Also contains `.do`, `.mpf`, `.tcl` files for simulation and waveform generation.

### programs
Contains the programs written for this processor in assembler.

### quartus_projects
Contains a set of quartus projects for each of the modules and the final designs.

### report
Contains the report and all images of waveforms produced for it.

## Simulation
Up to commit 1115a19 all code was tested on a specialised CAD server run by the University.
Between the completion of the two courseworks I lost access to this server so the remainder of the work had to be completed with Modelsim. 
The only modules modified to create the Application Specific Processor were `cpu.sv` and `as_alu.sv`. They did not need to be reverified.

application_cpu_stim:
```
vsim work.application_cpu_stim {-voptargs=+acc=bcglnprst+prog +acc=bcglnprst+picoMIPS4test +acc=bcglnprst+cpu +acc=bcglnprst+counter +acc=bcglnprst+regs +acc=bcglnprst+as_alu +acc=bcglnprst+decoder +acc=bcglnprst+pc +acc=bcglnprst+application_cpu_stim} -do application_display_wave.do
```

as_alu_stim:
```
vsim work.as_alu_stim {-voptargs=+acc=bcglnprst+as_alu +acc=bcglnprst+as_alu_stim} -do as_alu_wave.do
```