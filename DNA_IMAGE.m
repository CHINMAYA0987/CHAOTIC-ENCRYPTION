clc;clear all; close all;

str = 'hello world'
ascii_str = uint8(str)
ascii_len = length(ascii_str)
binary_str = transpose(dec2bin(ascii_str,8))
binaryArray = binary_str(:)'

binaryArray = num2str(binaryArray) - '0'            %input to the algorithm
datalen = length(binaryArray)

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
%=================for stego=================
ascii_stego = uint8(result)
asciiStegoLen = length(ascii_stego)

binary_stego = transpose(dec2bin(ascii_stego,8))
binaryStegoArray = binary_stego(:)'
binaryStegoLen = asciiStegoLen * 8;

binaryStegoArray = num2str(binaryStegoArray) - '0';
bin_num_message = transpose(binaryStegoArray(:)')




input = imread('testIP.png');
% Initialize output as input
output = input;
height = size(input, 1);
width = size(input, 2);

% Counter for number of embedded bits
embed_counter = 1;

% Traverse through the image
for i = 1 : height
	for j = 1 : width
		
		% If more bits are remaining to embed
		if(embed_counter <= binaryStegoLen)
			
			% Finding the Least Significant Bit of the current pixel
			LSB = mod(double(input(i, j)), 2);
			
			% Find whether the bit is same or needs to change
			temp = double(xor(LSB, bin_num_message(embed_counter)));
			
			% Updating the output to input + temp
			output(i, j) = input(i, j)+temp;
			
			% Increment the embed counter
			embed_counter = embed_counter+1;
		end
		
	end
end

% Write both the input and output images to local storage
% Mention the path to a folder here.
% imwrite(input, 'D:\MATLAB\Projects\CH_IMAGE\LSB-GFG\originalImage.png');
imwrite(output, 'D:\MATLAB\Projects\DNA\sam1.png');






input_image = imread('sam1.png');
height = size(input_image, 1);
width = size(input_image, 2);

% Number of characters of the hidden text
chars = asciiStegoLen;
message_length = chars * 8;

% counter to keep track of number of bits extracted
counter = 1;

% Traverse through the image
for i = 1 : height
	for j = 1 : width
		
		% If more bits remain to be extracted
		if (counter <= message_length)
			
			% Store the LSB of the pixel in extracted_bits
			extracted_bits(counter, 1) = mod(double(input_image(i, j)), 2);
			
			% Increment the counter
			counter = counter + 1;
		end
	end
end

% extracted_bits
bin_recieved_message = transpose(extracted_bits(:))
bin_reshaped_mtx = reshape(bin_recieved_message, 8, asciiStegoLen)
binValues = [ 128 64 32 16 8 4 2 1 ];
asciiStegoRcv =char(binValues*bin_reshaped_mtx)
% binaryRecievedArray = num2str(bin_recieved_message) + '0';
% 
% binary_recieved = transpose(dec2bin(ascii_stego,8))




%=====DECRYPTION=======

[~,x] = ismember(asciiStegoRcv,'ATGC');  % Convert the ATGC into indexes
c = {'00','01','10','11'}; 
result = cell2mat(c(x))  % Convert the indexes into the numeric strings

binValues = [ 128 64 32 16 8 4 2 1 ];
bindata = reshape(result,8,ascii_len)
ascii_recv =(binValues*bindata)
dem11 = ones(1,ascii_len)*12240;        %don't know why the output is coming 12240 more than required, thus subtract 12240 from the ascii
opdata = ascii_recv - dem11;
opstr = char(opdata)