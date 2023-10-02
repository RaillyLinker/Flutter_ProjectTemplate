// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// (page)
import 'page_entrance.dart' as page_entrance;

import '../../../../repositories/network/apis/api_main_server.dart'
    as api_main_server;
import '../../../dialogs/all/all_dialog_info/page_entrance.dart'
    as all_dialog_info;
import '../../../dialogs/all/all_dialog_loading_spinner/page_entrance.dart'
    as all_dialog_loading_spinner;
import '../../../dialogs/all/all_dialog_auth_check_register_phone_number_verification_code/page_entrance.dart'
    as all_dialog_auth_check_register_phone_number_verification_code;
import '../../../pages/all/all_page_register_member_info/page_entrance.dart'
    as all_page_register_member_info;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;

// [페이지 비즈니스 로직 및 뷰모델 작성 파일]

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 및 뷰모델 담당
// PageBusiness 인스턴스는 PageView 가 재생성 되어도 재활용이 되며 PageViewModel 인스턴스 역시 유지됨.
class PageBusiness {
  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // 페이지 뷰모델 (StateFul 위젯 State 데이터는 모두 여기에 저장됨)
  late PageViewModel pageViewModel;

  // BLoC 객체 모음
  late BLocObjects blocObjects;

  // 생성자 설정
  PageBusiness(this._context, GoRouterState goRouterState) {
    pageViewModel = PageViewModel(goRouterState);
  }

  ////
  // [페이지 생명주기]
  // - 페이지 최초 실행 : onPageCreateAsync -> onPageResumeAsync
  // - 다른 페이지 호출 / 복귀, 화면 끄기 / 켜기, 모바일에서 다른 앱으로 이동 및 복귀시 :
  // onPagePauseAsync -> onPageResumeAsync -> onPagePauseAsync -> onPageResumeAsync 반복
  // - 페이지 종료 : onPageWillPopAsync -(return true 일 때)-> onPagePauseAsync -> onPageDestroyAsync 실행

  // (페이지 최초 실행)
  Future<void> onPageCreateAsync() async {
    // !!!페이지 최초 실행 로직 작성!!

    // !!!pageViewModel.goRouterState 에서 pageInputVo Null 체크!!

    // !!!pageViewModel.goRouterState 에서 PageInputVo 입력!!
    pageViewModel.pageInputVo = page_entrance.PageInputVo();
  }

  // (페이지 최초 실행 or 다른 페이지에서 복귀)
  Future<void> onPageResumeAsync() async {
    // !!!위젯 최초 실행 및, 다른 페이지에서 복귀 로직 작성!!
  }

  // (페이지 종료 or 다른 페이지로 이동 (강제 종료는 탐지 못함))
  Future<void> onPagePauseAsync() async {
    // !!!위젯 종료 및, 다른 페이지로 이동 로직 작성!!
  }

  // (페이지 종료 (강제 종료는 탐지 못함))
  Future<void> onPageDestroyAsync() async {
    // !!!페이지 종료 로직 작성!!
    pageViewModel.phoneNumberTextEditController.dispose();
    pageViewModel.passwordTextFieldController.dispose();
    pageViewModel.passwordCheckTextFieldController.dispose();
    pageViewModel.phoneNumberTextEditFocus.dispose();
    pageViewModel.passwordTextFieldFocus.dispose();
    pageViewModel.passwordCheckTextFieldFocus.dispose();
  }

  // (Page Pop 요청)
  // context.pop() 호출 직후 호출
  // return 이 true 라면 onWidgetPause 부터 onPageDestroyAsync 까지 실행 되며 페이지 종료
  // return 이 false 라면 pop 되지 않고 그대로 대기
  Future<bool> onPageWillPopAsync() async {
    // !!!onWillPop 로직 작성!!

    return true;
  }

////
// [비즈니스 함수]
// !!!외부에서 사용할 비즈니스 로직은 아래에 공개 함수로 구현!!
// ex :
//   void changeSampleNumber(int newSampleNumber) {
//     // 뷰모델 state 변경
//     pageViewModel.sampleNumber = newSampleNumber;
//     // 위젯 변경 트리거 발동
//     bLocObjects.blocSample.add(!bLocObjects.blocSample.state);
//   }

  // (문자 체크 버튼 클릭)
  void onSmsBtnClick() {
    if (pageViewModel.phoneNumberTextEditEnabled) {
      // 전화번호 입력 활성화 상태 (= 아직 전화번호 확인하지 않은 상태)
      sendVerificationSms();
    } else {
      // 전화번호 입력 비활성화 상태 (= 전화번호 확인한 상태)
      pageViewModel.phoneNumberTextEditEnabled = true;
      pageViewModel.phoneNumberTextEditErrorMsg = null;
      blocObjects.blocPhoneNumberEditText
          .add(!blocObjects.blocPhoneNumberEditText.state);

      pageViewModel.smsCheckBtn = "SMS\nCheck";
      blocObjects.blocPhoneNumberCheckBtn
          .add(!blocObjects.blocPhoneNumberCheckBtn.state);
    }
  }

  // (인증 문자 발송)
  bool isSendVerificationSmsClicked = false;

  void sendVerificationSms() async {
    if (isSendVerificationSmsClicked) {
      return;
    }
    isSendVerificationSmsClicked = true;

    var phoneNumber = pageViewModel.phoneNumberTextEditController.text.trim();
    if (phoneNumber == "") {
      pageViewModel.phoneNumberTextEditErrorMsg = "Please enter phone number";
      blocObjects.blocPhoneNumberEditText
          .add(!blocObjects.blocPhoneNumberEditText.state);
      isSendVerificationSmsClicked = false;
      FocusScope.of(_context)
          .requestFocus(pageViewModel.phoneNumberTextEditFocus);
    } else if (!RegExp(r'^\d{1,4}\)\d{1,3}-\d{1,4}-\d{1,4}$')
        .hasMatch(pageViewModel.phoneNumberTextEditController.text)) {
      pageViewModel.phoneNumberTextEditErrorMsg =
          "This is not a valid phone number format.";
      blocObjects.blocPhoneNumberEditText
          .add(!blocObjects.blocPhoneNumberEditText.state);
      isSendVerificationSmsClicked = false;
      FocusScope.of(_context)
          .requestFocus(pageViewModel.phoneNumberTextEditFocus);
    } else {
      // 입력값 검증 완료
      // (로딩 스피너 다이얼로그 호출)
      var loadingSpinner = all_dialog_loading_spinner.PageEntrance(
          all_dialog_loading_spinner.PageInputVo(), (pageBusiness) async {
        var responseVo = await api_main_server
            .postRegisterWithPhoneNumberVerificationAsync(api_main_server
                .PostRegisterWithPhoneNumberVerificationAsyncRequestBodyVo(
                    phoneNumber));

        if (responseVo.dioException == null) {
          // Dio 네트워크 응답
          pageBusiness.closeDialog();
          var networkResponseObjectOk = responseVo.networkResponseObjectOk!;

          if (networkResponseObjectOk.responseStatusCode == 200) {
            // 정상 응답
            // 검증번호 입력 다이얼로그 띄우기
            if (!_context.mounted) return;
            all_dialog_auth_check_register_phone_number_verification_code
                .PageOutputVo? dialogResult = await showDialog(
                    barrierDismissible: false,
                    context: _context,
                    builder: (context) =>
                        all_dialog_auth_check_register_phone_number_verification_code
                            .PageEntrance(
                                all_dialog_auth_check_register_phone_number_verification_code
                                    .PageInputVo(phoneNumber),
                                (pageBusiness) {}));

            if (dialogResult != null) {
              pageViewModel.checkedPhoneNumberVerificationCode =
                  dialogResult.checkedVerificationCode;
              pageViewModel.phoneNumberTextEditEnabled = false;
              pageViewModel.phoneNumberTextEditErrorMsg = null;
              blocObjects.blocPhoneNumberEditText
                  .add(!blocObjects.blocPhoneNumberEditText.state);

              pageViewModel.smsCheckBtn = "Reset";
              blocObjects.blocPhoneNumberCheckBtn
                  .add(!blocObjects.blocPhoneNumberCheckBtn.state);
            }
          } else {
            // 비정상 응답
            var responseHeaders = networkResponseObjectOk.responseHeaders!
                as api_main_server
                .PostRegisterWithPhoneNumberVerificationAsyncResponseHeaderVo;

            if (responseHeaders.apiErrorCodes == null) {
              // 비정상 응답이면서 서버에서 에러 원인 코드가 전달되지 않았을 때
              if (!_context.mounted) return;
              showDialog(
                  barrierDismissible: true,
                  context: _context,
                  builder: (context) => all_dialog_info.PageEntrance(
                      all_dialog_info.PageInputVo(
                          "Network Error",
                          "network connection is unstable.\nplease try again.",
                          "check"),
                      (pageBusiness) {}));
            } else {
              // 서버 지정 에러 코드를 전달 받았을 때
              List<String> apiErrorCodes = responseHeaders.apiErrorCodes!;
              if (apiErrorCodes.contains("1")) {
                // 기존 회원 존재
                if (!_context.mounted) return;
                showDialog(
                    barrierDismissible: true,
                    context: _context,
                    builder: (context) => all_dialog_info.PageEntrance(
                        all_dialog_info.PageInputVo(
                            "Member registration process failed",
                            "You are already a registered member.",
                            "Check"),
                        (pageBusiness) {}));
              } else {
                // 알 수 없는 에러 코드일 때
                throw Exception("unKnown Error Code");
              }
            }
          }
        } else {
          pageBusiness.closeDialog();
          if (!_context.mounted) return;
          showDialog(
              barrierDismissible: true,
              context: _context,
              builder: (context) => all_dialog_info.PageEntrance(
                  all_dialog_info.PageInputVo(
                      "Network Error",
                      "network connection is unstable.\nplease try again.",
                      "check"),
                  (pageBusiness) {}));
        }
      });

      showDialog(
          barrierDismissible: false,
          context: _context,
          builder: (context) => loadingSpinner).then((outputVo) {});

      isSendVerificationSmsClicked = false;
    }
  }

  void phoneNumberTextEditOnChanged() {
    // 입력창의 에러를 지우기
    pageViewModel.phoneNumberTextEditErrorMsg = null;
    blocObjects.blocPhoneNumberEditText
        .add(!blocObjects.blocPhoneNumberEditText.state);
  }

  void passwordCheckTextEditOnChanged() {
    // 입력창의 에러를 지우기
    pageViewModel.passwordCheckTextEditErrorMsg = null;
    blocObjects.blocPasswordCheckTextField
        .add(!blocObjects.blocPasswordCheckTextField.state);
  }

  void passwordTextEditOnChanged() {
    // 입력창의 에러를 지우기
    pageViewModel.passwordTextEditErrorMsg = null;
    blocObjects.blocPasswordTextField
        .add(!blocObjects.blocPasswordTextField.state);
  }

  // (패스워드 입력창에서 엔터를 친 경우)
  void onPasswordFieldSubmitted() {
    if (pageViewModel.passwordTextFieldController.text == "") {
      pageViewModel.passwordTextEditErrorMsg = "Please enter a password";
      blocObjects.blocPasswordTextField
          .add(!blocObjects.blocPasswordTextField.state);
      FocusScope.of(_context)
          .requestFocus(pageViewModel.passwordTextFieldFocus);
    } else if (pageViewModel.passwordTextFieldController.text.contains(" ")) {
      pageViewModel.passwordTextEditErrorMsg =
          "Spaces cannot be used in the password.";
      blocObjects.blocPasswordTextField
          .add(!blocObjects.blocPasswordTextField.state);
      FocusScope.of(_context)
          .requestFocus(pageViewModel.passwordTextFieldFocus);
    } else if (pageViewModel.passwordTextFieldController.text.length < 8) {
      pageViewModel.passwordTextEditErrorMsg =
          "Set the length of the password to at least 8 digits";
      blocObjects.blocPasswordTextField
          .add(!blocObjects.blocPasswordTextField.state);
      FocusScope.of(_context)
          .requestFocus(pageViewModel.passwordTextFieldFocus);
    } else if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$&*])')
        .hasMatch(pageViewModel.passwordTextFieldController.text)) {
      pageViewModel.passwordTextEditErrorMsg =
          "The password must consist of a combination of letters, numbers, and special characters.";
      blocObjects.blocPasswordTextField
          .add(!blocObjects.blocPasswordTextField.state);
      FocusScope.of(_context)
          .requestFocus(pageViewModel.passwordTextFieldFocus);
    } else if (RegExp(r'[<>()#’/|]')
        .hasMatch(pageViewModel.passwordTextFieldController.text)) {
      pageViewModel.passwordTextEditErrorMsg = "< > ( ) # ’ / | can not use";
      blocObjects.blocPasswordTextField
          .add(!blocObjects.blocPasswordTextField.state);
      FocusScope.of(_context)
          .requestFocus(pageViewModel.passwordTextFieldFocus);
    } else {
      FocusScope.of(_context)
          .requestFocus(pageViewModel.passwordCheckTextFieldFocus);
    }
  }

  // (비번 숨기기 버튼 토글링)
  void toggleHidePassword() {
    pageViewModel.hidePassword = !pageViewModel.hidePassword;
    blocObjects.blocPasswordTextField
        .add(!blocObjects.blocPasswordTextField.state);
  }

  void toggleHidePasswordCheck() {
    pageViewModel.hidePasswordCheck = !pageViewModel.hidePasswordCheck;
    blocObjects.blocPasswordCheckTextField
        .add(!blocObjects.blocPasswordCheckTextField.state);
  }

  void onPasswordCheckFieldSubmitted() {
    goToNextStep();
  }

  // (회원가입 다음 단계로 이동)
  Future<void> goToNextStep() async {
    pageViewModel.phoneNumberTextEditErrorMsg = null;
    blocObjects.blocPhoneNumberEditText
        .add(!blocObjects.blocPhoneNumberEditText.state);
    pageViewModel.passwordTextEditErrorMsg = null;
    blocObjects.blocPasswordTextField
        .add(!blocObjects.blocPasswordTextField.state);
    pageViewModel.passwordCheckTextEditErrorMsg = null;
    blocObjects.blocPasswordCheckTextField
        .add(!blocObjects.blocPasswordCheckTextField.state);

    if (pageViewModel.checkedPhoneNumberVerificationCode == null) {
      pageViewModel.phoneNumberTextEditErrorMsg =
          "Phone number verification is required.";
      blocObjects.blocPhoneNumberEditText
          .add(!blocObjects.blocPhoneNumberEditText.state);
      FocusScope.of(_context)
          .requestFocus(pageViewModel.phoneNumberTextEditFocus);
    } else if (pageViewModel.passwordTextFieldController.text == "") {
      pageViewModel.passwordTextEditErrorMsg = "Please enter a password";
      blocObjects.blocPasswordTextField
          .add(!blocObjects.blocPasswordTextField.state);
      FocusScope.of(_context)
          .requestFocus(pageViewModel.passwordTextFieldFocus);
    } else if (pageViewModel.passwordTextFieldController.text.contains(" ")) {
      pageViewModel.passwordTextEditErrorMsg =
          "Spaces cannot be used in the password.";
      blocObjects.blocPasswordTextField
          .add(!blocObjects.blocPasswordTextField.state);
      FocusScope.of(_context)
          .requestFocus(pageViewModel.passwordTextFieldFocus);
    } else if (pageViewModel.passwordTextFieldController.text.length < 8) {
      pageViewModel.passwordTextEditErrorMsg =
          "Set the length of the password to at least 8 digits";
      blocObjects.blocPasswordTextField
          .add(!blocObjects.blocPasswordTextField.state);
      FocusScope.of(_context)
          .requestFocus(pageViewModel.passwordTextFieldFocus);
    } else if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$&*])')
        .hasMatch(pageViewModel.passwordTextFieldController.text)) {
      pageViewModel.passwordTextEditErrorMsg =
          "The password must consist of a combination of letters, numbers, and special characters.";
      blocObjects.blocPasswordTextField
          .add(!blocObjects.blocPasswordTextField.state);
      FocusScope.of(_context)
          .requestFocus(pageViewModel.passwordTextFieldFocus);
    } else if (RegExp(r'[<>()#’/|]')
        .hasMatch(pageViewModel.passwordTextFieldController.text)) {
      pageViewModel.passwordTextEditErrorMsg = "< > ( ) # ’ / | can not use";
      blocObjects.blocPasswordTextField
          .add(!blocObjects.blocPasswordTextField.state);
      FocusScope.of(_context)
          .requestFocus(pageViewModel.passwordTextFieldFocus);
    } else if (pageViewModel.passwordCheckTextFieldController.text == "") {
      pageViewModel.passwordCheckTextEditErrorMsg =
          "Please enter a password check";
      blocObjects.blocPasswordCheckTextField
          .add(!blocObjects.blocPasswordCheckTextField.state);
      FocusScope.of(_context)
          .requestFocus(pageViewModel.passwordCheckTextFieldFocus);
    } else if (pageViewModel.passwordCheckTextFieldController.text !=
        pageViewModel.passwordTextFieldController.text) {
      pageViewModel.passwordCheckTextEditErrorMsg = "Passwords do not match.";
      blocObjects.blocPasswordCheckTextField
          .add(!blocObjects.blocPasswordCheckTextField.state);
      FocusScope.of(_context)
          .requestFocus(pageViewModel.passwordCheckTextFieldFocus);
    } else {
      // 필수 정보 입력 페이지로 이동
      // (전달할 파라미터들)
      // 계정 타입 (email, phoneNumber)
      // String? authType;
      // 비밀코드 (계정 타입 email, phoneNumber : 사용할 비밀번호,)
      // String? secretOpt;
      // 멤버 아이디 (계정 타입 email : 이메일(test@email.com), phoneNumber : 전화번호(82)010-0000-0000),)
      // String? memberIdOpt;
      // 계정 검증 단계에서 발행된 검증 코드
      // String? verificationCode;

      if (!_context.mounted) return;
      var pageResult = await _context
          .pushNamed(all_page_register_member_info.pageName, queryParameters: {
        "authType": "phoneNumber",
        "secretOpt": pageViewModel.passwordTextFieldController.text,
        "memberId": pageViewModel.phoneNumberTextEditController.text.trim(),
        "verificationCode": pageViewModel.checkedPhoneNumberVerificationCode,
      });
      if (pageResult != null &&
          (pageResult as all_page_register_member_info.PageOutputVo)
              .registerComplete) {
        if (!_context.mounted) return;
        _context.pop(page_entrance.PageOutputVo(true));
      }
    }
  }

////
// [내부 함수]
// !!!내부에서만 사용할 함수를 아래에 구현!!
}

// (페이지 뷰 모델 데이터 형태)
// 페이지의 모든 화면 관련 데이터는 여기에 정의되며, Business 인스턴스 안에 객체로 저장 됩니다.
class PageViewModel {
  // 페이지 생명주기 관련 states
  var pageLifeCycleStates = gc_template_classes.PageLifeCycleStates();

  // 페이지 파라미터 (아래 goRouterState 에서 가져와 대입하기)
  late page_entrance.PageInputVo pageInputVo;
  GoRouterState goRouterState;

  // !!!페이지 데이터 정의!!
  // ex :
  // int sampleNumber = 0;

  String? phoneNumberTextEditErrorMsg;

  String? passwordTextEditErrorMsg;

  String? passwordCheckTextEditErrorMsg;

  TextEditingController phoneNumberTextEditController = TextEditingController();

  FocusNode phoneNumberTextEditFocus = FocusNode();

  bool phoneNumberTextEditEnabled = true;

  String? checkedPhoneNumberVerificationCode;

  String smsCheckBtn = "SMS\nCheck";

  FocusNode passwordTextFieldFocus = FocusNode();

  TextEditingController passwordTextFieldController = TextEditingController();

  bool hidePassword = true;

  FocusNode passwordCheckTextFieldFocus = FocusNode();

  TextEditingController passwordCheckTextFieldController =
      TextEditingController();

  bool hidePasswordCheck = true;

  PageViewModel(this.goRouterState);
}

// (BLoC 클래스 모음)
// 아래엔 런타임 위젯 변경의 트리거가 되는 BLoC 클래스들을 작성해 둡니다.
// !!!각 BLoC 클래스는 아래 예시를 '그대로' 복사 붙여넣기를 하여 클래스 이름만 변경합니다.!!
// ex :
// class BlocSample extends Bloc<bool, bool> {
//   BlocSample() : super(true) {
//     on<bool>((event, emit) {
//       emit(event);
//     });
//   }
// }

class BlocPhoneNumberEditText extends Bloc<bool, bool> {
  BlocPhoneNumberEditText() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }
}

class BlocPhoneNumberCheckBtn extends Bloc<bool, bool> {
  BlocPhoneNumberCheckBtn() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }
}

class BlocPasswordTextField extends Bloc<bool, bool> {
  BlocPasswordTextField() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }
}

class BlocPasswordCheckTextField extends Bloc<bool, bool> {
  BlocPasswordCheckTextField() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }
}

// (BLoC 프로바이더 클래스)
// 본 페이지에서 사용할 BLoC 객체를 모아두어 PageEntrance 에서 페이지 전역 설정에 사용 됩니다.
class BLocProviders {
// !!!위에 정의된 BLoC 클래스들에 대한 Provider 객체들을 아래 리스트에 모두 넣어줄 것!!
  List<BlocProvider<dynamic>> blocProviders = [
    // ex :
    // BlocProvider<BlocSample>(create: (context) => BlocSample()),
    BlocProvider<BlocPhoneNumberEditText>(
        create: (context) => BlocPhoneNumberEditText()),
    BlocProvider<BlocPhoneNumberCheckBtn>(
        create: (context) => BlocPhoneNumberCheckBtn()),
    BlocProvider<BlocPasswordTextField>(
        create: (context) => BlocPasswordTextField()),
    BlocProvider<BlocPasswordCheckTextField>(
        create: (context) => BlocPasswordCheckTextField()),
  ];
}

class BLocObjects {
  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // !!!BLoC 조작 객체 변수 선언!!
  // ex :
  // late BlocSample blocSample;
  late BlocPhoneNumberEditText blocPhoneNumberEditText;
  late BlocPhoneNumberCheckBtn blocPhoneNumberCheckBtn;
  late BlocPasswordTextField blocPasswordTextField;
  late BlocPasswordCheckTextField blocPasswordCheckTextField;

  // 생성자 설정
  BLocObjects(this._context) {
    // !!!BLoC 조작 객체 생성!!
    // ex :
    // blocSample = BlocProvider.of<BlocSample>(_context);
    blocPasswordTextField = BlocProvider.of<BlocPasswordTextField>(_context);
    blocPasswordCheckTextField =
        BlocProvider.of<BlocPasswordCheckTextField>(_context);
    blocPhoneNumberEditText =
        BlocProvider.of<BlocPhoneNumberEditText>(_context);
    blocPhoneNumberCheckBtn =
        BlocProvider.of<BlocPhoneNumberCheckBtn>(_context);
  }
}
