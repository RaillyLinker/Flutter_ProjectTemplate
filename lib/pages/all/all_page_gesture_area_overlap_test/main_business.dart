// (external)
import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:go_router/go_router.dart';

// (inner_folder)
import 'main_widget.dart' as main_widget;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/global_widgets/gw_sfw_wrapper.dart'
    as gw_sfw_wrapper;

// [위젯 비즈니스]

//------------------------------------------------------------------------------
class MainBusiness {
  // [CallBack 함수]
  // (inputVo 확인 콜백)
  // State 클래스의 initState 에서 실행 되며, Business 클래스의 initState 실행 전에 실행 됩니다.
  // 필수 정보 누락시 null 을 반환, null 이 반환 되었을 때는 inputError 가 true 가 됩니다.
  main_widget.InputVo? onCheckPageInputVo(
      {required GoRouterState goRouterState}) {
    // !!!pageInputVo 체크!!!
    // ex :
    // if (!goRouterState.uri.queryParameters.containsKey("inputValueString")) {
    //   return null;
    // }

    // !!!PageInputVo 입력!!!
    return const main_widget.InputVo();
  }

  // (진입 최초 단 한번 실행) - 아직 위젯이 생성 되기 전
  void initState() {
    // !!!initState 로직 작성!!!
  }

  // (종료 시점 단 한번 실행)
  void dispose() {
    // !!!dispose 로직 작성!!!
  }

  // (시스템 밝기 설정 변경시 실행)
  void didChangePlatformBrightness() {
    // !!!didChangePlatformBrightness 로직 작성!!!
  }

  // (시스템 언어/국가 설정 변경시 실행)
  void didChangeLocales() {
    // !!!didChangeLocales 로직 작성!!!
  }

  // (최초 실행시 단 한번 실행) - 위젯 build 바로 직전, 모든 것이 준비 되었을 때
  void onCreate() {
    // !!!onCreate 로직 작성!!!
  }

  Future<void> onFocusGainedAsync() async {
    // !!!onFocusGainedAsync 로직 작성!!!
  }

  Future<void> onFocusLostAsync() async {
    // !!!onFocusLostAsync 로직 작성!!!
  }

  Future<void> onVisibilityGainedAsync() async {
    // !!!onVisibilityGainedAsync 로직 작성!!!
  }

  Future<void> onVisibilityLostAsync() async {
    // !!!onVisibilityLostAsync 로직 작성!!!
  }

  Future<void> onForegroundGainedAsync() async {
    // !!!onForegroundGainedAsync 로직 작성!!!
  }

  Future<void> onForegroundLostAsync() async {
    // !!!onForegroundLostAsync 로직 작성!!!
  }

  //----------------------------------------------------------------------------
  // !!!메인 위젯에서 사용할 변수는 이곳에서 저장하여 사용하세요.!!!
  // [public 변수]
  // (위젯 입력값)
  late main_widget.InputVo inputVo;

  // (페이지 pop 가능 여부 변수) - false 로 설정시 pop 불가
  bool canPop = true;

  // (입력값 미충족 여부)
  bool inputError = false;

  // (context 객체)
  late BuildContext mainContext;

  // (최초 실행 플래그)
  bool pageInitFirst = true;

  // (페이지 설정 정보)
  // onCreate, onFocusGainedAsync, didChangePlatformBrightness, didChangeLocales 실행 직전마다 갱신됨
  // 페이지 국가 설정 (KR, US, Jpan, ...)
  // WidgetsBinding.instance.platformDispatcher.locale.countryCode 에서 나오는 값
  late String? countrySetting;

  // 페이지 언어 설정 (ko, en, jpa, ...)
  // WidgetsBinding.instance.platformDispatcher.locale.languageCode 에서 나오는 값
  late String languageSetting;

  // 페이지 밝기 모드 설정 (DARK, LIGHT)
  late String brightnessModeSetting;

  // (pageOutFrameBusiness)
  final gw_slw_page_outer_frame.SlwPageOuterFrameBusiness pageOutFrameBusiness =
      gw_slw_page_outer_frame.SlwPageOuterFrameBusiness();

  // [private 변수]

  //----------------------------------------------------------------------------
  // !!!비즈니스 함수는 이 곳에서 저장 하여 사용 하세요.!!!
  // [public 함수]
  // (메인 위젯 화면 갱신)
  late VoidCallback refreshUi;

  // (Red 영역 클릭)
  void onTapRed() {
    showToast(
      "redAccent",
      context: mainContext,
      animation: StyledToastAnimation.scale,
    );
  }

  // (Blue 영역 외곽 Gesture 클릭)
  void onTapBlueOuter() {
    showToast(
      "onTapBlueOuter",
      context: mainContext,
      animation: StyledToastAnimation.scale,
    );
  }

  // (Blue 영역 내부 Gesture 클릭)
  void onTapBlueInner() {
    showToast(
      "onTapBlueInner",
      context: mainContext,
      animation: StyledToastAnimation.scale,
    );
  }

  // [private 함수]
  void _doNothing() {}
}
