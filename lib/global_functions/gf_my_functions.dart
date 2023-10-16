// (external)
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:flutter/widgets.dart' as widgets;
import 'package:intl/intl.dart';

// (all)
import '../../../../repositories/spws/spw_auth_member_info.dart'
    as spw_sign_in_member_info;

// [전역 함수 작성 파일]
// 프로그램 전역에서 사용할 함수들은 여기에 모아둡니다.

// -----------------------------------------------------------------------------
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
    // 액세스 토큰 만료 시간이 지났는지 확인
    bool isAccessTokenExpired = DateFormat('yyyy-MM-dd HH:mm:ss.SSS')
        .parse(signInMemberInfo.accessTokenExpireWhen)
        .isBefore(DateTime.now());

    if (isAccessTokenExpired) {
      // 액세스 토큰 만료
      // 리플레시 토큰 만료 시간이 지났는지 확인
      bool isRefreshTokenExpired = DateFormat('yyyy-MM-dd HH:mm:ss.SSS')
          .parse(signInMemberInfo.refreshTokenExpireWhen)
          .isBefore(DateTime.now());

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

// Gif 정보 가져오기
GetGifDetailsOutputVo getGifDetails(ByteData data) {
  // GIF 이미지 데이터 로드
  var gif = img.decodeGifAnimation(data.buffer.asUint8List());

  if (gif == null) throw 'Failed to decode gif';

  int duration = gif.frames.isEmpty ? 0 : gif.frames[0].duration;

  return GetGifDetailsOutputVo(gif.numFrames, duration);
}

class GetGifDetailsOutputVo {
  int frameCount;
  int duration;

  GetGifDetailsOutputVo(
    this.frameCount,
    this.duration,
  );
}
