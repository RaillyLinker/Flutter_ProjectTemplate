// (external)
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'page_widget_business.dart' as page_widget_business;
import 'inner_widgets/iw_crypt_result_text/sf_widget.dart'
    as iw_crypt_result_text;

// (all)
import '../../../global_widgets/gw_page_outer_frame/sl_widget.dart'
    as gw_page_outer_frame;
import '../../../global_widgets/gw_text_form_field_wrapper/sf_widget.dart'
    as gw_text_form_field_wrapper;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

//------------------------------------------------------------------------------
// !!!페이지 진입 라우트 Name 정의!!!
// 폴더명과 동일하게 작성하세요.
const pageName = "all_page_crypt_sample";

// !!!페이지 호출/반납 애니메이션!!!
// 동적으로 변경이 가능합니다.
Widget Function(BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child)
    pageTransitionsBuilder = (context, animation, secondaryAnimation, child) {
  return FadeTransition(opacity: animation, child: child);
};

// (입력 데이터)
class InputVo {
  // !!!위젯 입력값 선언!!!
  const InputVo();
}

// (결과 데이터)
class OutputVo {
  // !!!위젯 출력값 선언!!!
  const OutputVo();
}

//------------------------------------------------------------------------------
class PageWidget extends StatefulWidget {
  const PageWidget({super.key, required this.goRouterState});

  final GoRouterState goRouterState;

  @override
  PageWidgetState createState() => PageWidgetState();
}

class PageWidgetState extends State<PageWidget> with WidgetsBindingObserver {
  // [콜백 함수]
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    business = page_widget_business.PageWidgetBusiness();
    business.onCheckPageInputVo(goRouterState: widget.goRouterState);
    business.refreshUi = refreshUi;
    business.context = context;
    business.initState();
  }

  @override
  void dispose() {
    business.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    business.refreshUi = refreshUi;
    business.context = context;
    return PopScope(
      canPop: business.canPop,
      child: FocusDetector(
        // (페이지 위젯의 FocusDetector 콜백들)
        onFocusGained: () async {
          await business.onFocusGained();
        },
        onFocusLost: () async {
          await business.onFocusLost();
        },
        onVisibilityGained: () async {
          await business.onVisibilityGained();
        },
        onVisibilityLost: () async {
          await business.onVisibilityLost();
        },
        onForegroundGained: () async {
          await business.onForegroundGained();
        },
        onForegroundLost: () async {
          await business.onForegroundLost();
        },
        child: WidgetUi.viewWidgetBuild(context: context, business: business),
      ),
    );
  }

  // [public 변수]
  late page_widget_business.PageWidgetBusiness business;

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }
}

class WidgetUi {
  // [뷰 위젯]
  static Widget viewWidgetBuild(
      {required BuildContext context,
      required page_widget_business.PageWidgetBusiness business}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return gw_page_outer_frame.SlWidget(
      business: business.pageOutFrameBusiness,
      inputVo: gw_page_outer_frame.InputVo(
        pageTitle: "암/복호화 샘플",
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: const BorderSide(
                                  color: Colors.blue, width: 1.0), // 테두리 스타일 조정
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Form(
                                child: Column(
                                  children: [
                                    const Text('AES256 알고리즘',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "MaruBuri")),
                                    const SizedBox(height: 16.0),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                            flex: 20,
                                            child: gw_text_form_field_wrapper
                                                .SfWidget(
                                              globalKey: business.input1StateGk,
                                              inputVo:
                                                  gw_text_form_field_wrapper
                                                      .InputVo(
                                                autofocus: true,
                                                maxLength: 32,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(
                                                          r'[a-zA-Z0-9]')),
                                                ],
                                                labelText: '암호키',
                                                hintText: "암호화 키 32자 입력",
                                                keyboardType:
                                                    TextInputType.text,
                                                floatingLabelStyle:
                                                    const TextStyle(
                                                        color: Colors.blue),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 10.0),
                                                focusedBorder:
                                                    const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blue),
                                                ),
                                                inputValidator: (value) {
                                                  return business
                                                      .input1StateValidator(
                                                          value);
                                                },
                                                onEditingComplete: () {
                                                  business.input1StateEntered();
                                                },
                                              ),
                                            )),
                                        const Expanded(child: SizedBox()),
                                        Expanded(
                                            flex: 20,
                                            child: gw_text_form_field_wrapper
                                                .SfWidget(
                                              globalKey: business.input2StateGk,
                                              inputVo:
                                                  gw_text_form_field_wrapper
                                                      .InputVo(
                                                maxLength: 16,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(
                                                          r'[a-zA-Z0-9]')),
                                                ],
                                                labelText: '초기화 벡터',
                                                hintText: "암호 초기화 벡터 16자 입력",
                                                keyboardType:
                                                    TextInputType.text,
                                                floatingLabelStyle:
                                                    const TextStyle(
                                                        color: Colors.blue),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 10.0),
                                                focusedBorder:
                                                    const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blue),
                                                ),
                                                inputValidator: (value) {
                                                  return business
                                                      .input2StateValidator(
                                                          value);
                                                },
                                                onEditingComplete: () {
                                                  business.input2StateEntered();
                                                },
                                              ),
                                            )),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                            flex: 20,
                                            child: gw_text_form_field_wrapper
                                                .SfWidget(
                                              globalKey: business.input3StateGk,
                                              inputVo:
                                                  gw_text_form_field_wrapper
                                                      .InputVo(
                                                labelText: '암호화할 평문',
                                                hintText: "암호화할 평문을 입력하세요.",
                                                keyboardType:
                                                    TextInputType.text,
                                                floatingLabelStyle:
                                                    const TextStyle(
                                                        color: Colors.blue),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 10.0),
                                                focusedBorder:
                                                    const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blue),
                                                ),
                                                inputValidator: (value) {
                                                  return business
                                                      .input3StateValidator(
                                                          value);
                                                },
                                                onEditingComplete: () {
                                                  business.input3StateEntered();
                                                },
                                              ),
                                            )),
                                        const Expanded(child: SizedBox()),
                                        Expanded(
                                            flex: 10,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                business.doEncrypt();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "암호화",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "MaruBuri"),
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Expanded(
                                            flex: 20,
                                            child: Text(
                                              "결과 :",
                                              style: TextStyle(
                                                  fontFamily: "MaruBuri"),
                                            )),
                                        const Expanded(child: SizedBox()),
                                        Expanded(
                                          flex: 80,
                                          child: iw_crypt_result_text.SfWidget(
                                            globalKey:
                                                business.encryptResultTextGk,
                                            inputVo: const iw_crypt_result_text
                                                .InputVo(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                            flex: 20,
                                            child: gw_text_form_field_wrapper
                                                .SfWidget(
                                              globalKey: business.input4StateGk,
                                              inputVo:
                                                  gw_text_form_field_wrapper
                                                      .InputVo(
                                                labelText: '복호화할 암호문',
                                                hintText: "복호화할 암호문을 입력하세요.",
                                                keyboardType:
                                                    TextInputType.text,
                                                floatingLabelStyle:
                                                    const TextStyle(
                                                        color: Colors.blue),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 10.0),
                                                focusedBorder:
                                                    const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blue),
                                                ),
                                                inputValidator: (value) {
                                                  return business
                                                      .input4StateValidator(
                                                          value);
                                                },
                                                onEditingComplete: () {
                                                  business.input4StateEntered();
                                                },
                                              ),
                                            )),
                                        const Expanded(child: SizedBox()),
                                        Expanded(
                                            flex: 10,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                business.doDecrypt();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "복호화",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "MaruBuri"),
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Expanded(
                                            flex: 20,
                                            child: Text(
                                              "결과 :",
                                              style: TextStyle(
                                                  fontFamily: "MaruBuri"),
                                            )),
                                        const Expanded(child: SizedBox()),
                                        Expanded(
                                          flex: 80,
                                          child: iw_crypt_result_text.SfWidget(
                                            globalKey:
                                                business.decryptResultTextGk,
                                            inputVo: const iw_crypt_result_text
                                                .InputVo(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}