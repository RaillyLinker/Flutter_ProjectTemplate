// (external)
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:sync/semaphore.dart';

// (all)
import 'package:flutter_project_template/global_data/gd_const.dart' as gd_const;
import 'package:flutter_project_template/global_functions/gf_crypto.dart'
    as gf_crypto;

// [SharedPreference Wrapper 선언 파일 템플릿]
// 본 파일은 SharedPreference 변수 하나에 대한 래퍼 클래스 작성용 파일입니다.

// -----------------------------------------------------------------------------
class SharedPreferenceWrapper {
  // (전역 키 이름)
  // !!!전역 키 이름 설정!!!
  // 적용 구역이 전역이므로 중복되지 않도록 spws 안의 파일명을 적을 것
  static const String globalKeyName = "spw_auth_member_info";

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

        var oAuth2List = List<Map<String, dynamic>>.from(map["myOAuth2List"]);
        List<SharedPreferenceWrapperVoOAuth2Info> oAuth2ObjectList = [];
        for (Map<String, dynamic> oAuth2 in oAuth2List) {
          oAuth2ObjectList.add(SharedPreferenceWrapperVoOAuth2Info(
              oAuth2["uid"], oAuth2["oauth2TypeCode"], oAuth2["oauth2Id"]));
        }

        var myProfileList =
            List<Map<String, dynamic>>.from(map["myProfileList"]);
        List<SharedPreferenceWrapperVoProfileInfo> myProfileObjectList = [];
        for (Map<String, dynamic> profile in myProfileList) {
          myProfileObjectList.add(SharedPreferenceWrapperVoProfileInfo(
              profile["uid"], profile["imageFullUrl"], profile["isFront"]));
        }

        var myEmailList = List<Map<String, dynamic>>.from(map["myEmailList"]);
        List<SharedPreferenceWrapperVoEmailInfo> myEmailObjectList = [];
        for (Map<String, dynamic> email in myEmailList) {
          myEmailObjectList.add(SharedPreferenceWrapperVoEmailInfo(
              uid: email["uid"],
              emailAddress: email["emailAddress"],
              isFront: email["isFront"]));
        }

        var myPhoneNumberList =
            List<Map<String, dynamic>>.from(map["myPhoneNumberList"]);
        List<SharedPreferenceWrapperVoPhoneInfo> myPhoneNumberObjectList = [];
        for (Map<String, dynamic> phone in myPhoneNumberList) {
          myPhoneNumberObjectList.add(SharedPreferenceWrapperVoPhoneInfo(
              uid: phone["uid"],
              phoneNumber: phone["phoneNumber"],
              isFront: phone["isFront"]));
        }

        var resultObject = SharedPreferenceWrapperVo(
            map["memberUid"],
            map["nickName"],
            List<String>.from(map["roleList"]),
            map["tokenType"],
            map["accessToken"],
            map["accessTokenExpireWhen"],
            map["refreshToken"],
            map["refreshTokenExpireWhen"],
            oAuth2ObjectList,
            myProfileObjectList,
            myEmailObjectList,
            myPhoneNumberObjectList,
            map["authPasswordIsNull"]);
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

      List<Map<String, dynamic>> myOAuth2MapList = [];
      for (SharedPreferenceWrapperVoOAuth2Info oAuth2 in value.myOAuth2List) {
        myOAuth2MapList.add({
          "uid": oAuth2.uid,
          "oauth2TypeCode": oAuth2.oauth2TypeCode,
          "oauth2Id": oAuth2.oauth2Id
        });
      }

      List<Map<String, dynamic>> myProfileList = [];
      for (SharedPreferenceWrapperVoProfileInfo profile
          in value.myProfileList) {
        myProfileList.add({
          "uid": profile.uid,
          "imageFullUrl": profile.imageFullUrl,
          "isFront": profile.isFront
        });
      }

      List<Map<String, dynamic>> myEmailList = [];
      for (SharedPreferenceWrapperVoEmailInfo myEmail in value.myEmailList) {
        myEmailList.add({
          "uid": myEmail.uid,
          "emailAddress": myEmail.emailAddress,
          "isFront": myEmail.isFront
        });
      }

      List<Map<String, dynamic>> myPhoneNumberList = [];
      for (SharedPreferenceWrapperVoPhoneInfo myPhone
          in value.myPhoneNumberList) {
        myPhoneNumberList.add({
          "uid": myPhone.uid,
          "phoneNumber": myPhone.phoneNumber,
          "isFront": myPhone.isFront
        });
      }

      Map<String, dynamic> map = {
        "memberUid": value.memberUid,
        "nickName": value.nickName,
        "roleList": value.roleList,
        "tokenType": value.tokenType,
        "accessToken": value.accessToken,
        "accessTokenExpireWhen": value.accessTokenExpireWhen,
        "refreshToken": value.refreshToken,
        "refreshTokenExpireWhen": value.refreshTokenExpireWhen,
        "myOAuth2List": myOAuth2MapList,
        "myProfileList": myProfileList,
        "myEmailList": myEmailList,
        "myPhoneNumberList": myPhoneNumberList,
        "authPasswordIsNull": value.authPasswordIsNull
      };

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
  SharedPreferenceWrapperVo(
      this.memberUid,
      this.nickName,
      this.roleList,
      this.tokenType,
      this.accessToken,
      this.accessTokenExpireWhen,
      this.refreshToken,
      this.refreshTokenExpireWhen,
      this.myOAuth2List,
      this.myProfileList,
      this.myEmailList,
      this.myPhoneNumberList,
      this.authPasswordIsNull);

  int memberUid; // 멤버 고유값
  String nickName; // 닉네임
  List<String>
      roleList; // 멤버 권한 리스트 (1 : 관리자(ROLE_ADMIN), 2 : 유저(ROLE_USER), 3 : 개발자(ROLE_DEVELOPER)) (ex : [1, 2])
  String tokenType; // 발급받은 토큰 타입(ex : "Bearer")
  String accessToken; // 액세스 토큰 (ex : "aaaaaaaaaa111122223333")
  String accessTokenExpireWhen; // 액세스 토큰 만료일시 (ex : "2023-01-02 11:11:11.111")
  String refreshToken; // 리플레시 토큰 (ex : "rrrrrrrrrr111122223333")
  String
      refreshTokenExpireWhen; // 리플레시 토큰 만료일시 (ex : "2023-01-02 11:11:11.111")
  List<SharedPreferenceWrapperVoOAuth2Info>
      myOAuth2List; // 내가 등록한 OAuth2 정보 리스트
  List<SharedPreferenceWrapperVoProfileInfo>
      myProfileList; // 내가 등록한 Profile 정보 리스트
  List<SharedPreferenceWrapperVoEmailInfo> myEmailList; // 내가 등록한 이메일 정보 리스트
  List<SharedPreferenceWrapperVoPhoneInfo>
      myPhoneNumberList; // 내가 등록한 전화번호 정보 리스트
  bool
      authPasswordIsNull; // 계정 로그인 비밀번호 설정 Null 여부 (OAuth2 만으로 회원가입한 경우는 비밀번호가 없으므로 true)
}

class SharedPreferenceWrapperVoOAuth2Info {
  SharedPreferenceWrapperVoOAuth2Info(
      this.uid, this.oauth2TypeCode, this.oauth2Id);

  int uid; // 행 고유값
  int oauth2TypeCode; // OAuth2 (1 : Google, 2 : Naver, 3 : Kakao, 4 : Apple)
  String oauth2Id; // oAuth2 고유값 아이디
}

class SharedPreferenceWrapperVoProfileInfo {
  SharedPreferenceWrapperVoProfileInfo(
      this.uid, this.imageFullUrl, this.isFront);

  int uid; // 행 고유값
  String imageFullUrl; // 프로필 이미지 Full URL
  bool isFront; //대표 프로필 여부

  @override
  String toString() {
    return "{uid : $uid, imageFullUrl : \"$imageFullUrl\", isFront : $isFront}";
  }
}

class SharedPreferenceWrapperVoEmailInfo {
  SharedPreferenceWrapperVoEmailInfo(
      {required this.uid, required this.emailAddress, required this.isFront});

  int uid; // 행 고유값
  String emailAddress; // 이메일 주소
  bool isFront; //대표 프로필 여부

  @override
  String toString() {
    return "{uid : $uid, emailAddress : \"$emailAddress\", isFront : $isFront}";
  }
}

class SharedPreferenceWrapperVoPhoneInfo {
  SharedPreferenceWrapperVoPhoneInfo(
      {required this.uid, required this.phoneNumber, required this.isFront});

  int uid; // 행 고유값
  String phoneNumber; // 전화번호
  bool isFront; //대표 프로필 여부

  @override
  String toString() {
    return "{uid : $uid, phoneNumber : \"$phoneNumber\", isFront : $isFront}";
  }
}
