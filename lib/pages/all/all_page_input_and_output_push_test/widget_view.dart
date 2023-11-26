// (external)
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'widget_business.dart' as widget_business;

// (all)
import '../../../global_widgets/gw_page_outer_frame/widget_view.dart'
    as gw_page_outer_frame_view;

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
  const InputVo(
      {required this.inputValueString,
      this.inputValueStringOpt,
      required this.inputValueStringList,
      required this.inputValueInt});

  // !!!위젯 입력값 선언!!!
  final String inputValueString;
  final String? inputValueStringOpt;
  final List<String> inputValueStringList;
  final int inputValueInt;
}

// (결과 데이터)
class OutputVo {
  const OutputVo({required this.resultValue});

  // !!!위젯 출력값 선언!!!
  final String resultValue;
}

//------------------------------------------------------------------------------
class WidgetView extends StatefulWidget {
  const WidgetView({super.key, required this.goRouterState});

  final GoRouterState goRouterState;

  @override
  WidgetViewState createState() => WidgetViewState();
}

class WidgetViewState extends State<WidgetView> with WidgetsBindingObserver {
  // [콜백 함수]
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    business = widget_business.WidgetBusiness();
    business.context = context;
    business.refreshUi = refreshUi;
    business.onCheckPageInputVoAsync(goRouterState: widget.goRouterState);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    business.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: business.canPop,
      child: FocusDetector(
        // (페이지 위젯의 FocusDetector 콜백들)
        onFocusGained: () async {
          if (!business.onPageCreated) {
            business.onCreated();
            business.onPageCreated = true;
          }

          business.onFocusGained();
        },
        onFocusLost: () async {
          business.onFocusLost();
        },
        onVisibilityGained: () async {
          business.onVisibilityGained();
        },
        onVisibilityLost: () async {
          business.onVisibilityLost();
        },
        onForegroundGained: () async {
          business.onForegroundGained();
        },
        onForegroundLost: () async {
          business.onForegroundLost();
        },
        child: WidgetUi.viewWidgetBuild(context: context, business: business),
      ),
    );
  }

  // [public 변수]
  late widget_business.WidgetBusiness business;

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
      required widget_business.WidgetBusiness business}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return gw_page_outer_frame_view.WidgetView(
      business: business.pageOutFrameBusiness,
      inputVo: gw_page_outer_frame_view.InputVo(
        pageTitle: "페이지 입/출력 테스트",
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: business.pageOutputFormKey,
                  child: Container(
                    width: 200,
                    margin: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      key: business.pageOutputTextFieldKey,
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: '페이지 출력 값',
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          filled: true,
                          fillColor: Colors.grey[100],
                          isDense: true,
                          hintText: "페이지 출력 값 입력",
                          border: const OutlineInputBorder()),
                      controller: business.pageOutputTextFieldController,
                      focusNode: business.pageOutputTextFieldFocus,
                      validator: (value) {
                        // 검사 : return 으로 반환하는 에러 메세지가 null 이 아니라면 에러로 처리
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        // 입력창 포커스 상태에서 엔터
                        if (business.pageOutputFormKey.currentState!
                            .validate()) {
                          business.onPressedReturnBtn();
                        } else {
                          FocusScope.of(context)
                              .requestFocus(business.pageOutputTextFieldFocus);
                        }
                      },
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
