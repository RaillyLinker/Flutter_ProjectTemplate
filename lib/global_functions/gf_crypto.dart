// (external)
import 'dart:convert';
import 'package:encrypt/encrypt.dart';

// [전역 함수 작성 파일]
// 프로그램 전역에서 사용할 함수들은 여기에 모아둡니다.

// -----------------------------------------------------------------------------
// (Base64 인코딩)
String base64Encode({required String plainText}) {
  return base64.encode(utf8.encode(plainText));
}

////
// (Base64 디코딩)
String base64Decode({required String encodedText}) {
  return utf8.decode(base64.decode(encodedText));
}

////
// (AES 256 암호화 함수)
// plainText 가 "" 라면 에러 발생
// plainText : 암호화하려는 평문
// secretKey : 암호화 키 (32 byte)
// secretIv : 암호 초기화 백터 (16 byte)
String aes256Encrypt(
    {required String plainText,
    required String secretKey,
    required String secretIv}) {
  return base64.encode(
      Encrypter(AES(Key.fromUtf8(secretKey), mode: AESMode.cbc))
          .encrypt(plainText, iv: IV.fromUtf8(secretIv))
          .bytes);
}

////
// (AES 256 복호화 함수)
// cipherText 가 "" 라면 에러 발생
// cipherText : 복호화하려는 암호문
// secretKey : 암호화 키 (32 byte)
// secretIv : 암호 초기화 백터 (16 byte)
String aes256Decrypt(
    {required String cipherText,
    required String secretKey,
    required String secretIv}) {
  return Encrypter(AES(Key.fromUtf8(secretKey), mode: AESMode.cbc))
      .decrypt64(cipherText, iv: IV.fromUtf8(secretIv));
}
