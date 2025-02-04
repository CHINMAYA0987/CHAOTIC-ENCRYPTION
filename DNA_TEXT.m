 clc;clear all; close all;

str = 'hello manrata'
ascii_str = uint8(str)
ascii_len = length(ascii_str)
binary_str = transpose(dec2bin(ascii_str,8))
binaryArray = binary_str(:)'

binaryArray = num2str(binaryArray) - '0'            %input to the algorithm
datalen = length(binaryArray);

% Assign sample data.
% binaryArray = [0,1,1,0,0,0,1,1, 0,1,1,1,0,0,1,0, 0,1,1,1,1,0,0,1, 0,1,1,1,0,0,0,0, 0,1,1,1,0,1,0,0, 0,1,1,0,1,1,1,1];
% Define base letters to choose from.
bases = 'ATGC';
% result[];
for k = 1 : 2 : length(binaryArray)
  % Convert these two digits into a number 1 - 4.
  index = 2 * binaryArray(k) + binaryArray(k+1) + 1;
  % Use that index to assign a letter to our result.
  result((k+1)/2) = bases(index);
end
% Display in command window:
result
length(result)
        
%=====DECRYPTION=======

[~,x] = ismember(result,'ATGC')  % Convert the ATGC into indexes
c = {'00','01','10','11'}; 
result = cell2mat(c(x))  % Convert the indexes into the numeric strings

binValues = [ 128 64 32 16 8 4 2 1 ];
bindata = reshape(result,8,ascii_len)
ascii_recv =(binValues*bindata)
dem11 = ones(1,ascii_len)*12240;        %don't know why the output is coming 12240 more than required, thus subtract 12240 from the ascii
opdata = ascii_recv - dem11;
opstr = char(opdata)