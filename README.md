# ELEC6234 Assignment 1

## Directories:

### rtl
Contains all SystemVerilog files and the Python assembler.

### programs
Contains the programs written for this processor in assembler.

### quartus_projects
Contains a set of quartus projects for each of the modules and the final designs.

### report
Contains the report and all images of waveforms produced for it.

## ModelSim Simulation Commands
application_cpu_stim:
```
vsim work.application_cpu_stim {-voptargs=+acc=bcglnprst+prog +acc=bcglnprst+picoMIPS4test +acc=bcglnprst+cpu +acc=bcglnprst+counter +acc=bcglnprst+regs +acc=bcglnprst+as_alu +acc=bcglnprst+decoder +acc=bcglnprst+pc +acc=bcglnprst+application_cpu_stim} -do application_display_wave.do
```

as_alu_stim:
```
vsim work.as_alu_stim {-voptargs=+acc=bcglnprst+as_alu +acc=bcglnprst+as_alu_stim} -do as_alu_wave.do
```