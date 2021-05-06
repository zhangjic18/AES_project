clc;clear;close all;
plaintext = randi([0,1],1,128);
password = randi([0,1],1,128);
ciphertext = AES_encryption(plaintext,password); %AES加密，输入明文只能为1行258*n列的比特流，密码只能为1行258列的比特流

plaintext_decrypted = AES_decryption(ciphertext,password);%AES解密
password(1) = ~password(1);
plaintext_decrypted2 = AES_decryption(ciphertext,password);%AES解密

password(1) = ~password(1);
ciphertext(1) = ~ciphertext(1);
plaintext_decrypted3 = AES_decryption(ciphertext,password);%AES解密

[~,bit_error_rate] = biterr(plaintext,plaintext_decrypted)   %计算错误率
[~,bit_error_rate2] = biterr(plaintext,plaintext_decrypted2)   %密码错一个比特后，计算错误率
[~,bit_error_rate3] = biterr(plaintext,plaintext_decrypted3)   %密文错一个比特后，计算错误率


subplot(2,1,1)
plot(abs(plaintext_decrypted-plaintext_decrypted2))
title("128bit密码，128bit明文，密码错误一个比特，解密所得与明文的错误图案")

subplot(2,1,2)
plot(abs(plaintext_decrypted-plaintext_decrypted3))
title("128bit密码，128bit明文，密文错误一个比特，解密所得与明文的错误图案")


