clc;
clear all;
close all;

%==========================================================================
%*****MESSAGE-ASCII-BINARY*****
str = 'hello world'
% ascii_str = double(str)
% binary_str = dec2bin(ascii_str)
% binary_str = binary_str(:)';

ascii_str = uint8(str);
binary_str = transpose(dec2bin(ascii_str,8));
% binary_str = transpose(dec2bin(ascii_str,7))
% binary_str = str2num(binary_str)
binary_str = binary_str(:)'

ascii_len = length(ascii_str);
bin_len = ascii_len*8;
% bin_len = ascii_len*7;

%==============================================
%******CHAOTIC*******

%********USING BINARY LENGTH*********
% r = 3.62;
% x(1) = 0.7;
% for n=1:bin_len-1
%     x(n+1) = r*x(n)*(1-x(n));      
% end
% [so,in] = sort(x)                 % 'in' stores the random position generated by the equation

%=======================================
%**********ELLIPSE BASED EQUATION*******
width = 9;
numberOfPoints = 50000;
% rand() to get points randomly located within a square.
% x = width * rand(1, numberOfPoints) - width/2;
y = width * rand(1, numberOfPoints) - width/2;

inEllipse = (5 * x .^ 2 + 21 * x .* y + 25 * y .^ 2) <= 9; 
xInEllipse = x(inEllipse);
%********RANDOM NUM GENERATION************
xInEllipse(1) = 1;
for n=2:bin_len-1
    X(n+1) = xInEllipse(n-1) ;  
end
[so,in] = sort(X);                       % 'in' stores the random position generated by the equation

%============================================================
%********ENCRYPTION************

% ascii_data = reshape(binary_str,8,[])
ascii_data = reshape(binary_str,bin_len,1)          %col. vector of the binary
encrdata=[];
for m = 1:bin_len
    encrdata(m)= ascii_data(in(m));                 %encrdata(1) = ascii(in(1)) i.e. ascii(43)rd element
end
% DataEncr = str2num(encrdata);
DataEncr=reshape(encrdata,1,bin_len);                %here 0 is taken as 48 and 1 is taken as 49 


bin_message = transpose(dec2bin(DataEncr,8));
bin_message = bin_message(:);



%*******USING ASCII LENGTH**********
% r = 3.62;
% x(1) = 0.7;
% for n=1:ascii_len-1
%     x(n+1) = r*x(n)*(1-x(n));
% end
% [so,in] = sort(x);
% 
% ascii_data = reshape(ascii_str,ascii_len,1)
% encrdata=[];
% for m = 1:ascii_len
%     encrdata(m)=ascii_data(in(m));
% end
% DataEncr=reshape(encrdata,1,ascii_len)
% 
% bin_message = transpose(dec2bin(DataEncr, 8))
% % bin_message = transpose(dec2bin(DataEncr, 7))
% bin_message = bin_message(:);



N = length(bin_message);
bin_num_message=str2num(bin_message);

%=========================================
%***********CHECK************
%********for binary****
dem01 = ones(1,bin_len)*48;
dem02 = DataEncr - dem01;
test2 = reshape(dem02,8,ascii_len);
binValues = [ 128 64 32 16 8 4 2 1 ];
textbin = char(binValues*test2);



%*******for ascii********
% test1 = reshape(bin_message,8,ascii_len);
% binValues = [ 128 64 32 16 8 4 2 1 ];
% textbin = char(binValues*test1)
% 
% 

%==========================================================================


%==========================================================================
%******DECRYPT CHAOTIC**********

binValues = [ 128 64 32 16 8 4 2 1 ];
% binValues = [ 64 32 16 8 4 2 1 ];


%**********DECRYPT FOR BINARY***********

% % op_data = reshape(bin_num_message,8, ascii_len)
op_data = reshape(bin_num_message,8, bin_len);
dec_data = (binValues*op_data);
dem11 = ones(1,bin_len)*48;
dem12 =  dec_data - dem11                      %since 0 is 48 and 1 is 49 we must 
% res = repmat(binValues,1,size(op_data,bin_len))

%do an operation to convert 8by64 matrix into a col. matrix only then we
%will be able to find out the positions of the bits.

% decr_data=[];
% for m = 1:bin_len
%    decr_data(in(m))=op_data(m);
% end
decr_data=[];
for m = 1:bin_len
   decr_data(in(m))=dem12(m);
end
Data_decr = reshape(decr_data,1, bin_len)

bindata = reshape(Data_decr,8,ascii_len)
ascii_recv = char(binValues*bindata)






%*******DECRYPT FOR ASCII**********

% op_data = reshape(bin_num_message,8, ascii_len)
% % op_data = reshape(bin_num_message,7, ascii_len)
% textString = char(binValues*op_data);
%  
% disp(textString);
% 
% ascii_decr = uint8(textString)
% 
% decrdata=[];
% for m = 1:ascii_len
%     decrdata(in(m))=ascii_decr(m);
% end
% DataDecr=reshape(decrdata,1,ascii_len);
% Data = char(DataDecr)
