function [min_error] = minErrorRepresentation(basis,sample)
    % this function finds the best k-rank representation of sample by using 
    %the given basis
    %
    % returns the minimum reconstruction error.
    % this function works up to k=3. If k >3 it can not generate a reasonable result 
    % columns of matrix basis are basis elements
    % columns of matrix scalars are corresponding scalars
    dim_subspace =size(basis,2); dim_featSpace=size(basis,1);
    basis = [basis zeros(dim_featSpace, 3-dim_subspace)];
    func = @(scalars) (scalars(1).*basis(:,1)+scalars(2).*basis(:,2)+scalars(3).*basis(:,3));  
    errfn = @(p) sum((func(p)-sample).^2); %reconstruction error function
    scalar_fit = fminsearch( errfn, [0 0 0]); %scalars which give minimum error reconstruction
    min_error=errfn(scalar_fit);
end