// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// (inner_folder)
import 'main_widget.dart' as main_widget;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/global_widgets/gw_sfw_wrapper.dart'
    as gw_sfw_wrapper;
import 'package:flutter_project_template/repositories/spws/spw_test_sample.dart'
    as spw_test_sample;

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

    // 초기 SPW 값 가져오기
    var value = spw_test_sample.SharedPreferenceWrapper.get();

    if (value == null) {
      sampleInt = null;
      sampleString = null;

      sampleIntAreaGk.currentState?.refreshUi();
      sampleStringAreaGk.currentState?.refreshUi();
    } else {
      sampleInt = value.sampleInt;
      sampleString = "\"${value.sampleString}\"";

      sampleIntAreaGk.currentState?.refreshUi();
      sampleStringAreaGk.currentState?.refreshUi();
    }
  }

  // (종료 시점 단 한번 실행)
  void dispose() {
    // !!!dispose 로직 작성!!!
    sampleIntTextFieldController.dispose();
    sampleIntTextFieldFocus.dispose();
    sampleStringTextFieldController.dispose();
    sampleStringTextFieldFocus.dispose();
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

  // (pageOutFrameBusiness)
  final gw_slw_page_outer_frame.SlwPageOuterFrameBusiness pageOutFrameBusiness =
      gw_slw_page_outer_frame.SlwPageOuterFrameBusiness();

  final String spwKey = spw_test_sample.SharedPreferenceWrapper.globalKeyName;

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState>
      sampleIntTextFieldAreaGk = GlobalKey();
  late BuildContext sampleIntTextFieldContext;
  final TextEditingController sampleIntTextFieldController =
      TextEditingController();
  final FocusNode sampleIntTextFieldFocus = FocusNode();
  String? sampleIntTextFieldErrorMsg;

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState>
      sampleStringTextFieldAreaGk = GlobalKey();
  late BuildContext sampleStringTextFieldContext;
  final TextEditingController sampleStringTextFieldController =
      TextEditingController();
  final FocusNode sampleStringTextFieldFocus = FocusNode();
  String? sampleStringTextFieldErrorMsg;

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> sampleIntAreaGk =
      GlobalKey();
  late BuildContext sampleIntContext;
  int? sampleInt;

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> sampleStringAreaGk =
      GlobalKey();
  late BuildContext sampleStringContext;
  String? sampleString;

  // [private 변수]

  //----------------------------------------------------------------------------
  // !!!비즈니스 함수는 이 곳에서 저장 하여 사용 하세요.!!!
  // [public 함수]
  // (메인 위젯 화면 갱신)
  late VoidCallback refreshUi;

  // (SP 값 변경 버튼 클릭시)
  void spValueChangeBtnClick() {
    sampleIntTextFieldErrorMsg = null;
    sampleStringTextFieldErrorMsg = null;
    sampleIntAreaGk.currentState?.refreshUi();
    sampleStringAreaGk.currentState?.refreshUi();

    String sampleIntInput = sampleIntTextFieldController.text;
    String sampleStringInput = sampleStringTextFieldController.text;

    if (sampleIntInput == "") {
      sampleIntTextFieldErrorMsg = "필수";
      sampleIntTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(sampleIntTextFieldContext)
          .requestFocus(sampleIntTextFieldFocus);
      return;
    }

    if (sampleStringInput == "") {
      sampleStringTextFieldErrorMsg = "필수";
      sampleStringTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(sampleStringTextFieldContext)
          .requestFocus(sampleStringTextFieldFocus);
      return;
    }

    // SPW 값 갱신
    spw_test_sample.SharedPreferenceWrapper.set(
        value: spw_test_sample.SharedPreferenceWrapperVo(
            sampleInt: int.parse(sampleIntInput),
            sampleString: sampleStringInput));
    sampleIntTextFieldController.text = "";
    sampleStringTextFieldController.text = "";

    // SPW 값 가져오기
    sampleInt = int.parse(sampleIntInput);
    sampleString = "\"$sampleStringInput\"";
    sampleIntAreaGk.currentState?.refreshUi();
    sampleStringAreaGk.currentState?.refreshUi();
  }

  // (SP 값 삭제 버튼 클릭)
  void spValueDeleteBtnClick() {
    // SPW 값 갱신
    spw_test_sample.SharedPreferenceWrapper.set(value: null);

    sampleInt = null;
    sampleString = null;
    sampleIntTextFieldErrorMsg = null;
    sampleStringTextFieldErrorMsg = null;
    sampleIntAreaGk.currentState?.refreshUi();
    sampleStringAreaGk.currentState?.refreshUi();
  }

  // [private 함수]
  void _doNothing() {}
}
