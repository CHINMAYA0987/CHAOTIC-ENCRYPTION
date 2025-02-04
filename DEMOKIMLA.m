clc;clear all; close all;

str = 'kimla trial';
ascii_str = uint8(str)
binary_str = transpose(dec2bin(ascii_str,8));
% binary_str = str2num(binary_str)
binary_str = binary_str(:);
bin_num_message = str2num(binary_str)

ascii_len = length(ascii_str);
bin_len = ascii_len*8;
len = bin_len;


%======================STEGO===============================================
% for kimla, we need the first 4 msb of the pixel in which we are to hide
% the data. Convert these 4 bits to decimal, then find the next number of
% that binary. Convert the next decimal to binary and find the number of
% ones in it. The number of ones shows the number of bits that can be hidden
% in it. 
% ex:- a pixel has 4 msb = 0010 =>decimal 2 thus the next is decimal 3 i.e. 
% 0011 thus in the given pixel 2 bits of data can be hidden.
% s1- find the 4msb of the given pixel
% s2- convert it to decimal and get its next number
% s3- convert that number to binary and count the number of ones
% s4- hide that many bits in the pixel that you have in the count


input = imread('IPtest.png');
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
		if(embed_counter <= len)
			
			% Finding the Least Significant Bit of the current pixel
			LSB = mod(double(input(i, j)), 2);
			
			% Find whether the bit is same or needs to change
			temp = double(xor(LSB, bin_num_message(embed_counter)));
			
			% Updating the output to input + temp
			output(i, j) = input(i,j)+temp;
			
			% Increment the embed counter
			embed_counter = embed_counter+1;
		end
		
	end
end

% Write both the input and output images to local storage
% Mention the path to a folder here.
% imwrite(input, 'D:\MATLAB\Projects\KIMLA');
imwrite(output, 'D:\MATLAB\Projects\KIMLA\OPKIMLA1.png');

IPxl = 'D:\MATLAB\Projects\KIMLA\IPKIMLA.xlsx';
OPxl = 'D:\MATLAB\Projects\KIMLA\OPKIMLA.xlsx';

% xlswrite(IPxl, input);
% xlswrite(OPxl, output);


% filename = 'D:\MATLAB\Projects\CH_IMAGE\LSB-GFG\ip.xlsx';
% xlswrite(filename, input);

%  I = imread('originalImage.png');
%  J = imread('sam3.png');
% 
%  figure
%  imshow(I);
%   
%  figure
%  imshow(J);
%  
%  %***********histogram************
%  
%  figure;
%  imhist(I);
%  
%  figure;
%  imhist(J);
%==========================================================================
%==========================================================================


% Get height and width for traversing through the image
input_image = imread('OPKIMLA1.png');
height = size(input_image, 1);
width = size(input_image, 2);

% Number of characters of the hidden text
chars = ascii_len;
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

%================OUTPUT STRING=============================================
binValues = [ 128 64 32 16 8 4 2 1 ];
op_data = reshape(extracted_bits,8, chars);
textString = char(binValues*op_data)