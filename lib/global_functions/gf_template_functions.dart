// (external)
import 'package:flutter/cupertino.dart';

// (page)
import '../repositories/spws/spw_program_setting.dart' as spw_program_setting;

// [전역 함수 작성 파일]
// 프로그램 전역에서 사용할 함수들은 여기에 모아둡니다.

// -----------------------------------------------------------------------------
// (RequestUrl 에 QueryParam 붙이는 함수)
// ex : queryParams = {"testParam1" : "testParam"}, requestUrl = "/test/url" => "/test/url?testParam1=testParam"
String mergeNetworkQueryParam(
    {required Map<String, dynamic> queryParams, required String requestUrl}) {
  StringBuffer resultUrl = StringBuffer(requestUrl);

  int idx = 0;
  queryParams.forEach((key, value) {
    if (value is List) {
      int innerIdx = 0;
      for (dynamic listValue in value) {
        if (idx == 0 && innerIdx == 0) {
          if (listValue != null) {
            resultUrl.write("?$key=$listValue");
          }
        } else {
          if (listValue != null) {
            resultUrl.write("&$key=$listValue");
          }
        }
        ++innerIdx;
      }
    } else {
      if (idx == 0) {
        if (value != null) {
          resultUrl.write("?$key=$value");
        }
      } else {
        if (value != null) {
          resultUrl.write("&$key=$value");
        }
      }
    }
    ++idx;
  });

  return resultUrl.toString();
}

// (현재 프로그램 세팅 정보를  반환 하는 함수)
// SPW 에 저장된 설정이 없다면 시스템 설정을 반환 하고, SPW 에 저장된 설정이 있다면 저장된 설정을 반환 합니다.
GetPageSettingValueOutputVo getNowProgramSetting() {
  String? countrySetting;
  String languageSetting;
  String brightnessModeSetting;

  var systemSettingSpw = spw_program_setting.SharedPreferenceWrapper.get();
  if (systemSettingSpw == null) {
    countrySetting =
        WidgetsBinding.instance.platformDispatcher.locale.countryCode;
    languageSetting =
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    brightnessModeSetting =
        WidgetsBinding.instance.platformDispatcher.platformBrightness ==
                Brightness.dark
            ? "dark"
            : "light";
  } else {
    if (systemSettingSpw.settingCountry == "SYSTEM_SETTING") {
      countrySetting =
          WidgetsBinding.instance.platformDispatcher.locale.countryCode;
    } else {
      countrySetting = systemSettingSpw.settingCountry;
    }

    if (systemSettingSpw.settingLanguage == "SYSTEM_SETTING") {
      languageSetting =
          WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    } else {
      languageSetting = systemSettingSpw.settingLanguage;
    }

    if (systemSettingSpw.settingBrightnessMode == "SYSTEM_SETTING") {
      brightnessModeSetting =
          WidgetsBinding.instance.platformDispatcher.platformBrightness ==
                  Brightness.dark
              ? "dark"
              : "light";
    } else {
      brightnessModeSetting = systemSettingSpw.settingBrightnessMode;
    }
  }

  return GetPageSettingValueOutputVo(
      countrySetting: countrySetting,
      languageSetting: languageSetting,
      brightnessModeSetting: brightnessModeSetting);
}

class GetPageSettingValueOutputVo {
  GetPageSettingValueOutputVo({
    required this.countrySetting,
    required this.languageSetting,
    required this.brightnessModeSetting,
  });

  // 페이지 국가 설정 (KR, US, Jpan, ...)
  // WidgetsBinding.instance.platformDispatcher.locale.countryCode 에서 나오는 값
  String? countrySetting;

  // 페이지 언어 설정 (ko, en, jpa, ...)
  // WidgetsBinding.instance.platformDispatcher.locale.languageCode 에서 나오는 값
  String languageSetting;

  // 페이지 밝기 모드 설정 (DARK, LIGHT)
  String brightnessModeSetting;
}
