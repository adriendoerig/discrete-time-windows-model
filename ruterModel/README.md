CODE USED FOR FITTING RUTER ET AL.'S (2012) MODEL TO EXPERIMENTAL DATA

- Sequential meta-contrast and vernier fusion experiments can be fitted.

- OPTIMIZEALL finds optimal parameters for all conditions, subjects and averages. It also produces 
  output plots.
  - use expType = 'ruter' to fit the vernier fusion experiment.
  - use expType = 'E4', 'E8' or 'E18' for sequential metacontrast with 4, 8, or 18 flankers in the streams.

- The FITPARAMETERSRUTER finds the best model parameters for a given condition and subject. 
  ERRORFITRUTER is called at each step to compute the error. The human experimental data
  is loaded here from the excel files.
    - This returns the optimal parameters pOptimized.
    
- ERRORFITRUTER runs many trials of the model (with the parameters passed as input) on one
  experiment type (for example 'E8') and computes the error relative to experimental data.

- DECISIONNEURALNEW Runs the stimuli (representing vernier-antivernier) given in "stims" through a two-stage
  decision model. The integration stage is the same as in Rüter et al., 2012. The decision stage is 
  the neural network described in Wong & Wang (2006). Returns RTs, performance (% of responses to 
  the first stim) and success (=1 if the decision process successfully reached a conclusion, 0 otherwise).
  - WONGWANGNEW is called for the decision stage if Tstart > stimulus duration, using the output of the 
    integration stage as drift rate.
  - WONGWANGVARYINGV is called for the decision stage if Tstart > stimulus duration. In this case, the integration
    keeps going during the decision process, so the drift rate of the decision stage varies.
    
- PLOTOUTPUTRUTER uses a set of paramters and runs the model on a desired experiment passed as
  a parameter (e.g. 'E8' for the experiment with a central vernier and 8 stream bars). Output plots are
  produced. This function is used in OPTIMIZEALL.
  
- PLOTFROMRESULTS loads the optimal parameters from the results folder and plots the same thing as PLOTOUTPUTRUTER, 
  but can be used outside of OPTIMIZEALL. 
