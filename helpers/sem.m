function y = sem(x,flag,dim)
%SEM    Standard error of the mean.
%   For vectors, SEM(X) returns the standard error of the mean. For matrices,
%   STD(X) is a row vector containing the standard error of the mean of each
%   column.  For N-D arrays, SEM(X) is the standard error of the mean of the
%   elements along the first non-singleton dimension of X.
%
%   SEMD(X) normalizes by (N-1) where N is the sequence length. 
%
%   SEM(X,1) normalizes by N. SEM(X,0) is the same as SEM(X).
%
%   SEM(X,FLAG,DIM) takes the standard deviation along the dimension
%   DIM of X.  When FLAG=0 SEM normalizes by (N-1), otherwise SEM
%   normalizes by N.
%
%
%   See also STD, COV, MEAN, VAR, MEDIAN, CORRCOEF.

%   Written on 02-11-2004 by Marek Wypych 02-11-2004 
%   on the base of STD.M by The MathWorks, Inc. 

if nargin<2, flag = 0; end
if nargin<3,
  if isempty(x), y = 0/0; return; end % Empty case without dim argument
  dim = min(find(size(x)~=1));
  if isempty(dim), dim = 1; end
end

% Avoid divide by zero for scalar case
if size(x,dim)==1, y = zeros(size(x)); y(isnan(x))=NaN; return, end

tile = ones(1,max(ndims(x),dim));
tile(dim) = size(x,dim);

xc = x - repmat(sum(x,dim)/size(x,dim),tile);  % Remove mean
if flag,
  y = sqrt(sum(conj(xc).*xc,dim))/size(x,dim);
else
  y = sqrt(sum(conj(xc).*xc,dim)/((size(x,dim))*(size(x,dim)-1)));
end

