// (external)
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:intl/intl.dart';

// (all)
import '../../../../repositories/spws/spw_sign_in_member_info.dart'
    as spw_sign_in_member_info;
import '../../../../repositories/spws/spw_program_config.dart'
    as spw_program_config;

// [전역 함수 작성 파일]
// 프로그램 전역에서 사용할 함수들은 여기에 모아둡니다.

// -----------------------------------------------------------------------------
// (범위 내의 랜덤 정수를 반환하는 함수)
int getRandomNumberInRange(int min, int max) {
  if (min > max) {
    throw Exception("min value over max value");
  } else if (min == max) {
    return min;
  }

  var random = Random();
  return min + random.nextInt((max + 1) - min);
}

// (anchorDateTime 이 expireDateTime 과 비교하여 만료가 되었는지 비교)
// true : 현재 만료됨, false : 현재 만료 되지 않음
bool isDateExpired(DateTime anchorDateTime, DateTime expireDateTime) {
  return expireDateTime.isBefore(anchorDateTime);
}

// (RequestUrl 에 QueryParam 붙이는 함수)
// ex : queryParams = {"testParam1" : "testParam"}, requestUrl = "/test/url" => "/test/url?testParam1=testParam"
String mergeNetworkQueryParam(
    Map<String, dynamic> queryParams, String requestUrl) {
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

// (위젯에서 앞서 설정한 키 값을 가져오기)
String? getWidgetKeyValue(widgets.Widget widget) {
  if (widget.key == null) {
    return null;
  } else {
    String? widgetKeyString = widget.key.toString(); // ex : <keyValue> or null
    return widgetKeyString.substring(
        widgetKeyString.indexOf('<') + 1, widgetKeyString.indexOf('>'));
  }
}

// (현 시점 검증된 로그인 정보 가져오기)
// 검증된 현재 회원 정보 가져오기 (비회원이라면 null)
spw_sign_in_member_info.SharedPreferenceWrapperVo? getNowVerifiedMemberInfo() {
  spw_sign_in_member_info.SharedPreferenceWrapperVo? nowSignInMemberInfo;

  // Shared Preferences 에 저장된 로그인 유저 정보 가져오기
  spw_sign_in_member_info.SharedPreferenceWrapperVo? signInMemberInfo =
      spw_sign_in_member_info.SharedPreferenceWrapper.get();

  // 로그인 검증 실행
  if (signInMemberInfo != null) {
    bool isAccessTokenExpired = isDateExpired(
        DateTime.now(),
        DateFormat('yyyy-MM-dd HH:mm:ss.SSS')
            .parse(signInMemberInfo.accessTokenExpireWhen));

    if (isAccessTokenExpired) {
      // 액세스 토큰 만료
      // 리플레시 토큰 만료 여부
      bool isRefreshTokenExpired = isDateExpired(
          DateTime.now(),
          DateFormat('yyyy-MM-dd HH:mm:ss.SSS')
              .parse(signInMemberInfo.refreshTokenExpireWhen));

      if (isRefreshTokenExpired) {
        // 리플레시 토큰 만료
        // login_user_info SPW 비우기
        spw_sign_in_member_info.SharedPreferenceWrapper.set(null);
        // 재 로그인이 필요한 상황이므로 비회원으로 다루기
      } else {
        // 리플레시 토큰 만료 되지 않음 = 재발급은 하지 않고 회원 정보 승인
        nowSignInMemberInfo = signInMemberInfo;
      }
    } else {
      // 액세스 토큰 만료 되지 않음 (= 검증된 정상 로그인 정보)
      nowSignInMemberInfo = signInMemberInfo;
    }
  }

  return nowSignInMemberInfo;
}

// (프로그램 현재 설정 반환)
GetNowProgramConfigOutputVo getNowProgramConfig(BuildContext context) {
  // 프로그램 설정 정보 가져오기
  var programConfig = spw_program_config.SharedPreferenceWrapper.get();

  // 페이지 언어 설정 코드 (ex : en, ko, ...)
  String pageLanguageConfigCode;

  // 페이지 국가 설정 코드 (ex : US, KR, ...)
  String? pageCountryConfigCode;

  // 페이지 밝기 테마 설정 코드 (1 : 밝은 테마, 2 : 어두운 테마)
  int pageBrightnessThemeConfigCode;

  if (programConfig == null) {
    // 아직 저장된 정보가 없음
    // 기본 설정(= 시스템 설정 사용)을 저장
    spw_program_config.SharedPreferenceWrapper.set(
        spw_program_config.SharedPreferenceWrapperVo(null, null, null));

    // 시스템 설정 사용
    final Locale locale = View.of(context).platformDispatcher.locale;

    // 페이지 언어 설정 코드 (ex : en, ko, ...)
    pageLanguageConfigCode = locale.languageCode;

    // 페이지 국가 설정 코드 (ex : US, KR, ...)
    pageCountryConfigCode = locale.countryCode;

    // 페이지 밝기 테마 설정 코드 (1 : 밝은 테마, 2 : 어두운 테마)
    pageBrightnessThemeConfigCode =
        (View.of(context).platformDispatcher.platformBrightness ==
                Brightness.light)
            ? 1
            : 2;
  } else {
    if (programConfig.pageLanguageConfigCode == null) {
      // 시스템 설정 사용
      final Locale locale = View.of(context).platformDispatcher.locale;

      // 페이지 언어 설정 코드 (ex : en, ko, ...)
      pageLanguageConfigCode = locale.languageCode;

      // 페이지 국가 설정 코드 (ex : US, KR, ...)
      pageCountryConfigCode = locale.countryCode;
    } else {
      // SPW 저장 설정 사용
      pageLanguageConfigCode = programConfig.pageLanguageConfigCode!;
      pageCountryConfigCode = programConfig.pageCountryConfigCode!;
    }

    if (programConfig.pageBrightnessThemeConfigCode == null) {
      // 시스템 설정 사용

      // 페이지 밝기 테마 설정 코드 (1 : 밝은 테마, 2 : 어두운 테마)
      pageBrightnessThemeConfigCode =
          (View.of(context).platformDispatcher.platformBrightness ==
                  Brightness.light)
              ? 1
              : 2;
    } else {
      // SPW 저장 설정 사용
      pageBrightnessThemeConfigCode =
          programConfig.pageBrightnessThemeConfigCode!;
    }
  }

  return GetNowProgramConfigOutputVo(pageLanguageConfigCode,
      pageCountryConfigCode, pageBrightnessThemeConfigCode);
}

class GetNowProgramConfigOutputVo {
  // 페이지 언어 설정 코드 (ex : en, ko, ...)
  String nowLanguageConfigCode;

  // 페이지 국가 설정 코드 (ex : US, KR, ...)
  String? nowCountryConfigCode;

  // 페이지 밝기 테마 설정 코드 (1 : 밝은 테마, 2 : 어두운 테마)
  int nowBrightnessThemeConfigCode;

  GetNowProgramConfigOutputVo(this.nowLanguageConfigCode,
      this.nowCountryConfigCode, this.nowBrightnessThemeConfigCode);
}
