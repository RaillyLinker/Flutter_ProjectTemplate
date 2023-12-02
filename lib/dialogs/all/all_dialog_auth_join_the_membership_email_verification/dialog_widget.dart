// (external)
import 'package:flutter/material.dart';

// (inner Folder)
import 'dialog_widget_state.dart' as dialog_widget_state;

// (all)
import '../../../global_widgets/gw_text_form_field_wrapper/sf_widget.dart'
    as gw_text_form_field_wrapper;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
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
  const OutputVo({required this.checkedVerificationCode});

  // 발급받은 본인 인증 코드
  final String checkedVerificationCode;
}

class DialogWidget extends StatefulWidget {
  const DialogWidget(
      {required this.globalKey,
      required this.inputVo,
      required this.onDialogCreated})
      : super(key: globalKey);

  // [콜백 함수]
  @override
  dialog_widget_state.DialogWidgetState createState() =>
      dialog_widget_state.DialogWidgetState();

  // [public 변수]
  final InputVo inputVo;
  final GlobalKey<dialog_widget_state.DialogWidgetState> globalKey;

  // 다이얼로그가 Created 된 시점에 한번 실행됨
  final VoidCallback onDialogCreated;

  // [화면 작성]
  Widget widgetUiBuild(
      {required BuildContext context,
      required dialog_widget_state.DialogWidgetState currentState}) {
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
                          currentState.closeDialog();
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
                      '이메일 회원 가입을 위하여,\n본인 인증 이메일을\n(${inputVo.emailAddress})\n에 발송하였습니다.',
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
                        globalKey: currentState.gwTextFormFieldWrapperStateGk,
                        inputVo: gw_text_form_field_wrapper.InputVo(
                            autofocus: true,
                            labelText: '본인 이메일 인증 코드',
                            floatingLabelStyle:
                                const TextStyle(color: Colors.blue),
                            hintText: "발송된 본인 이메일 인증 코드를 입력하세요.",
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            inputValidator: (value) {
                              return currentState
                                  .onVerificationCodeInputValidateAndReturnErrorMsg(
                                      value);
                            },
                            onEditingComplete: () {
                              currentState.verifyCodeAndGoNext();
                            },
                            suffixIcon: IconButton(
                              onPressed: () {
                                currentState
                                    .gwTextFormFieldWrapperStateGk.currentState
                                    ?.setInputValue("");
                              },
                              icon: const Icon(Icons.clear),
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        currentState.resendVerificationEmail();
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
                      currentState.verifyCodeAndGoNext();
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
