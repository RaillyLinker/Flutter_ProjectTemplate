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
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../../repositories/spws/spw_sign_in_member_info.dart'
    as spw_sign_in_member_info;

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
  PageBusiness(this._context, page_entrance.PageInputVo pageInputVo) {
    pageViewModel = PageViewModel(pageInputVo);
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
    pageViewModel.passwordTextFieldController.dispose();
    pageViewModel.newPasswordTextFieldController.dispose();
    pageViewModel.newPasswordCheckTextFieldController.dispose();
    pageViewModel.passwordTextFieldFocus.dispose();
    pageViewModel.newPasswordTextFieldFocus.dispose();
    pageViewModel.newPasswordCheckTextFieldFocus.dispose();
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

  void passwordTextEditOnChanged() {
    // 입력창의 에러를 지우기
    pageViewModel.passwordTextEditErrorMsg = null;
    blocObjects.blocPasswordTextField
        .add(!blocObjects.blocPasswordTextField.state);
  }

  void newPasswordCheckTextEditOnChanged() {
    // 입력창의 에러를 지우기
    pageViewModel.newPasswordCheckTextEditErrorMsg = null;
    blocObjects.blocNewPasswordCheckTextField
        .add(!blocObjects.blocNewPasswordCheckTextField.state);
  }

  void newPasswordTextEditOnChanged() {
    // 입력창의 에러를 지우기
    pageViewModel.newPasswordTextEditErrorMsg = null;
    blocObjects.blocNewPasswordTextField
        .add(!blocObjects.blocNewPasswordTextField.state);
  }

  void onPasswordFieldSubmitted() {
    FocusScope.of(_context)
        .requestFocus(pageViewModel.newPasswordTextFieldFocus);
  }

  void onNewPasswordFieldSubmitted() {
    if (pageViewModel.newPasswordTextFieldController.text == "") {
      if (pageViewModel.passwordTextFieldController.text == "") {
        pageViewModel.newPasswordTextEditErrorMsg =
            "Please enter a new password";
        blocObjects.blocNewPasswordTextField
            .add(!blocObjects.blocNewPasswordTextField.state);
        FocusScope.of(_context)
            .requestFocus(pageViewModel.newPasswordTextFieldFocus);
      } else {
        FocusScope.of(_context)
            .requestFocus(pageViewModel.newPasswordCheckTextFieldFocus);
      }
    } else {
      if (pageViewModel.newPasswordTextFieldController.text.contains(" ")) {
        pageViewModel.newPasswordTextEditErrorMsg =
            "Spaces cannot be used in the new password.";
        blocObjects.blocNewPasswordTextField
            .add(!blocObjects.blocNewPasswordTextField.state);
        FocusScope.of(_context)
            .requestFocus(pageViewModel.newPasswordTextFieldFocus);
      } else if (pageViewModel.newPasswordTextFieldController.text.length < 8) {
        pageViewModel.newPasswordTextEditErrorMsg =
            "Set the length of the password to at least 8 digits";
        blocObjects.blocNewPasswordTextField
            .add(!blocObjects.blocNewPasswordTextField.state);
        FocusScope.of(_context)
            .requestFocus(pageViewModel.newPasswordTextFieldFocus);
      } else if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$&*])')
          .hasMatch(pageViewModel.newPasswordTextFieldController.text)) {
        pageViewModel.newPasswordTextEditErrorMsg =
            "The password must consist of a combination of letters, numbers, and special characters.";
        blocObjects.blocNewPasswordTextField
            .add(!blocObjects.blocNewPasswordTextField.state);
        FocusScope.of(_context)
            .requestFocus(pageViewModel.newPasswordTextFieldFocus);
      } else if (RegExp(r'[<>()#’/|]')
          .hasMatch(pageViewModel.newPasswordTextFieldController.text)) {
        pageViewModel.newPasswordTextEditErrorMsg =
            "< > ( ) # ’ / | can not use";
        blocObjects.blocNewPasswordTextField
            .add(!blocObjects.blocNewPasswordTextField.state);
        FocusScope.of(_context)
            .requestFocus(pageViewModel.newPasswordTextFieldFocus);
      } else {
        FocusScope.of(_context)
            .requestFocus(pageViewModel.newPasswordCheckTextFieldFocus);
      }
    }
  }

  void toggleHidePassword() {
    pageViewModel.hidePassword = !pageViewModel.hidePassword;
    blocObjects.blocPasswordTextField
        .add(!blocObjects.blocPasswordTextField.state);
  }

  // (비번 숨기기 버튼 토글링)
  void toggleHideNewPassword() {
    pageViewModel.hideNewPassword = !pageViewModel.hideNewPassword;
    blocObjects.blocNewPasswordTextField
        .add(!blocObjects.blocNewPasswordTextField.state);
  }

  void toggleHideNewPasswordCheck() {
    pageViewModel.hideNewPasswordCheck = !pageViewModel.hideNewPasswordCheck;
    blocObjects.blocNewPasswordCheckTextField
        .add(!blocObjects.blocNewPasswordCheckTextField.state);
  }

  void onNewPasswordCheckFieldSubmitted() {
    changePassword();
  }

  // (비밀번호 변경)
  bool changePasswordStart = false;

  Future<void> changePassword() async {
    if (changePasswordStart) {
      return;
    }
    changePasswordStart = true;

    pageViewModel.passwordTextEditErrorMsg = null;
    blocObjects.blocPasswordTextField
        .add(!blocObjects.blocPasswordTextField.state);
    pageViewModel.newPasswordTextEditErrorMsg = null;
    blocObjects.blocNewPasswordTextField
        .add(!blocObjects.blocNewPasswordTextField.state);
    pageViewModel.newPasswordCheckTextEditErrorMsg = null;
    blocObjects.blocNewPasswordCheckTextField
        .add(!blocObjects.blocNewPasswordCheckTextField.state);

    if (pageViewModel.newPasswordTextFieldController.text == "") {
      if (pageViewModel.passwordTextFieldController.text == "") {
        pageViewModel.newPasswordTextEditErrorMsg =
            "Please enter a new password";
        blocObjects.blocNewPasswordTextField
            .add(!blocObjects.blocNewPasswordTextField.state);
        FocusScope.of(_context)
            .requestFocus(pageViewModel.newPasswordTextFieldFocus);
      } else {
        if (pageViewModel.newPasswordCheckTextFieldController.text == "") {
          await _requestChangePassword();
        } else {
          pageViewModel.newPasswordCheckTextEditErrorMsg =
              "Passwords do not match.";
          blocObjects.blocNewPasswordCheckTextField
              .add(!blocObjects.blocNewPasswordCheckTextField.state);
          FocusScope.of(_context)
              .requestFocus(pageViewModel.newPasswordCheckTextFieldFocus);
        }
      }
    } else {
      if (pageViewModel.newPasswordTextFieldController.text.contains(" ")) {
        pageViewModel.newPasswordTextEditErrorMsg =
            "Spaces cannot be used in the new password.";
        blocObjects.blocNewPasswordTextField
            .add(!blocObjects.blocNewPasswordTextField.state);
        FocusScope.of(_context)
            .requestFocus(pageViewModel.newPasswordTextFieldFocus);
      } else if (pageViewModel.newPasswordTextFieldController.text.length < 8) {
        pageViewModel.newPasswordTextEditErrorMsg =
            "Set the length of the password to at least 8 digits";
        blocObjects.blocNewPasswordTextField
            .add(!blocObjects.blocNewPasswordTextField.state);
        FocusScope.of(_context)
            .requestFocus(pageViewModel.newPasswordTextFieldFocus);
      } else if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$&*])')
          .hasMatch(pageViewModel.newPasswordTextFieldController.text)) {
        pageViewModel.newPasswordTextEditErrorMsg =
            "The password must consist of a combination of letters, numbers, and special characters.";
        blocObjects.blocNewPasswordTextField
            .add(!blocObjects.blocNewPasswordTextField.state);
        FocusScope.of(_context)
            .requestFocus(pageViewModel.newPasswordTextFieldFocus);
      } else if (RegExp(r'[<>()#’/|]')
          .hasMatch(pageViewModel.newPasswordTextFieldController.text)) {
        pageViewModel.newPasswordTextEditErrorMsg =
            "< > ( ) # ’ / | can not use";
        blocObjects.blocNewPasswordTextField
            .add(!blocObjects.blocNewPasswordTextField.state);
        FocusScope.of(_context)
            .requestFocus(pageViewModel.newPasswordTextFieldFocus);
      } else if (pageViewModel.newPasswordCheckTextFieldController.text == "") {
        pageViewModel.newPasswordCheckTextEditErrorMsg =
            "Please enter a new password check";
        blocObjects.blocNewPasswordCheckTextField
            .add(!blocObjects.blocNewPasswordCheckTextField.state);
        FocusScope.of(_context)
            .requestFocus(pageViewModel.newPasswordCheckTextFieldFocus);
      } else if (pageViewModel.newPasswordCheckTextFieldController.text !=
          pageViewModel.newPasswordTextFieldController.text) {
        pageViewModel.newPasswordCheckTextEditErrorMsg =
            "Passwords do not match.";
        blocObjects.blocNewPasswordCheckTextField
            .add(!blocObjects.blocNewPasswordCheckTextField.state);
        FocusScope.of(_context)
            .requestFocus(pageViewModel.newPasswordCheckTextFieldFocus);
      } else {
        await _requestChangePassword();
      }
    }

    changePasswordStart = false;
  }

////
// [내부 함수]
// !!!내부에서만 사용할 함수를 아래에 구현!!
  Future<void> _requestChangePassword() async {
    var loadingSpinner = all_dialog_loading_spinner.PageEntrance(
        all_dialog_loading_spinner.PageInputVo(), (pageBusiness) async {
      spw_sign_in_member_info.SharedPreferenceWrapperVo? signInMemberInfo =
          spw_sign_in_member_info.SharedPreferenceWrapper.get();

      if(signInMemberInfo == null){
        if (!_context.mounted) return;
        await showDialog(
            barrierDismissible: true,
            context: _context,
            builder: (context) => all_dialog_info.PageEntrance(
                all_dialog_info.PageInputVo("Need Sign in",
                    "You are not signed in.\nfor change password, sign in please", "go back"),
                    (pageBusiness) {}));

        if (!_context.mounted) return;
        _context.pop();
        return;
      }

      String? oldPw;
      String? newPw;

      if(pageViewModel.passwordTextFieldController.text.trim() != ""){
        oldPw = pageViewModel.passwordTextFieldController.text;
      }

      if(pageViewModel.newPasswordTextFieldController.text.trim() != ""){
        newPw = pageViewModel.newPasswordTextFieldController.text;
      }

      var response = await api_main_server.putChangeAccountPasswordAsync(
          api_main_server.PutChangeAccountPasswordAsyncRequestHeaderVo(
              "${signInMemberInfo.tokenType} ${signInMemberInfo.accessToken}"),
          api_main_server.PutChangeAccountPasswordAsyncRequestBodyVo(
              oldPw, newPw));

      // 로딩 다이얼로그 제거
      pageBusiness.closeDialog();

      if (response.dioException == null) {
        // Dio 네트워크 응답
        var networkResponseObjectOk = response.networkResponseObjectOk!;

        if (networkResponseObjectOk.responseStatusCode == 200) {
          // 정상 응답

          // 확인 다이얼로그 호출
          if (!_context.mounted) return;
          showDialog(
              barrierDismissible: true,
              context: _context,
              builder: (context) => all_dialog_info.PageEntrance(
                  all_dialog_info.PageInputVo(
                      "Change Password", "Change Password Completed!", "Check"),
                  (pageBusiness) {})).then((outputVo) {
            // 로그아웃 처리
            spw_sign_in_member_info.SharedPreferenceWrapper.set(null);
            _context.pop();
          });
        } else {
          // 비정상 응답
          if (networkResponseObjectOk.responseHeaders.apiErrorCodes == null) {
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
            List<String> apiErrorCodes =
                networkResponseObjectOk.responseHeaders.apiErrorCodes;
            if (apiErrorCodes.contains("1")) {
              // 탈퇴된 회원
              if (!_context.mounted) return;
              await showDialog(
                  barrierDismissible: true,
                  context: _context,
                  builder: (context) => all_dialog_info.PageEntrance(
                      all_dialog_info.PageInputVo("canceled member",
                          "You are a canceled member.", "Check"),
                      (pageBusiness) {}));
            } else if (apiErrorCodes.contains("2")) {
              // 기존 비밀번호가 일치하지 않음
              if (!_context.mounted) return;
              await showDialog(
                  barrierDismissible: true,
                  context: _context,
                  builder: (context) => all_dialog_info.PageEntrance(
                      all_dialog_info.PageInputVo(
                          "Current Password Not Matched",
                          "Current Password Not Matched.\nChange Password And Try Again",
                          "Check"),
                      (pageBusiness) {}));
            } else if (apiErrorCodes.contains("3")) {
              // 비번을 null 로 만들려고 할 때 account 외의 OAuth2 인증이 없기에 비번 제거 불가
              if (!_context.mounted) return;
              await showDialog(
                  barrierDismissible: true,
                  context: _context,
                  builder: (context) => all_dialog_info.PageEntrance(
                      all_dialog_info.PageInputVo(
                          "change password failed",
                          "The password cannot be removed because there is no authentication method other than the password.",
                          "Check"),
                          (pageBusiness) {}));
            } else {
              // 알 수 없는 에러 코드일 때
              throw Exception("unKnown Error Code");
            }
          }
        }
      } else {
        // Dio 네트워크 에러
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
  }
}

// (페이지 뷰 모델 스키마)
// 페이지의 모든 화면 관련 데이터는 여기에 정의되며, Business 인스턴스 안에 객체로 저장 됩니다.
class PageViewModel {
  // 페이지 생명주기 관련 states
  var pageLifeCycleStates = gc_template_classes.PageLifeCycleStates();

  // 페이지 파라미터
  page_entrance.PageInputVo pageInputVo;

  // !!!페이지 데이터 정의!!
  // ex :
  // int sampleNumber = 0;

  String? passwordTextEditErrorMsg;

  String? newPasswordTextEditErrorMsg;

  String? newPasswordCheckTextEditErrorMsg;

  TextEditingController passwordTextFieldController = TextEditingController();

  TextEditingController newPasswordTextFieldController =
      TextEditingController();

  TextEditingController newPasswordCheckTextFieldController =
      TextEditingController();

  FocusNode passwordTextFieldFocus = FocusNode();

  FocusNode newPasswordTextFieldFocus = FocusNode();

  FocusNode newPasswordCheckTextFieldFocus = FocusNode();

  bool hidePassword = true;

  bool hideNewPassword = true;

  bool hideNewPasswordCheck = true;

  PageViewModel(this.pageInputVo);
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

class BlocPasswordTextField extends Bloc<bool, bool> {
  BlocPasswordTextField() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }
}

class BlocNewPasswordTextField extends Bloc<bool, bool> {
  BlocNewPasswordTextField() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }
}

class BlocNewPasswordCheckTextField extends Bloc<bool, bool> {
  BlocNewPasswordCheckTextField() : super(true) {
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
    BlocProvider<BlocPasswordTextField>(
        create: (context) => BlocPasswordTextField()),
    BlocProvider<BlocNewPasswordTextField>(
        create: (context) => BlocNewPasswordTextField()),
    BlocProvider<BlocNewPasswordCheckTextField>(
        create: (context) => BlocNewPasswordCheckTextField()),
  ];
}

class BLocObjects {
  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // !!!BLoC 조작 객체 변수 선언!!
  // ex :
  // late BlocSample blocSample;
  late BlocPasswordTextField blocPasswordTextField;
  late BlocNewPasswordTextField blocNewPasswordTextField;
  late BlocNewPasswordCheckTextField blocNewPasswordCheckTextField;

  // 생성자 설정
  BLocObjects(this._context) {
    // !!!BLoC 조작 객체 생성!!
    // ex :
    // blocSample = BlocProvider.of<BlocSample>(_context);
    blocPasswordTextField = BlocProvider.of<BlocPasswordTextField>(_context);
    blocNewPasswordTextField =
        BlocProvider.of<BlocNewPasswordTextField>(_context);
    blocNewPasswordCheckTextField =
        BlocProvider.of<BlocNewPasswordCheckTextField>(_context);
  }
}
