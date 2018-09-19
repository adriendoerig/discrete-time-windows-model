function [ pTransformed ] = pTransformWongWang( p )
%PTRANSFORM Transforms the parameter vector such that all values to
%optimize vary between 0 and 1.

    

    pTransformed = zeros(size(p));

    pTransformed(1) = transform(p(1), 0, 25); % wongWang_gain
    pTransformed(2) = transform(p(2), 0, 10); % wongWang_sigma
    pTransformed(3) = transform(p(3), 0, 25); % wongWang_mu0

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