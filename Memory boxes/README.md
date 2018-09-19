CODE USED FOR FITTING THE MEMORY BOXES MODEL TO SEQUENTIAL META-CONTRAST DATA

- OPTIMIZEALL finds optimal parameters for all conditions, subjects and averages. It also produces 
  output plots.

- The FITPARAMETERSBOXES family finds the best model parameters for a given condition and subject. 
  Different members of this function family use a fixed value for certain parameters (for example,
  FITPARAMETERSBOXESNONDTIME uses a fixed value for the parameter NDTIME).
    - This returns the optimal parameters pOpt.
    
 - The PLOTOUTPUT family uses a set of paramters and runs the model on a desired experiment passed as
   a parameter (e.g. 'E8' for the experiment with a central vernier and 8 stream bars). Output plots are
   produced.
