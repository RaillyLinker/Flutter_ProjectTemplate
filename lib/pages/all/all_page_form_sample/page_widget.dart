// (external)
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'page_widget_business.dart' as page_widget_business;

// (all)
import '../../../global_widgets/gw_page_outer_frame/sl_widget.dart'
    as gw_page_outer_frame;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

//------------------------------------------------------------------------------
// !!!페이지 진입 라우트 Name 정의!!!
// 폴더명과 동일하게 작성하세요.
const pageName = "all_page_form_sample";

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
        pageTitle: "폼 입력 샘플",
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: 450,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.black),
                  bottom: BorderSide(width: 1.0, color: Colors.black),
                  left: BorderSide(width: 1.0, color: Colors.black),
                  right: BorderSide(width: 1.0, color: Colors.black),
                ),
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('테스트 폼',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: "MaruBuri")),
                    const SizedBox(height: 30.0),
                    BlocProvider(
                      create: (context) => business.input1TextFieldBloc,
                      child: BlocBuilder<gc_template_classes.RefreshableBloc,
                          bool>(
                        builder: (c, s) {
                          return TextFormField(
                            autofocus: true,
                            keyboardType: TextInputType.text,
                            controller: business.input1TextFieldController,
                            focusNode: business.input1TextFieldFocus,
                            decoration: InputDecoration(
                              labelText: '무제한 입력',
                              floatingLabelStyle:
                                  const TextStyle(color: Colors.blue),
                              hintText: "아무 값이나 입력 하세요.",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              filled: true,
                              fillColor: Colors.grey[100],
                              errorText: business.input1TextFieldErrorMsg,
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  business.input1TextFieldController.text = "";
                                },
                                icon: const Icon(Icons.clear),
                              ),
                            ),
                            onChanged: (value) {
                              // 입력값 변경시 에러 메세지 삭제
                              if (business.input1TextFieldErrorMsg != null) {
                                business.input1TextFieldErrorMsg = null;
                                business.input1TextFieldBloc.refreshUi();
                              }
                            },
                            onEditingComplete: () {
                              business.input1StateEntered();
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    BlocProvider(
                      create: (context) => business.input2TextFieldBloc,
                      child: BlocBuilder<gc_template_classes.RefreshableBloc,
                          bool>(
                        builder: (c, s) {
                          return TextFormField(
                            keyboardType: TextInputType.text,
                            controller: business.input2TextFieldController,
                            focusNode: business.input2TextFieldFocus,
                            maxLength: 16,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z0-9]')),
                            ],
                            decoration: InputDecoration(
                              labelText: '영문 / 숫자 16자 입력',
                              floatingLabelStyle:
                                  const TextStyle(color: Colors.blue),
                              hintText: "영문 / 숫자를 16자 입력 하세요.",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              filled: true,
                              fillColor: Colors.grey[100],
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  business.input2TextFieldController.text = "";
                                },
                                icon: const Icon(Icons.clear),
                              ),
                              errorText: business.input2TextFieldErrorMsg,
                            ),
                            onChanged: (value) {
                              // 입력값 변경시 에러 메세지 삭제
                              if (business.input2TextFieldErrorMsg != null) {
                                business.input2TextFieldErrorMsg = null;
                                business.input2TextFieldBloc.refreshUi();
                              }
                            },
                            onEditingComplete: () {
                              business.input2StateEntered();
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    BlocProvider(
                      create: (context) => business.input3TextFieldBloc,
                      child: BlocBuilder<gc_template_classes.RefreshableBloc,
                          bool>(
                        builder: (c, s) {
                          return TextFormField(
                            keyboardType: TextInputType.number,
                            controller: business.input3TextFieldController,
                            focusNode: business.input3TextFieldFocus,
                            maxLength: 16,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            decoration: InputDecoration(
                              labelText: '숫자 16자 이내 입력',
                              floatingLabelStyle:
                                  const TextStyle(color: Colors.blue),
                              hintText: "숫자를 16자 이내에 입력 하세요.",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              filled: true,
                              fillColor: Colors.grey[100],
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  business.input3TextFieldController.text = "";
                                },
                                icon: const Icon(Icons.clear),
                              ),
                              errorText: business.input3TextFieldErrorMsg,
                            ),
                            onChanged: (value) {
                              // 입력값 변경시 에러 메세지 삭제
                              if (business.input3TextFieldErrorMsg != null) {
                                business.input3TextFieldErrorMsg = null;
                                business.input3TextFieldBloc.refreshUi();
                              }
                            },
                            onEditingComplete: () {
                              business.input3StateEntered();
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    BlocProvider(
                      create: (context) => business.input4TextFieldBloc,
                      child: BlocBuilder<gc_template_classes.RefreshableBloc,
                          bool>(
                        builder: (c, s) {
                          return TextFormField(
                            keyboardType: TextInputType.text,
                            controller: business.input4TextFieldController,
                            focusNode: business.input4TextFieldFocus,
                            maxLength: 16,
                            obscureText: business.input4TextFieldHide,
                            autofillHints: const [AutofillHints.password],
                            decoration: InputDecoration(
                              labelText: "암호값 입력",
                              floatingLabelStyle:
                                  const TextStyle(color: Colors.blue),
                              hintText: '암호값을 입력하면 숨김 처리가 됩니다.',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              filled: true,
                              fillColor: Colors.grey[100],
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              prefixIcon: const Icon(
                                Icons.key,
                                color: Colors.grey,
                                size: 24.0, // 아이콘 크기 조정
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  business.input4TextFieldHide
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  business.input4TextFieldHide =
                                      !business.input4TextFieldHide;
                                  business.input4TextFieldBloc.refreshUi();
                                },
                              ),
                              errorText: business.input4TextFieldErrorMsg,
                            ),
                            onChanged: (value) {
                              // 입력값 변경시 에러 메세지 삭제
                              if (business.input4TextFieldErrorMsg != null) {
                                business.input4TextFieldErrorMsg = null;
                                business.input4TextFieldBloc.refreshUi();
                              }
                            },
                            onEditingComplete: () {
                              business.input4StateEntered();
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 50.0),
                    ElevatedButton(
                      onPressed: () {
                        business.completeTestForm();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "폼 완료",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "MaruBuri",
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
