CODE USED FOR FITTING THE MEMORY BOXES MODEL TO SEQUENTIAL META-CONTRAST DATA

- OPTIMIZEALL finds optimal parameters for all conditions, subjects and averages. It also produces 
  output plots.

- The FITPARAMETERSBOXES family finds the best model parameters for a given condition and subject. 
  Different members of this function family use a fixed value for certain parameters (for example,
  FITPARAMETERSBOXESNONDTIME uses a fixed value for the parameter NDTIME). A function from the 
  ERRORFITBOXES family is called at each step to compute the error. The human experimental data
  is loaded here from the excel files.
    - This returns the optimal parameters pOpt.
    
- The ERRORFITBOXES family runs many trials of the model (with the parameters passed as input) on one
  experiment type (for example 'E8') and computes the error relative to experimental data.

- RUNTRIAL simulates performance on one trial and returns the answer and RT.
  - MEMORYBOXESDYNAMICSDIFFERENTDURATION manages the memory boxes and returns their output. Different
    boxes are allowed to have different durations. The output is the sum of all box activities at readout
    time. There is an option there to plot the memory traces.
    of each box.
  - WONGWANG BOXES takes the output from MEMORYBOXESDYNAMICSDIFFERENTDURATION as the drift rate for the neural
    decision process (see Wong & Wang, 2006). There is an option here to plot neural decision traces.
    
- The PLOTOUTPUT family uses a set of paramters and runs the model on a desired experiment passed as
  a parameter (e.g. 'E8' for the experiment with a central vernier and 8 stream bars). Output plots are
  produced.
