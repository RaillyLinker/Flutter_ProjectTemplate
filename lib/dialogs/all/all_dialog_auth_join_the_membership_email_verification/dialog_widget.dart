// (external)
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';

// (inner Folder)
import 'dialog_widget_business.dart' as dialog_widget_business;

// (all)
import '../../../global_widgets/gw_text_form_field_wrapper/sf_widget.dart'
    as gw_text_form_field_wrapper;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

//------------------------------------------------------------------------------
// (입력 데이터)
class InputVo {
  // !!!위젯 입력값 선언!!!
  const InputVo({required this.emailAddress, required this.verificationUid});

  // 본인 인증할 이메일 주소
  final String emailAddress;

  // 본인 인증 고유번호
  final int verificationUid;
}

// (결과 데이터)
class OutputVo {
  // !!!위젯 출력값 선언!!!
  const OutputVo(
      {required this.checkedVerificationCode, required this.verificationUid});

  // 발급받은 본인 인증 코드
  final String checkedVerificationCode;

  // 본인 인증 고유번호
  final int verificationUid;
}

//------------------------------------------------------------------------------
class DialogWidget extends StatefulWidget {
  const DialogWidget(
      {super.key,
      required this.inputVo,
      required this.business,
      required this.onDialogCreated});

  final InputVo inputVo;

  // 다이얼로그가 Created 된 시점에 한번 실행됨
  final VoidCallback onDialogCreated;

  final dialog_widget_business.PageWidgetBusiness business;

  @override
  DialogWidgetState createState() => DialogWidgetState();
}

class DialogWidgetState extends State<DialogWidget>
    with WidgetsBindingObserver {
  // [콜백 함수]
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    business = widget.business;
    business.refreshUi = refreshUi;
    business.inputVo = widget.inputVo;
    business.viewModel =
        dialog_widget_business.PageWidgetViewModel(context: context);
    business.initState(context: context);
  }

  @override
  void dispose() {
    business.dispose(context: context);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    business.refreshUi = refreshUi;
    return PopScope(
      canPop: business.canPop,
      child: FocusDetector(
        // (페이지 위젯의 FocusDetector 콜백들)
        onFocusGained: () async {
          if (business.needInitState) {
            business.needInitState = false;
            widget.onDialogCreated();
          }

          await business.onFocusGained(context: context);
        },
        onFocusLost: () async {
          await business.onFocusLost(context: context);
        },
        onVisibilityGained: () async {
          await business.onVisibilityGained(context: context);
        },
        onVisibilityLost: () async {
          await business.onVisibilityLost(context: context);
        },
        onForegroundGained: () async {
          await business.onForegroundGained(context: context);
        },
        onForegroundLost: () async {
          await business.onForegroundLost(context: context);
        },
        child: WidgetUi.viewWidgetBuild(context: context, business: business),
      ),
    );
  }

  // [public 변수]
  late dialog_widget_business.PageWidgetBusiness business;

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
      required dialog_widget_business.PageWidgetBusiness business}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          width: 400,
          decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 20, right: 20, left: 20),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          business.closeDialog(context: context);
                        },
                      )),
                  Container(
                    width: 400,
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 3, bottom: 3),
                    decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: const Center(
                      child: Text(
                        '본인 인증 이메일이 전송되었습니다.',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.normal,
                            fontFamily: "MaruBuri"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    '본인 인증 코드 검증',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "MaruBuri"),
                  ),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    width: 400,
                    child: Text(
                      '이메일 회원 가입을 위하여,\n본인 인증 이메일을\n(${business.inputVo.emailAddress})\n에 발송하였습니다.',
                      style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          fontFamily: "MaruBuri"),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    width: 400,
                    child: Form(
                      child: gw_text_form_field_wrapper.SfWidget(
                        globalKey:
                            business.viewModel.gwTextFormFieldWrapperStateGk,
                        inputVo: gw_text_form_field_wrapper.InputVo(
                            autofocus: true,
                            labelText: '본인 이메일 인증 코드',
                            floatingLabelStyle:
                                const TextStyle(color: Colors.blue),
                            hintText: "발송된 본인 이메일 인증 코드를 입력하세요.",
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                business
                                    .viewModel
                                    .gwTextFormFieldWrapperStateGk
                                    .currentState
                                    ?.textFieldController
                                    .text = "";
                                business.viewModel.gwTextFormFieldWrapperStateGk
                                    .currentState?.textFieldErrorMsg = null;
                                business.viewModel.gwTextFormFieldWrapperStateGk
                                    .currentState
                                    ?.refreshUi();
                              },
                              icon: const Icon(Icons.clear),
                            ),
                            onChanged: (value) {
                              // 입력값 변경시 에러 메세지 삭제
                              if (business
                                      .viewModel
                                      .gwTextFormFieldWrapperStateGk
                                      .currentState
                                      ?.textFieldErrorMsg !=
                                  null) {
                                business.viewModel.gwTextFormFieldWrapperStateGk
                                    .currentState?.textFieldErrorMsg = null;
                                business.viewModel.gwTextFormFieldWrapperStateGk
                                    .currentState
                                    ?.refreshUi();
                              }
                            },
                            onEditingComplete: () {
                              business.verifyCodeAndGoNext(context: context);
                            }),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        business.resendVerificationEmail(context: context);
                      },
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 160),
                        child: const Text(
                          '본인 인증 이메일 재전송',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontFamily: "MaruBuri"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Container(
                    width: 400,
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 2, bottom: 2),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: const Text(
                      '이메일을 받지 못했다면,\n'
                      '- 입력한 이메일 주소가 올바른지 확인하세요.\n'
                      '- 이메일 스팸 보관함을 확인하세요.\n'
                      '- 이메일 저장소 용량이 충분한지 확인하세요.',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: "MaruBuri"),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  ElevatedButton(
                    onPressed: () {
                      business.verifyCodeAndGoNext(context: context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const SizedBox(
                      width: 400,
                      height: 40,
                      child: Center(
                        child: Text(
                          '본인 인증 코드 검증',
                          style: TextStyle(
                              color: Colors.white, fontFamily: "MaruBuri"),
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
    );
  }
}

// (Stateful Widget 예시)
// class SfWidget extends StatefulWidget {
//   const SfWidget({required this.globalKey}) : super(key: globalKey);
//
//   // [콜백 함수]
//   @override
//   SfWidgetState createState() => SfWidgetState();
//
//   // [public 변수]
//   final GlobalKey<SfWidgetState> globalKey;
//
//   // !!!외부 입력 변수 선언 하기!!!
//
//   // [화면 작성]
//   Widget widgetUiBuild(
//       {required BuildContext context, required SfWidgetState business}) {
//     // !!!뷰 위젯 반환 콜백 작성 하기!!!
//
//     return const Text("Sample");
//   }
// }
//
// class SfWidgetState extends State<SfWidget> {
//   SfWidgetState();
//
//   // [콜백 함수]
//   @override
//   Widget build(BuildContext context) {
//     return widget.widgetUiBuild(context: context, business: this);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     // !!!initState 작성!!!
//   }
//
//   @override
//   void dispose() {
//     // !!!dispose 작성!!!
//     super.dispose();
//   }
//
//   // [public 변수]
//
//   // [private 변수]
//
//   // [public 함수]
//   // (Stateful Widget 화면 갱신)
//   void refreshUi() {
//     setState(() {});
//   }
// }

// (Stateless Widget 예시)
// class SlWidget extends StatelessWidget {
//   const SlWidget({super.key, required this.business});
//
//   // [public 변수]
//   final SlWidgetBusiness business;
//
//   // !!!외부 입력 변수 선언 하기!!!
//
//   // [콜백 함수]
//   // (위젯을 화면에 draw 할 때의 콜백)
//   @override
//   Widget build(BuildContext context) {
//     return widgetUiBuild(context: context);
//   }
//
//   // [화면 작성]
//   Widget widgetUiBuild({required BuildContext context}) {
//     // !!!뷰 위젯 반환 콜백 작성 하기!!!
//
//     return const Text("Sample");
//   }
// }
//
// class SlWidgetBusiness {
//   // [콜백 함수]
//
//   // [public 변수]
//
//   // [private 변수]
//
//   // [public 함수]
//
//   // [private 함수]
// }
