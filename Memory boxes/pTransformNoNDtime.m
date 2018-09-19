function [ pTransformed ] = pTransformNoNDtime( p )
%PTRANSFORM Transforms the parameter vector such that all values to
%optimize vary between 0 and 1.

    

    pTransformed = zeros(size(p));

    pTransformed(1) = transform(p(1), 0.2, .7); % readoutTime
    pTransformed(2) = transform(p(2), 0, 1); % tauIntegrate
    pTransformed(3) = transform(p(3), 0, 2); % tauDecay
    pTransformed(4) = transform(p(4), 10, 30); % wongWang_gain
    pTransformed(5) = transform(p(5), 0, 1); % wongWang_sigma
    pTransformed(6) = transform(p(6), 20, 30); % wongWang_mu0

end

function pTransformed = transform(p, pTmin, pTmax)
    if p <0
        pTransformed = pTmin;
    elseif p>.5
        pTransformed = pTmax;
    else
        pTransformed = 2*(pTmax-pTmin)*p+pTmin;
    end
end