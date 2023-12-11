// (inner_folder)
import 'main_widget.dart' as main_widget;

// (all)
import '../../../../global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;

// [위젯 비즈니스]

//------------------------------------------------------------------------------
class MainBusiness {
  // [CallBack 함수]
  void initState() {
    // !!!initState 로직 작성!!!
  }

  void dispose() {
    // !!!dispose 로직 작성!!!
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

  main_widget.InputVo? onCheckPageInputVo() {
    // !!!pageInputVo 체크!!! - 필수 정보 누락시 null 반환
    // ex :
    // if (!widget.goRouterState.uri.queryParameters
    //     .containsKey("inputValueString")) {
    //   return null;
    // }

    // !!!PageInputVo 입력!!!
    return const main_widget.InputVo();
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

  // (pageOutFrameBusiness)
  final gw_slw_page_outer_frame.SlwPageOuterFrameBusiness pageOutFrameBusiness =
      gw_slw_page_outer_frame.SlwPageOuterFrameBusiness();

  // [private 변수]

  //----------------------------------------------------------------------------
  // !!!메인 위젯에서 사용할 비즈니스 함수는 이 곳에서 저장 하여 사용 하세요.!!!
  // [public 함수]
  // (메인 위젯 화면 갱신)
  void refreshUi({required main_widget.MainWidgetState mainWidgetState}) {
    mainWidgetState.refreshUi();
  }

  // [private 함수]
  void _doNothing({required main_widget.MainWidgetState mainWidgetState}) {}
}
