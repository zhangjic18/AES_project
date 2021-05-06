# AES加密解密

​	运行demo.m即可得到示例运行结果。

​	加密解密函数如下所示：

```matlab
function ciphertext = AES_encryption(plaintext,password)
%AES加密函数，要求输入明文比特流plaintext长度为128*n，密码比特流password长度为128
%要求比特流为行向量，例如 plaintext = randi([0,1],1,128);password = randi([0,1],1,128);
```

```matlab
function plaintext = AES_decryption(ciphertext,password)
%AES解密函数，要求输入密文比特流ciphertext长度为128*n，密码比特流password长度为128
%要求比特流为行向量，例如 ciphertext = randi([0,1],1,128);password = randi([0,1],1,128);
```

