// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:io' as dart_io;

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
    portTextFieldController.dispose();
    portTextFieldFocus.dispose();
    server?.close();
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

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> portTextFieldAreaGk =
      GlobalKey();
  late BuildContext portTextFieldContext;
  final TextEditingController portTextFieldController = TextEditingController();
  final FocusNode portTextFieldFocus = FocusNode();
  String? portTextFieldErrorMsg;

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> logListAreaGk =
      GlobalKey();
  late BuildContext logListAreaContext;
  List<String> logList = [];

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> serverBtnAreaGk =
      GlobalKey();
  late BuildContext serverBtnAreaContext;
  String serverBtn = "서버 열기";

  dart_io.HttpServer? server;

  // [private 변수]

  //----------------------------------------------------------------------------
  // !!!비즈니스 함수는 이 곳에서 저장 하여 사용 하세요.!!!
  // [public 함수]
  // (메인 위젯 화면 갱신)
  late VoidCallback refreshUi;

  bool onServerBtnClicked = false;

  Future<void> onClickOpenServerBtnAsync() async {
    if (onServerBtnClicked) {
      return;
    }
    onServerBtnClicked = true;

    int port = 9090;
    if (portTextFieldController.text.trim().isNotEmpty) {
      port = int.parse(portTextFieldController.text);
    }

    try {
      server = await dart_io.HttpServer.bind(
          dart_io.InternetAddress.loopbackIPv4, port);
    } catch (bindError) {
      // bind 실패
      onServerBtnClicked = false;
      logList.insert(0, "++++ $bindError");
      logListAreaGk.currentState?.refreshUi();
      return;
    }

    logList.insert(0, "++++ 서버를 열었습니다.");
    logListAreaGk.currentState?.refreshUi();

    server!.listen((request) async {
      logList.insert(0, "++++ ${request.headers}");
      logListAreaGk.currentState?.refreshUi();

      // send response
      request.response.statusCode = 200;
      request.response.headers.set('content-type', 'text/plain');
      request.response.writeln('');
      await request.response.close();
    });

    serverBtn = "서버 닫기";
    serverBtnAreaGk.currentState?.refreshUi();

    onServerBtnClicked = false;
  }

  Future<void> onClickCloseServerBtnAsync() async {
    if (onServerBtnClicked) {
      return;
    }
    onServerBtnClicked = true;

    await server?.close();
    logList.insert(0, "++++ 서버를 닫았습니다.");
    logListAreaGk.currentState?.refreshUi();

    serverBtn = "서버 열기";
    serverBtnAreaGk.currentState?.refreshUi();

    onServerBtnClicked = false;
  }

  // [private 함수]
  void _doNothing() {}
}
