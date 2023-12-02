// (external)
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'page_widget_business.dart' as page_widget_business;

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
const pageName = "all_page_input_and_output_push_test";

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
  const InputVo(
      {required this.inputValueString,
      this.inputValueStringOpt,
      required this.inputValueStringList,
      required this.inputValueInt});

  final String inputValueString;
  final String? inputValueStringOpt;
  final List<String> inputValueStringList;
  final int inputValueInt;
}

// (결과 데이터)
class OutputVo {
  // !!!위젯 출력값 선언!!!
  const OutputVo({required this.resultValue});

  final String resultValue;
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
        pageTitle: "페이지 입/출력 테스트",
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  child: Container(
                    width: 200,
                    margin: const EdgeInsets.only(top: 20),
                    child: gw_text_form_field_wrapper.SfWidget(
                      globalKey: business.gwTextFormFieldWrapperStateGk,
                      inputVo: gw_text_form_field_wrapper.InputVo(
                          autofocus: true,
                          keyboardType: TextInputType.text,
                          labelText: '페이지 출력 값',
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          filled: true,
                          fillColor: Colors.grey[100],
                          isDense: true,
                          hintText: "페이지 출력 값 입력",
                          border: const OutlineInputBorder(),
                          floatingLabelStyle:
                              const TextStyle(color: Colors.blue),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          onEditingComplete: () {
                            business.onPressedReturnBtn();
                          },
                          suffixIcon: IconButton(
                            onPressed: () {
                              business
                                  .gwTextFormFieldWrapperStateGk.currentState
                                  ?.setInputValue("");
                            },
                            icon: const Icon(Icons.clear),
                          )),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      business.onPressedReturnBtn();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(top: 8, bottom: 8),
                      child: const Text(
                        "출력 값 반환",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontFamily: "MaruBuri"),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
