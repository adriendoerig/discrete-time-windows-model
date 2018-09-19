function [ mEnew, pEnew ] = competingIntegratorsStep( mOut, pOutV, pOutAV, mE, pE, dt)
%COMPETINGINTEGRATORSSTEP performs one step of the competition between the
%m- and p-integrators.
%   The first three parameters are the output values of the first stage for
%   the last time-step
%   The 4th and 5th parameters are integrated values of the last time-step.
%   The 6th parameter is the step size (in [s]).

    mTau = .1;
    pTau = .1;
    coupling = 10; % interaction strength between the integrators
    
    mEnew = mE*(1-dt/mTau) + (mOut - coupling*sign(mE)*abs(pE))*dt;
    pEnew = pE*(1-dt/pTau) + (pOutV + pOutAV - coupling*sign(pE)*abs(mE))*dt;
    
end

