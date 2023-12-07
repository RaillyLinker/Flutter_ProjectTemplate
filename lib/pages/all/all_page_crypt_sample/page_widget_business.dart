// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'page_widget.dart' as page_widget;
import 'inner_widgets/iw_crypt_result_text/sf_widget_state.dart'
    as iw_crypt_result_text_state;

// (all)
import '../../../global_widgets/gw_page_outer_frame/sl_widget_business.dart'
    as gw_page_outer_frame_business;
import '../../../global_functions/gf_crypto.dart' as gf_crypto;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

// 암호화, 복화화가 잘 이루어지는지 확인하는 샘플입니다.
// 변환 함수에 원하는 암/복호화 알고리즘을 적용하고, 화면의 버튼을 눌러 결과를 확인할 수 있습니다.

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 담당
// PageBusiness 인스턴스는 해당 페이지가 소멸하기 전까지 활용됩니다.
class PageWidgetBusiness {
  // [콜백 함수]
  // (전체 위젯 initState)
  void initState() {
    // !!!initState 로직 작성!!!
  }

  // (전체 위젯 dispose)
  void dispose() {
    // !!!initState 로직 작성!!!
  }

  // (전체 위젯의 FocusDetector 콜백들)
  Future<void> onFocusGained() async {
    // !!!onFocusGained 로직 작성!!!
  }

  Future<void> onFocusLost() async {
    // !!!onFocusLost 로직 작성!!!
  }

  Future<void> onVisibilityGained() async {
    // !!!onFocusLost 로직 작성!!!
  }

  Future<void> onVisibilityLost() async {
    // !!!onVisibilityLost 로직 작성!!!
  }

  Future<void> onForegroundGained() async {
    // !!!onForegroundGained 로직 작성!!!
  }

  Future<void> onForegroundLost() async {
    // !!!onForegroundLost 로직 작성!!!
  }

  void onCheckPageInputVo({required GoRouterState goRouterState}) {
    // !!!pageInputVo 체크!!!
    // ex :
    // if (!goRouterState.uri.queryParameters
    //     .containsKey("inputValueString")) {
    //   // 필수 파라미터가 없는 경우에 대한 처리
    // }

    // !!!PageInputVo 입력!!!
    inputVo = const page_widget.InputVo();
  }

  // [public 변수]
  late BuildContext context;

  // (위젯 입력값)
  late page_widget.InputVo inputVo;

  // (페이지 pop 가능 여부 변수)
  bool canPop = true;

  // (pageOutFrameBusiness)
  final gw_page_outer_frame_business.SlWidgetBusiness pageOutFrameBusiness =
      gw_page_outer_frame_business.SlWidgetBusiness();

  // (input1TextField)
  final TextEditingController input1TextFieldController =
      TextEditingController();
  final FocusNode input1TextFieldFocus = FocusNode();
  String? input1TextFieldErrorMsg;
  gc_template_classes.RefreshableBloc input1TextFieldBloc =
      gc_template_classes.RefreshableBloc();

  // (input2TextField)
  final TextEditingController input2TextFieldController =
      TextEditingController();
  final FocusNode input2TextFieldFocus = FocusNode();
  String? input2TextFieldErrorMsg;
  gc_template_classes.RefreshableBloc input2TextFieldBloc =
      gc_template_classes.RefreshableBloc();

  // (input3TextField)
  final TextEditingController input3TextFieldController =
      TextEditingController();
  final FocusNode input3TextFieldFocus = FocusNode();
  String? input3TextFieldErrorMsg;
  gc_template_classes.RefreshableBloc input3TextFieldBloc =
      gc_template_classes.RefreshableBloc();

  // (input4TextField)
  final TextEditingController input4TextFieldController =
      TextEditingController();
  final FocusNode input4TextFieldFocus = FocusNode();
  String? input4TextFieldErrorMsg;
  gc_template_classes.RefreshableBloc input4TextFieldBloc =
      gc_template_classes.RefreshableBloc();

  final GlobalKey<iw_crypt_result_text_state.SfWidgetState>
      encryptResultTextGk = GlobalKey();

  final GlobalKey<iw_crypt_result_text_state.SfWidgetState>
      decryptResultTextGk = GlobalKey();

  // [private 변수]

  // [public 함수]
  // (Widget 화면 갱신) - WidgetUi.viewWidgetBuild 의 return 값을 다시 불러 옵니다.
  late VoidCallback refreshUi;

  void input1StateEntered() {
    String input1Text = input1TextFieldController.text;
    if (input1Text.isEmpty) {
      input1TextFieldErrorMsg = '암호키를 입력하세요.';
      input1TextFieldBloc.refreshUi();
      return;
    } else if (!RegExp(r'^[a-zA-Z0-9]{32}$').hasMatch(input1Text)) {
      input1TextFieldErrorMsg = '암호키 32자를 입력하세요.';
      input1TextFieldBloc.refreshUi();
      return;
    }
    FocusScope.of(context).requestFocus(input2TextFieldFocus);
  }

  void input2StateEntered() {
    String input2Text = input2TextFieldController.text;
    if (input2Text.isEmpty) {
      input2TextFieldErrorMsg = '초기화 벡터를 입력하세요.';
      input2TextFieldBloc.refreshUi();
      return;
    } else if (!RegExp(r'^[a-zA-Z0-9]{16}$').hasMatch(input2Text)) {
      input2TextFieldErrorMsg = '초기화 벡터 16자를 입력하세요.';
      input2TextFieldBloc.refreshUi();
      return;
    }
    FocusScope.of(context).requestFocus(input3TextFieldFocus);
  }

  void input3StateEntered() {
    String input3Text = input3TextFieldController.text;
    if (input3Text.isEmpty) {
      input3TextFieldErrorMsg = '암호화할 평문을 입력하세요.';
      input3TextFieldBloc.refreshUi();
      return;
    }
    doEncrypt();
  }

  // (암호화 함수)
  void doEncrypt() {
    String input1Text = input1TextFieldController.text;
    if (input1Text.isEmpty) {
      input1TextFieldErrorMsg = '암호키를 입력하세요.';
      input1TextFieldBloc.refreshUi();
      FocusScope.of(context).requestFocus(input1TextFieldFocus);
      return;
    } else if (!RegExp(r'^[a-zA-Z0-9]{32}$').hasMatch(input1Text)) {
      input1TextFieldErrorMsg = '암호키 32자를 입력하세요.';
      input1TextFieldBloc.refreshUi();
      FocusScope.of(context).requestFocus(input1TextFieldFocus);
      return;
    }
    String input2Text = input2TextFieldController.text;
    if (input2Text.isEmpty) {
      input2TextFieldErrorMsg = '초기화 벡터를 입력하세요.';
      input2TextFieldBloc.refreshUi();
      FocusScope.of(context).requestFocus(input2TextFieldFocus);
      return;
    } else if (!RegExp(r'^[a-zA-Z0-9]{16}$').hasMatch(input2Text)) {
      input2TextFieldErrorMsg = '초기화 벡터 16자를 입력하세요.';
      input2TextFieldBloc.refreshUi();
      FocusScope.of(context).requestFocus(input2TextFieldFocus);
      return;
    }
    String input3Text = input3TextFieldController.text;
    if (input3Text.isEmpty) {
      input3TextFieldErrorMsg = '암호화할 평문을 입력하세요.';
      input3TextFieldBloc.refreshUi();
      FocusScope.of(context).requestFocus(input3TextFieldFocus);
      return;
    }

    String secretKey = input1Text;
    String secretIv = input2Text;
    String encryptString = input3Text;

    String aes256EncryptResultText = gf_crypto.aes256Encrypt(
      plainText: encryptString,
      secretKey: secretKey,
      secretIv: secretIv,
    );

    encryptResultTextGk.currentState?.resultText = aes256EncryptResultText;
    encryptResultTextGk.currentState?.refreshUi();
  }

  void input4StateEntered() {
    String input4Text = input4TextFieldController.text;
    if (input4Text.isEmpty) {
      input4TextFieldErrorMsg = '복호화할 암호문을 입력하세요.';
      input4TextFieldBloc.refreshUi();
      return;
    }
    doDecrypt();
  }

  // (복호화 함수)
  void doDecrypt() {
    String input1Text = input1TextFieldController.text;
    if (input1Text.isEmpty) {
      input1TextFieldErrorMsg = '암호키를 입력하세요.';
      input1TextFieldBloc.refreshUi();
      FocusScope.of(context).requestFocus(input1TextFieldFocus);
      return;
    } else if (!RegExp(r'^[a-zA-Z0-9]{32}$').hasMatch(input1Text)) {
      input1TextFieldErrorMsg = '암호키 32자를 입력하세요.';
      input1TextFieldBloc.refreshUi();
      FocusScope.of(context).requestFocus(input1TextFieldFocus);
      return;
    }
    String input2Text = input2TextFieldController.text;
    if (input2Text.isEmpty) {
      input2TextFieldErrorMsg = '초기화 벡터를 입력하세요.';
      input2TextFieldBloc.refreshUi();
      FocusScope.of(context).requestFocus(input1TextFieldFocus);
      return;
    } else if (!RegExp(r'^[a-zA-Z0-9]{16}$').hasMatch(input2Text)) {
      input2TextFieldErrorMsg = '초기화 벡터 16자를 입력하세요.';
      input2TextFieldBloc.refreshUi();
      FocusScope.of(context).requestFocus(input1TextFieldFocus);
      return;
    }
    String input4Text = input4TextFieldController.text;
    if (input4Text.isEmpty) {
      input4TextFieldErrorMsg = '복호화할 암호문을 입력하세요.';
      input4TextFieldBloc.refreshUi();
      FocusScope.of(context).requestFocus(input4TextFieldFocus);
      return;
    }

    String secretKey = input1Text;
    String secretIv = input2Text;
    String decryptString = input4Text;

    try {
      String aes256DecryptResultText = gf_crypto.aes256Decrypt(
        cipherText: decryptString,
        secretKey: secretKey,
        secretIv: secretIv,
      );

      decryptResultTextGk.currentState?.resultText = aes256DecryptResultText;
      decryptResultTextGk.currentState?.refreshUi();
    } catch (e) {
      decryptResultTextGk.currentState?.resultText = "Error";
      decryptResultTextGk.currentState?.refreshUi();
    }
  }

// [private 함수]
}
