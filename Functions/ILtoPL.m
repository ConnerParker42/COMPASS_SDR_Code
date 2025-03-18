%% FUNCTION: Interleaved to Planar
% Author: Justin Pedersen
% Date: 07/14/22
% Description: converts interleaved data from GNU Radio output bins to
% planar format.

function [A,B] = ILtoPL(input)

A = input(1:2:end);
B = input(2:2:end);

end