clc;clear;close all;
plaintext = randi([0,1],1,128);
password = randi([0,1],1,128);
ciphertext = AES_encryption(plaintext,password); %AES���ܣ���������ֻ��Ϊ1��258*n�еı�����������ֻ��Ϊ1��258�еı�����

plaintext_decrypted = AES_decryption(ciphertext,password);%AES����
password(1) = ~password(1);
plaintext_decrypted2 = AES_decryption(ciphertext,password);%AES����

password(1) = ~password(1);
ciphertext(1) = ~ciphertext(1);
plaintext_decrypted3 = AES_decryption(ciphertext,password);%AES����

[~,bit_error_rate] = biterr(plaintext,plaintext_decrypted)   %���������
[~,bit_error_rate2] = biterr(plaintext,plaintext_decrypted2)   %�����һ�����غ󣬼��������
[~,bit_error_rate3] = biterr(plaintext,plaintext_decrypted3)   %���Ĵ�һ�����غ󣬼��������


subplot(2,1,1)
plot(abs(plaintext_decrypted-plaintext_decrypted2))
title("128bit���룬128bit���ģ��������һ�����أ��������������ĵĴ���ͼ��")

subplot(2,1,2)
plot(abs(plaintext_decrypted-plaintext_decrypted3))
title("128bit���룬128bit���ģ����Ĵ���һ�����أ��������������ĵĴ���ͼ��")


