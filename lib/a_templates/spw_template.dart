// (external)
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:sync/semaphore.dart';

// (all)
import 'package:flutter_project_template/global_functions/gf_crypto.dart'
    as gf_crypto;
import 'package:flutter_project_template/global_data/gd_const.dart' as gd_const;

// [SharedPreference Wrapper 선언 파일 템플릿]
// 본 파일은 SharedPreference 변수 하나에 대한 래퍼 클래스 작성용 파일입니다.

// -----------------------------------------------------------------------------
class SharedPreferenceWrapper {
  // (전역 키 이름)
  // !!!전역 키 이름 설정!!!
  // 적용 구역이 전역이므로 중복되지 않도록 spws 안의 파일명을 적을 것
  static const String globalKeyName = "spw_template";

  // (저장 데이터 암호 설정)
  // !!!AES256 에서 사용할 secretKey, secretIv 설정!!!
  // 암복호화에 들어가는 연산량 증가가 존재하지만, 보안적 측면의 우위를 위해 암호화를 사용하기로 결정
  // 암호화 키 (32 byte)
  static const String _secretKey = "aaaaaaaaaabbbbbbbbbbccccccccccdd";

  // 암호 초기화 백터 (16 byte)
  static const String _secretIv = "aaaaaaaaaabbbbbb";

  // (값 입력 세마포어)
  static final Semaphore _semaphore = Semaphore();

  // (SPW 값 가져오기)
  static SharedPreferenceWrapperVo? get() {
    _semaphore.acquire();
    // 키를 사용하여 저장된 jsonString 가져오기
    String savedJsonString =
        gd_const.sharedPreferences.getString(globalKeyName) ?? "";

    if (savedJsonString.trim() == "") {
      // 아직 아무 값도 저장되지 않은 경우
      _semaphore.release();
      return null;
    } else {
      // 저장된 값이 들어있는 경우
      try {
        // 값 복호화
        String decryptedJsonString = gf_crypto.aes256Decrypt(
            cipherText: savedJsonString,
            secretKey: _secretKey,
            secretIv: _secretIv);

        // !!! Map 을 Object 로 변경!!!
        // map 키는 Object 의 변수명과 동일
        Map<String, dynamic> map = jsonDecode(decryptedJsonString);
        var resultObject =
            SharedPreferenceWrapperVo(sampleInt: map["sampleInt"]);
        _semaphore.release();
        return resultObject;
      } catch (e) {
        // 암호 키가 변경되는 등의 이유로 저장된 데이터 복호화시 에러가 난 경우를 가정
        if (kDebugMode) {
          print(e);
        }

        // 기존값을 대신하여 null 값을 집어넣기
        gd_const.sharedPreferences.setString(globalKeyName, "").then((value) {
          _semaphore.release();
        });
        return null;
      }
    }
  }

  // (SPW 값 저장하기)
  static void set({required SharedPreferenceWrapperVo? value}) {
    _semaphore.acquire();
    if (value == null) {
      // 키에 암호화된 값을 저장
      gd_const.sharedPreferences.setString(globalKeyName, "").then((value) {
        _semaphore.release();
      });
    } else {
      // !!!Object 를 Map 으로 변경!!!
      // map 키는 Object 의 변수명과 동일하게 설정
      Map<String, dynamic> map = {"sampleInt": value.sampleInt};

      // 값 암호화
      String encryptedJsonString = gf_crypto.aes256Encrypt(
          plainText: jsonEncode(map),
          secretKey: _secretKey,
          secretIv: _secretIv);

      // 키에 암호화된 값을 저장
      gd_const.sharedPreferences
          .setString(globalKeyName, encryptedJsonString)
          .then((value) {
        _semaphore.release();
      });
    }
  }
}

// !!!저장 정보 데이터 형태 작성!!!
class SharedPreferenceWrapperVo {
  SharedPreferenceWrapperVo({required this.sampleInt});

  int sampleInt; // 샘플 int 데이터
}
