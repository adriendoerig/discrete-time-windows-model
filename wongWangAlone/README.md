CODE USED FOR FITTING WONG AND WANG'S (2006) MODEL TO EXPERIMENTAL DATA

- Sequential meta-contrast and vernier fusion experiments can be fitted.

- OPTIMIZEALLWONGWANG finds optimal parameters for all conditions, subjects and averages. It also produces 
  output plots.
  - use expType = 'ruter' to fit the vernier fusion experiment.
  - use expType = 'E4', 'E8' or 'E18' for sequential metacontrast with 4, 8, or 18 flankers in the streams.

- The FITPARAMETERSWONGWANG finds the best model parameters for a given condition and subject. 
  ERRORFITRUTER is called at each step to compute the error. The human experimental data
  is loaded here from the excel files.
    - This returns the optimal parameters pOptimized.
    
- ERRORFITWONGWANG runs many trials of the model (with the parameters passed as input) on one
  experiment type (for example 'E8') and computes the error relative to experimental data.

- WONGWANGVARYINGV simulates performance on one trial and returns the answer, RT and success (=1 if a decision 
  was reached). If no decision is reached, there are two options:
  - Set forceDecision to 0. In this case the model reponse is 0.5 (so between the usual 0 or 1 returned when 
    a decision is reached), and success is set to 1. Hence, the model is not penalized for not making a decision,
    and we assume random guessing in these trials.
  - Set forceDecision to 1. In this case the model reponse is 0.5 (so between the usual 0 or 1 returned when 
    a decision is reached), and success is set to 0. A huge error is added in the optimization process if success=0,
    so the model is heavily penalized for not making a decision.
    
- PLOTOUTPUTWONGWANG uses a set of paramters and runs the model on a desired experiment passed as
  a parameter (e.g. 'E8' for the experiment with a central vernier and 8 stream bars). Output plots are
  produced. This function is used in OPTIMIZEALL.
