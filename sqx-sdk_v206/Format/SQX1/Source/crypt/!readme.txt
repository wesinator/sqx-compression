sqx optionally encrypts the compressed data with the AES encryption algorithm.
It uses 128 bit keys and a block size of 128 bit to encrypt the compressed 
data. The password supplied by the user is hashed with the MD5 algorithm
(by RSA Data Security, Inc).

The optional encrytion of the archive headers is done with the Blowfish
encrytion algorithm, developed by Bruce Schneier.

I would like to thank Dr. Brian Gladman for his kind permission to include
his AES implementation into the unsqx sample source. More information on
Dr. Gladman's work can be found at his homepage at
http://fp.gladman.plus.com/cryptography_technology/rijndael/index.htm