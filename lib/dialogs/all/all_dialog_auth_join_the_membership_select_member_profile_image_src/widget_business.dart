// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'widget_view.dart' as widget_view;

// (all)
import '../../../global_functions/gf_my_functions.dart' as gf_my_functions;
import '../../../../repositories/spws/spw_auth_member_info.dart'
    as spw_auth_member_info;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 담당
// PageBusiness 인스턴스는 해당 페이지가 소멸하기 전까지 활용됩니다.
class WidgetBusiness {
  // [콜백 함수]
  // (전체 위젯 처음 실행 콜백)
  void onCreated() {
    // !!!onCreated 로직 작성!!!
  }

  // (전체 위젯 dispose)
  void dispose() {
    // !!!initState 로직 작성!!!
  }

  // (전체 위젯의 FocusDetector 콜백들)
  void onFocusGained() async {
    // !!!onFocusGained 로직 작성!!!

    // 검증된 현재 회원 정보 가져오기 (비회원이라면 null)
    spw_auth_member_info.SharedPreferenceWrapperVo? nowLoginMemberInfo =
        gf_my_functions.getNowVerifiedMemberInfo();

    if (nowLoginMemberInfo != null) {
      // 로그인 상태라면 다이얼로그 닫기
      context.pop();
      return;
    }
  }

  void onFocusLost() async {
    // !!!onFocusLost 로직 작성!!!
  }

  void onVisibilityGained() async {
    // !!!onFocusLost 로직 작성!!!
  }

  void onVisibilityLost() async {
    // !!!onVisibilityLost 로직 작성!!!
  }

  void onForegroundGained() async {
    // !!!onForegroundGained 로직 작성!!!
  }

  void onForegroundLost() async {
    // !!!onForegroundLost 로직 작성!!!
  }

  // [public 변수]
  // (초기화 여부)
  bool onPageCreated = false;

  // (위젯 Context)
  late BuildContext context;

  // (위젯 입력값)
  late widget_view.InputVo inputVo;

  // (페이지 pop 가능 여부 변수)
  bool canPop = true;

  // [private 변수]

  // [public 함수]
  // (Widget 화면 갱신) - WidgetUi.viewWidgetBuild 의 return 값을 다시 불러 옵니다.
  late VoidCallback refreshUi;

  // (다이얼로그 종료 함수)
  void closeDialog() {
    context.pop();
  }

  // (이미지 소스 선택)
  void onResultSelected(widget_view.ImageSourceType imageSourceType) {
    context.pop(widget_view.OutputVo(imageSourceType: imageSourceType));
  }

// [private 함수]
}
