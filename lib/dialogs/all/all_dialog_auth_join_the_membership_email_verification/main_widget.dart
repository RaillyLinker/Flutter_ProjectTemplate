// (external)
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';

// (inner_folder)
import 'main_business.dart' as main_business;

// (all)
import 'package:flutter_project_template/global_widgets/gw_sfw_wrapper.dart'
    as gw_sfw_wrapper;

// [위젯 뷰]

//------------------------------------------------------------------------------
// (입력 데이터)
class InputVo {
  // !!!위젯 입력값 선언!!!
  const InputVo(
      {required this.onDialogCreated,
      required this.emailAddress,
      required this.verificationUid});

  // (다이얼로그가 생성된 시점에 한번 실행 되는 콜백)
  final VoidCallback onDialogCreated;

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
class MainWidget extends StatefulWidget {
  const MainWidget({super.key, required this.inputVo});

  final InputVo inputVo;

  @override
  MainWidgetState createState() => MainWidgetState();
}

class MainWidgetState extends State<MainWidget> with WidgetsBindingObserver {
  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    mainBusiness.mainContext = context;
    mainBusiness.refreshUi = refreshUi;
    if (mainBusiness.pageInitFirst) {
      mainBusiness.pageInitFirst = false;
      mainBusiness.onCreate();
    }
    return PopScope(
      canPop: mainBusiness.canPop,
      child: FocusDetector(
        onFocusGained: () async {
          if (mainBusiness.needCallOnDialogCreated) {
            mainBusiness.needCallOnDialogCreated = false;
            widget.inputVo.onDialogCreated();
          }
          await mainBusiness.onFocusGainedAsync();
        },
        onFocusLost: () async {
          await mainBusiness.onFocusLostAsync();
        },
        onVisibilityGained: () async {
          await mainBusiness.onVisibilityGainedAsync();
        },
        onVisibilityLost: () async {
          await mainBusiness.onVisibilityLostAsync();
        },
        onForegroundGained: () async {
          await mainBusiness.onForegroundGainedAsync();
        },
        onForegroundLost: () async {
          await mainBusiness.onForegroundLostAsync();
        },
        child: getScreenWidget(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    mainBusiness.mainContext = context;
    mainBusiness.refreshUi = refreshUi;
    mainBusiness.inputVo = widget.inputVo;
    mainBusiness.initState();
  }

  @override
  void dispose() {
    mainBusiness.mainContext = context;
    mainBusiness.refreshUi = refreshUi;
    mainBusiness.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // [public 변수]
  // (mainBusiness) - 데이터 변수 및 함수 저장 역할
  final main_business.MainBusiness mainBusiness = main_business.MainBusiness();

  //----------------------------------------------------------------------------
  // !!!위젯 관련 함수는 이 곳에서 저장 하여 사용 하세요.!!!
  // [public 함수]
  // (MainWidget Refresh 함수)
  void refreshUi() {
    setState(() {});
  }

  // [private 함수]

  //----------------------------------------------------------------------------
  // [화면 작성]
  Widget getScreenWidget() {
    // !!!화면 위젯 작성 하기!!!

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
                          mainBusiness.closeDialog();
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
                      '이메일 회원 가입을 위하여,\n본인 인증 이메일을\n(${mainBusiness.inputVo.emailAddress})\n에 발송하였습니다.',
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
                      child: gw_sfw_wrapper.SfwRefreshWrapper(
                        key: mainBusiness.verificationCodeTextFieldAreaGk,
                        widgetBuild: (context) {
                          mainBusiness.verificationCodeTextFieldContext =
                              context;
                          return TextFormField(
                            autofocus: true,
                            controller: mainBusiness
                                .verificationCodeTextFieldController,
                            focusNode:
                                mainBusiness.verificationCodeTextFieldFocus,
                            decoration: InputDecoration(
                              labelText: '본인 이메일 인증 코드',
                              hintText: "발송된 본인 이메일 인증 코드를 입력하세요.",
                              errorText: mainBusiness
                                  .verificationCodeTextFieldErrorMsg,
                              floatingLabelStyle:
                                  const TextStyle(color: Colors.blue),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  mainBusiness
                                      .verificationCodeTextFieldController
                                      .text = "";
                                  mainBusiness
                                      .verificationCodeTextFieldErrorMsg = null;
                                  mainBusiness.verificationCodeTextFieldAreaGk
                                      .currentState
                                      ?.refreshUi();
                                },
                                icon: const Icon(Icons.clear),
                              ),
                            ),
                            onChanged: (value) {
                              // 입력값 변경시 에러 메세지 삭제
                              if (mainBusiness
                                      .verificationCodeTextFieldErrorMsg !=
                                  null) {
                                mainBusiness.verificationCodeTextFieldErrorMsg =
                                    null;
                                mainBusiness.verificationCodeTextFieldAreaGk
                                    .currentState
                                    ?.refreshUi();
                              }
                            },
                            onEditingComplete: () {
                              mainBusiness.verifyCodeAndGoNext();
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        mainBusiness.resendVerificationEmail();
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
                      mainBusiness.verifyCodeAndGoNext();
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
