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
// todo : 리스트 관련 지웠다가 생겼다가 했을 때 에러 표시시 에러 발생 원인 찾아보기

//------------------------------------------------------------------------------
// !!!페이지 진입 라우트 Name 정의!!!
// 폴더명과 동일하게 작성하세요.
const pageName = "all_page_get_request_sample";

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
        pageTitle: "Get 메소드 요청 샘플",
        child: SingleChildScrollView(
          child: Container(
            margin:
                const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.black),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                        child: Text(
                          "변수명",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "MaruBuri"),
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Text(
                            "설명 및 입력",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "MaruBuri"),
                          ))
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "queryParamString",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "MaruBuri"),
                            ),
                            Container(
                              constraints: const BoxConstraints(maxWidth: 250),
                              child: const Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    "(Query ",
                                    style: TextStyle(fontFamily: "MaruBuri"),
                                  )),
                                  Expanded(
                                      child: Text("String",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontFamily: "MaruBuri"))),
                                  Expanded(
                                      child: Text(
                                    ")",
                                    style: TextStyle(fontFamily: "MaruBuri"),
                                  ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "String Query 파라미터",
                              style: TextStyle(fontFamily: "MaruBuri"),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: BlocProvider(
                                create: (context) =>
                                    business.input1TextFieldBloc,
                                child: BlocBuilder<
                                    gc_template_classes.RefreshableBloc, bool>(
                                  builder: (c, s) {
                                    return TextFormField(
                                      autofocus: true,
                                      controller:
                                          business.input1TextFieldController,
                                      focusNode: business.input1TextFieldFocus,
                                      decoration: InputDecoration(
                                        errorText:
                                            business.input1TextFieldErrorMsg,
                                        floatingLabelStyle:
                                            const TextStyle(color: Colors.blue),
                                        border: const OutlineInputBorder(),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 10.0),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            business.input1TextFieldController
                                                .text = "";
                                          },
                                          icon: const Icon(Icons.clear),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        // 입력값 변경시 에러 메세지 삭제
                                        if (business.input1TextFieldErrorMsg !=
                                            null) {
                                          business.input1TextFieldErrorMsg =
                                              null;
                                          business.input1TextFieldBloc
                                              .refreshUi();
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "queryParamStringNullable",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "MaruBuri"),
                            ),
                            Container(
                              constraints: const BoxConstraints(maxWidth: 250),
                              child: const Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    "(Query ",
                                    style: TextStyle(fontFamily: "MaruBuri"),
                                  )),
                                  Expanded(
                                      child: Text("String?",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "MaruBuri"))),
                                  Expanded(
                                      child: Text(
                                    ")",
                                    style: TextStyle(fontFamily: "MaruBuri"),
                                  ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "String Query 파라미터 Nullable",
                              style: TextStyle(fontFamily: "MaruBuri"),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: BlocProvider(
                                create: (context) =>
                                    business.input2TextFieldBloc,
                                child: BlocBuilder<
                                    gc_template_classes.RefreshableBloc, bool>(
                                  builder: (c, s) {
                                    return TextFormField(
                                      controller:
                                          business.input2TextFieldController,
                                      focusNode: business.input2TextFieldFocus,
                                      decoration: InputDecoration(
                                        errorText:
                                            business.input2TextFieldErrorMsg,
                                        floatingLabelStyle:
                                            const TextStyle(color: Colors.blue),
                                        border: const OutlineInputBorder(),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 10.0),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            business.input2TextFieldController
                                                .text = "";
                                          },
                                          icon: const Icon(Icons.clear),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        // 입력값 변경시 에러 메세지 삭제
                                        if (business.input2TextFieldErrorMsg !=
                                            null) {
                                          business.input2TextFieldErrorMsg =
                                              null;
                                          business.input2TextFieldBloc
                                              .refreshUi();
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "queryParamInt",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "MaruBuri"),
                            ),
                            Container(
                              constraints: const BoxConstraints(maxWidth: 250),
                              child: const Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    "(Query ",
                                    style: TextStyle(fontFamily: "MaruBuri"),
                                  )),
                                  Expanded(
                                      child: Text("Int",
                                          style: TextStyle(color: Colors.red))),
                                  Expanded(
                                      child: Text(
                                    ")",
                                    style: TextStyle(fontFamily: "MaruBuri"),
                                  ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Int Query 파라미터",
                              style: TextStyle(fontFamily: "MaruBuri"),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: BlocProvider(
                                create: (context) =>
                                    business.input3TextFieldBloc,
                                child: BlocBuilder<
                                    gc_template_classes.RefreshableBloc, bool>(
                                  builder: (c, s) {
                                    return TextFormField(
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: false, signed: true),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r'^-?[0-9]*$'),
                                        ),
                                      ],
                                      controller:
                                          business.input3TextFieldController,
                                      focusNode: business.input3TextFieldFocus,
                                      decoration: InputDecoration(
                                        errorText:
                                            business.input3TextFieldErrorMsg,
                                        floatingLabelStyle:
                                            const TextStyle(color: Colors.blue),
                                        border: const OutlineInputBorder(),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 10.0),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            business.input3TextFieldController
                                                .text = "";
                                          },
                                          icon: const Icon(Icons.clear),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        // 입력값 변경시 에러 메세지 삭제
                                        if (business.input3TextFieldErrorMsg !=
                                            null) {
                                          business.input3TextFieldErrorMsg =
                                              null;
                                          business.input3TextFieldBloc
                                              .refreshUi();
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "queryParamIntNullable",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "MaruBuri"),
                            ),
                            Container(
                              constraints: const BoxConstraints(maxWidth: 250),
                              child: const Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    "(Query ",
                                    style: TextStyle(fontFamily: "MaruBuri"),
                                  )),
                                  Expanded(
                                      child: Text("Int?",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "MaruBuri"))),
                                  Expanded(
                                      child: Text(
                                    ")",
                                    style: TextStyle(fontFamily: "MaruBuri"),
                                  ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Int Query 파라미터 Nullable",
                              style: TextStyle(fontFamily: "MaruBuri"),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: BlocProvider(
                                create: (context) =>
                                    business.input3TextFieldBloc,
                                child: BlocBuilder<
                                    gc_template_classes.RefreshableBloc, bool>(
                                  builder: (c, s) {
                                    return TextFormField(
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: false, signed: true),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r'^-?[0-9]*$'),
                                        ),
                                      ],
                                      controller:
                                          business.input4TextFieldController,
                                      focusNode: business.input4TextFieldFocus,
                                      decoration: InputDecoration(
                                        errorText:
                                            business.input4TextFieldErrorMsg,
                                        floatingLabelStyle:
                                            const TextStyle(color: Colors.blue),
                                        border: const OutlineInputBorder(),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 10.0),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            business.input4TextFieldController
                                                .text = "";
                                          },
                                          icon: const Icon(Icons.clear),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        // 입력값 변경시 에러 메세지 삭제
                                        if (business.input4TextFieldErrorMsg !=
                                            null) {
                                          business.input4TextFieldErrorMsg =
                                              null;
                                          business.input4TextFieldBloc
                                              .refreshUi();
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "queryParamDouble",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "MaruBuri"),
                            ),
                            Container(
                              constraints: const BoxConstraints(maxWidth: 250),
                              child: const Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    "(Query ",
                                    style: TextStyle(fontFamily: "MaruBuri"),
                                  )),
                                  Expanded(
                                      child: Text("Double",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontFamily: "MaruBuri"))),
                                  Expanded(
                                      child: Text(
                                    ")",
                                    style: TextStyle(fontFamily: "MaruBuri"),
                                  ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Double Query 파라미터",
                              style: TextStyle(fontFamily: "MaruBuri"),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: BlocProvider(
                                create: (context) =>
                                    business.input5TextFieldBloc,
                                child: BlocBuilder<
                                    gc_template_classes.RefreshableBloc, bool>(
                                  builder: (c, s) {
                                    return TextFormField(
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true, signed: true),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r'^-?[0-9]*\.?[0-9]*$'),
                                        ),
                                      ],
                                      controller:
                                          business.input5TextFieldController,
                                      focusNode: business.input5TextFieldFocus,
                                      decoration: InputDecoration(
                                        errorText:
                                            business.input5TextFieldErrorMsg,
                                        floatingLabelStyle:
                                            const TextStyle(color: Colors.blue),
                                        border: const OutlineInputBorder(),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 10.0),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            business.input5TextFieldController
                                                .text = "";
                                          },
                                          icon: const Icon(Icons.clear),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        // 입력값 변경시 에러 메세지 삭제
                                        if (business.input5TextFieldErrorMsg !=
                                            null) {
                                          business.input5TextFieldErrorMsg =
                                              null;
                                          business.input5TextFieldBloc
                                              .refreshUi();
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "queryParamDoubleNullable",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "MaruBuri"),
                            ),
                            Container(
                              constraints: const BoxConstraints(maxWidth: 250),
                              child: const Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    "(Query ",
                                    style: TextStyle(fontFamily: "MaruBuri"),
                                  )),
                                  Expanded(
                                      child: Text("Double?",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "MaruBuri"))),
                                  Expanded(
                                      child: Text(
                                    ")",
                                    style: TextStyle(fontFamily: "MaruBuri"),
                                  ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Double Query 파라미터 Nullable",
                              style: TextStyle(fontFamily: "MaruBuri"),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: BlocProvider(
                                create: (context) =>
                                    business.input6TextFieldBloc,
                                child: BlocBuilder<
                                    gc_template_classes.RefreshableBloc, bool>(
                                  builder: (c, s) {
                                    return TextFormField(
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true, signed: true),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r'^-?[0-9]*\.?[0-9]*$'),
                                        ),
                                      ],
                                      controller:
                                          business.input6TextFieldController,
                                      focusNode: business.input6TextFieldFocus,
                                      decoration: InputDecoration(
                                        errorText:
                                            business.input6TextFieldErrorMsg,
                                        floatingLabelStyle:
                                            const TextStyle(color: Colors.blue),
                                        border: const OutlineInputBorder(),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 10.0),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            business.input6TextFieldController
                                                .text = "";
                                          },
                                          icon: const Icon(Icons.clear),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        // 입력값 변경시 에러 메세지 삭제
                                        if (business.input6TextFieldErrorMsg !=
                                            null) {
                                          business.input6TextFieldErrorMsg =
                                              null;
                                          business.input6TextFieldBloc
                                              .refreshUi();
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "queryParamBoolean",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "MaruBuri"),
                            ),
                            Container(
                              constraints: const BoxConstraints(maxWidth: 250),
                              child: const Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    "(Query ",
                                    style: TextStyle(fontFamily: "MaruBuri"),
                                  )),
                                  Expanded(
                                      child: Text("Boolean",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontFamily: "MaruBuri"))),
                                  Expanded(
                                      child: Text(
                                    ")",
                                    style: TextStyle(fontFamily: "MaruBuri"),
                                  ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Boolean Query 파라미터",
                              style: TextStyle(fontFamily: "MaruBuri"),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: BlocProvider(
                                create: (context) =>
                                    business.input7TextFieldBloc,
                                child: BlocBuilder<
                                    gc_template_classes.RefreshableBloc, bool>(
                                  builder: (c, s) {
                                    return DropdownButton<bool>(
                                      value: business.input7Value,
                                      items: <bool>[true, false]
                                          .map<DropdownMenuItem<bool>>(
                                              (bool value) {
                                        return DropdownMenuItem<bool>(
                                          value: value,
                                          child: Text(
                                            "$value",
                                            style: const TextStyle(
                                                fontFamily: "MaruBuri"),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (bool? newValue) {
                                        business.input7Value = newValue!;
                                        business.input7TextFieldBloc
                                            .refreshUi();
                                      },
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "queryParamBooleanNullable",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "MaruBuri"),
                            ),
                            Container(
                              constraints: const BoxConstraints(maxWidth: 250),
                              child: const Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    "(Query ",
                                    style: TextStyle(fontFamily: "MaruBuri"),
                                  )),
                                  Expanded(
                                      child: Text("Boolean?",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "MaruBuri"))),
                                  Expanded(
                                      child: Text(
                                    ")",
                                    style: TextStyle(fontFamily: "MaruBuri"),
                                  ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Boolean Query 파라미터 Nullable",
                              style: TextStyle(fontFamily: "MaruBuri"),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: BlocProvider(
                                create: (context) =>
                                    business.input8TextFieldBloc,
                                child: BlocBuilder<
                                    gc_template_classes.RefreshableBloc, bool>(
                                  builder: (c, s) {
                                    return DropdownButton<bool?>(
                                      value: business.input8Value,
                                      items: <bool?>[true, false, null]
                                          .map<DropdownMenuItem<bool?>>(
                                              (bool? value) {
                                        return DropdownMenuItem<bool?>(
                                          value: value,
                                          child: Text(
                                            "$value",
                                            style: const TextStyle(
                                                fontFamily: "MaruBuri"),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (bool? newValue) {
                                        business.input8Value = newValue;
                                        business.input8TextFieldBloc
                                            .refreshUi();
                                      },
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "queryParamStringList",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "MaruBuri"),
                            ),
                            Container(
                              constraints: const BoxConstraints(maxWidth: 250),
                              child: const Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    "(Query ",
                                    style: TextStyle(fontFamily: "MaruBuri"),
                                  )),
                                  Expanded(
                                      child: Text("array[string]",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontFamily: "MaruBuri"))),
                                  Expanded(
                                      child: Text(
                                    ")",
                                    style: TextStyle(fontFamily: "MaruBuri"),
                                  ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "StringList Query 파라미터",
                              style: TextStyle(fontFamily: "MaruBuri"),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BlocProvider(
                                    create: (context) =>
                                        business.input9ListBloc,
                                    child: BlocBuilder<
                                        gc_template_classes.RefreshableBloc,
                                        bool>(
                                      builder: (c, s) {
                                        List<Widget> widgetList = [];
                                        for (int idx = 0;
                                            idx < business.input9List.length;
                                            idx++) {
                                          page_widget_business
                                              .Input9ListItemViewModel tec =
                                              business.input9List[idx];

                                          List<Widget> textFieldRow = [
                                            Expanded(
                                              child: BlocProvider(
                                                create: (context) =>
                                                    tec.inputTextFieldBloc,
                                                child: BlocBuilder<
                                                    gc_template_classes
                                                    .RefreshableBloc,
                                                    bool>(
                                                  builder: (c, s) {
                                                    return TextFormField(
                                                      controller: tec
                                                          .inputTextFieldController,
                                                      focusNode: tec
                                                          .inputTextFieldFocus,
                                                      decoration:
                                                          InputDecoration(
                                                        errorText: tec
                                                            .inputTextFieldErrorMsg,
                                                        floatingLabelStyle:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .blue),
                                                        border:
                                                            const OutlineInputBorder(),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 10.0,
                                                                horizontal:
                                                                    10.0),
                                                        focusedBorder:
                                                            const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .blue),
                                                        ),
                                                        suffixIcon: IconButton(
                                                          onPressed: () {
                                                            tec.inputTextFieldController
                                                                .text = "";
                                                          },
                                                          icon: const Icon(
                                                              Icons.clear),
                                                        ),
                                                      ),
                                                      onChanged: (value) {
                                                        // 입력값 변경시 에러 메세지 삭제
                                                        if (tec.inputTextFieldErrorMsg !=
                                                            null) {
                                                          tec.inputTextFieldErrorMsg =
                                                              null;
                                                          tec.inputTextFieldBloc
                                                              .refreshUi();
                                                        }
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ];

                                          if (business.input9List.length > 1) {
                                            textFieldRow.add(Container(
                                              margin: const EdgeInsets.only(
                                                  left: 5),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    business
                                                        .deleteInput9ListItem(
                                                            idx);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.blue,
                                                  ),
                                                  child: const Text(
                                                    "-",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "MaruBuri"),
                                                  )),
                                            ));
                                          }

                                          widgetList.add(Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            child: Row(
                                              children: textFieldRow,
                                            ),
                                          ));
                                        }

                                        Column stringListColumn = Column(
                                          children: widgetList,
                                        );

                                        return stringListColumn;
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          business
                                              .addInput9ListItem();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                        ),
                                        child: const Text(
                                          "리스트 추가",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "MaruBuri"),
                                        )),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "queryParamStringListNullable",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "MaruBuri"),
                            ),
                            Container(
                              constraints: const BoxConstraints(maxWidth: 250),
                              child: const Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    "(Query ",
                                    style: TextStyle(fontFamily: "MaruBuri"),
                                  )),
                                  Expanded(
                                      child: Text("array[string]?",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "MaruBuri"))),
                                  Expanded(
                                      child: Text(
                                    ")",
                                    style: TextStyle(fontFamily: "MaruBuri"),
                                  ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "StringList Query 파라미터 Nullable",
                              style: TextStyle(fontFamily: "MaruBuri"),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BlocProvider(
                                    create: (context) =>
                                        business.input10ListBloc,
                                    child: BlocBuilder<
                                        gc_template_classes.RefreshableBloc,
                                        bool>(
                                      builder: (c, s) {
                                        List<Widget> widgetList = [];
                                        for (int idx = 0;
                                            idx < business.input10List.length;
                                            idx++) {
                                          page_widget_business
                                              .Input10ListItemViewModel tec =
                                              business.input10List[idx];

                                          List<Widget> textFieldRow = [
                                            Expanded(
                                              child: BlocProvider(
                                                create: (context) =>
                                                    tec.inputTextFieldBloc,
                                                child: BlocBuilder<
                                                    gc_template_classes
                                                    .RefreshableBloc,
                                                    bool>(
                                                  builder: (c, s) {
                                                    return TextFormField(
                                                      controller: tec
                                                          .inputTextFieldController,
                                                      focusNode: tec
                                                          .inputTextFieldFocus,
                                                      decoration:
                                                          InputDecoration(
                                                        errorText: tec
                                                            .inputTextFieldErrorMsg,
                                                        floatingLabelStyle:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .blue),
                                                        border:
                                                            const OutlineInputBorder(),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 10.0,
                                                                horizontal:
                                                                    10.0),
                                                        focusedBorder:
                                                            const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .blue),
                                                        ),
                                                        suffixIcon: IconButton(
                                                          onPressed: () {
                                                            tec.inputTextFieldController
                                                                .text = "";
                                                          },
                                                          icon: const Icon(
                                                              Icons.clear),
                                                        ),
                                                      ),
                                                      onChanged: (value) {
                                                        // 입력값 변경시 에러 메세지 삭제
                                                        if (tec.inputTextFieldErrorMsg !=
                                                            null) {
                                                          tec.inputTextFieldErrorMsg =
                                                              null;
                                                          tec.inputTextFieldBloc
                                                              .refreshUi();
                                                        }
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ];

                                          textFieldRow.add(Container(
                                            margin:
                                                const EdgeInsets.only(left: 5),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  business
                                                      .deleteInput10ListItem(
                                                          idx);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.blue,
                                                ),
                                                child: const Text(
                                                  "-",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "MaruBuri"),
                                                )),
                                          ));

                                          widgetList.add(Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            child: Row(
                                              children: textFieldRow,
                                            ),
                                          ));
                                        }

                                        Column stringListColumn = Column(
                                          children: widgetList,
                                        );

                                        return stringListColumn;
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          business
                                              .addInput10ListItem();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                        ),
                                        child: const Text(
                                          "리스트 추가",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "MaruBuri"),
                                        )),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: ElevatedButton(
                      onPressed: () {
                        business.doNetworkRequest();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text(
                        "네트워크 요청 테스트",
                        style: TextStyle(
                            color: Colors.white, fontFamily: "MaruBuri"),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// (BLoC 갱신 구역 설정 방법)
// 위젯을 작성 하다가 특정 부분은 상태에 따라 UI 가 변하도록 하고 싶은 부분이 있습니다.
// 이 경우 Stateful 위젯을 생성 해서 사용 하면 되지만,
// 간단히 갱신 영역을 지정 하여 해당 구역만 갱신 하도록 하기 위해선 BLoC 갱신 구역을 설정 하여 사용 하면 됩니다.
// Business 클래스 안에 BLoC 갱신 구역 조작 객체로
// gc_template_classes.RefreshableBloc refreshableBloc = gc_template_classes.RefreshableBloc();
// 위와 같이 선언 및 생성 하고,
// Widget 에서는, 갱신 하려는 구역을
// BlocProvider(
//         create: (context) => business.refreshableBloc,
//         child: BlocBuilder<gc_template_classes.RefreshableBloc, bool>(
//         builder: (c,s){
//             return Text(business.sampleInt.toString());
//         },
//     ),
// )
// 위와 같이 감싸 줍니다.
// 만약 위와 같은 Text 위젯에서 숫자 표시를 갱신 하려면,
// business.sampleInt += 1;
// business.refreshableBloc.refreshUi();
// 이처럼 Text 위젯에서 사용 하는 상태 변수의 값을 변경 하고,
// 갱신 구역 객체의 refreshUi() 함수를 실행 시키면,
// builder 가 다시 실행 되며, 그 안의 위젯이 재조립 되어 화면을 갱신 합니다.
