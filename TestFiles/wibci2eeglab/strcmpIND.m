function [ presentAt ] = strcmpIND( inCell, findCell, caseMatch )
%strcmpIND Finds findCell in inCell and returns an index vector

if nargin < 3
    caseMatch = 1;
end

presentAt = zeros(size(findCell));

for i=1:max(size(findCell))
    if(caseMatch)
        ind = find(strcmp(inCell, findCell{i}), 1);
    else
        ind = find(strcmpi(inCell, findCell{i}), 1);
    end
    if(~isempty(ind))
        presentAt(i) = ind;
    end
end

presentAt = presentAt(presentAt ~=0);
end

