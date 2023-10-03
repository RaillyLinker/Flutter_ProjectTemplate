// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
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
    pageViewModel.verificationCodeTextFieldController.dispose();
    pageViewModel.phoneNumberTextEditFocus.dispose();
    pageViewModel.verificationCodeTextFieldFocus.dispose();
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
        // 비번 찾기 검증 요청
        var responseVo = await api_main_server
            .postFindPasswordWithPhoneNumberVerificationAsync(api_main_server
                .PostFindPasswordWithPhoneNumberVerificationAsyncRequestBodyVo(
                    phoneNumber));

        if (responseVo.dioException == null) {
          // Dio 네트워크 응답
          pageBusiness.closeDialog();
          var networkResponseObjectOk = responseVo.networkResponseObjectOk!;

          if (networkResponseObjectOk.responseStatusCode == 200) {
            // 정상 응답
            pageViewModel.phoneNumberTextEditErrorMsg = null;
            blocObjects.blocPhoneNumberEditText
                .add(!blocObjects.blocPhoneNumberEditText.state);

            if (!_context.mounted) return;
            showToast(
              "Send SMS Complete",
              context: _context,
              position: StyledToastPosition.center,
              animation: StyledToastAnimation.scale,
            );
          } else {
            // 비정상 응답
            var responseHeaders = networkResponseObjectOk.responseHeaders!
                as api_main_server
                .PostFindPasswordWithPhoneNumberVerificationAsyncResponseHeaderVo;

            if (responseHeaders.apiErrorCodes == null) {
              // 비정상 응답이면서 서버에서 에러 원인 코드가 전달되지 않았을 때
              if (!_context.mounted) return;
              showDialog(
                  barrierDismissible: true,
                  context: _context,
                  builder: (context) => all_dialog_info.PageEntrance(
                      all_dialog_info.PageInputVo(
                          "네트워크 에러", "네트워크 상태가 불안정합니다.\n다시 시도해주세요.", "확인"),
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
                        all_dialog_info.PageInputVo("Email Sending failed",
                            "You are not registered member.", "확인"),
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
                      "네트워크 에러", "네트워크 상태가 불안정합니다.\n다시 시도해주세요.", "확인"),
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

  void verificationCodeTextEditOnChanged() {
    // 입력창의 에러를 지우기
    pageViewModel.verificationCodeTextEditErrorMsg = null;
    blocObjects.blocVerificationCodeTextField
        .add(!blocObjects.blocVerificationCodeTextField.state);
  }

  // (검증 코드 입력창에서 엔터를 친 경우)
  void onVerificationCodeFieldSubmitted() {
    if (pageViewModel.verificationCodeTextFieldController.text.trim() == "") {
      pageViewModel.verificationCodeTextEditErrorMsg =
          "Please enter a verification code";
      blocObjects.blocVerificationCodeTextField
          .add(!blocObjects.blocVerificationCodeTextField.state);
      FocusScope.of(_context)
          .requestFocus(pageViewModel.verificationCodeTextFieldFocus);
    } else {
      findPassword();
    }
  }

  // (비밀번호 찾기)
  Future<void> findPassword() async {
    pageViewModel.phoneNumberTextEditErrorMsg = null;
    blocObjects.blocPhoneNumberEditText
        .add(!blocObjects.blocPhoneNumberEditText.state);
    pageViewModel.verificationCodeTextEditErrorMsg = null;
    blocObjects.blocVerificationCodeTextField
        .add(!blocObjects.blocVerificationCodeTextField.state);

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
    } else if (pageViewModel.verificationCodeTextFieldController.text.trim() ==
        "") {
      pageViewModel.verificationCodeTextEditErrorMsg =
          "Please enter the verification code";
      blocObjects.blocVerificationCodeTextField
          .add(!blocObjects.blocVerificationCodeTextField.state);
      FocusScope.of(_context)
          .requestFocus(pageViewModel.verificationCodeTextFieldFocus);
    } else {
      // 비밀번호 변경 요청 후 처리
      // 입력값 검증 완료
      // (로딩 스피너 다이얼로그 호출)
      var loadingSpinner = all_dialog_loading_spinner.PageEntrance(
          all_dialog_loading_spinner.PageInputVo(), (pageBusiness) async {
        // 비번 찾기 검증 요청
        var responseVo = await api_main_server
            .postFindPasswordWithPhoneNumberAsync(api_main_server
                .PostFindPasswordWithPhoneNumberAsyncRequestBodyVo(phoneNumber,
                    pageViewModel.verificationCodeTextFieldController.text));

        if (responseVo.dioException == null) {
          // Dio 네트워크 응답
          pageBusiness.closeDialog();
          var networkResponseObjectOk = responseVo.networkResponseObjectOk!;

          if (networkResponseObjectOk.responseStatusCode == 200) {
            // 정상 응답
            pageViewModel.phoneNumberTextEditErrorMsg = null;
            blocObjects.blocPhoneNumberEditText
                .add(!blocObjects.blocPhoneNumberEditText.state);

            if (!_context.mounted) return;
            await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_info.PageEntrance(
                    all_dialog_info.PageInputVo(
                        "Password Change Complete",
                        "A newly issued password has been sent to the phone number you entered.\n($phoneNumber)",
                        "확인"),
                    (pageBusiness) {}));

            if (!_context.mounted) return;
            _context.pop(page_entrance.PageOutputVo(true));
          } else {
            // 비정상 응답
            var responseHeaders = networkResponseObjectOk.responseHeaders!
                as api_main_server
                .PostFindPasswordWithPhoneNumberAsyncResponseHeaderVo;

            if (responseHeaders.apiErrorCodes == null) {
              // 비정상 응답이면서 서버에서 에러 원인 코드가 전달되지 않았을 때
              if (!_context.mounted) return;
              showDialog(
                  barrierDismissible: true,
                  context: _context,
                  builder: (context) => all_dialog_info.PageEntrance(
                      all_dialog_info.PageInputVo(
                          "네트워크 에러", "네트워크 상태가 불안정합니다.\n다시 시도해주세요.", "확인"),
                      (pageBusiness) {}));
            } else {
              // 서버 지정 에러 코드를 전달 받았을 때
              List<String> apiErrorCodes = responseHeaders.apiErrorCodes!;
              if (apiErrorCodes.contains("1")) {
                // 탈퇴된 회원
                if (!_context.mounted) return;
                showDialog(
                    barrierDismissible: true,
                    context: _context,
                    builder: (context) => all_dialog_info.PageEntrance(
                        all_dialog_info.PageInputVo("Password Change failed",
                            "You are not registered member.", "확인"),
                        (pageBusiness) {}));
              } else if (apiErrorCodes.contains("2")) {
                // 검증 요청을 보낸 적 없음 혹은 만료된 요청
                if (!_context.mounted) return;
                showDialog(
                    barrierDismissible: true,
                    context: _context,
                    builder: (context) => all_dialog_info.PageEntrance(
                        all_dialog_info.PageInputVo(
                            "Expired Request",
                            "This is an expired verification request.\nClick Send SMS Button.",
                            "확인"),
                        (pageBusiness) {}));
              } else if (apiErrorCodes.contains("3")) {
                // 검증 코드가 일치하지 않음
                if (!_context.mounted) return;
                showDialog(
                    barrierDismissible: true,
                    context: _context,
                    builder: (context) => all_dialog_info.PageEntrance(
                        all_dialog_info.PageInputVo("Password Change failed",
                            "Verification codes do not match.", "확인"),
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
                      "네트워크 에러", "네트워크 상태가 불안정합니다.\n다시 시도해주세요.", "확인"),
                  (pageBusiness) {}));
        }
      });

      showDialog(
          barrierDismissible: false,
          context: _context,
          builder: (context) => loadingSpinner).then((outputVo) {});
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

  String? verificationCodeTextEditErrorMsg;

  TextEditingController phoneNumberTextEditController = TextEditingController();

  FocusNode phoneNumberTextEditFocus = FocusNode();

  FocusNode verificationCodeTextFieldFocus = FocusNode();

  TextEditingController verificationCodeTextFieldController =
      TextEditingController();

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

class BlocVerificationCodeTextField extends Bloc<bool, bool> {
  BlocVerificationCodeTextField() : super(true) {
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
    BlocProvider<BlocVerificationCodeTextField>(
        create: (context) => BlocVerificationCodeTextField()),
  ];
}

class BLocObjects {
  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // !!!BLoC 조작 객체 변수 선언!!
  // ex :
  // late BlocSample blocSample;
  late BlocPhoneNumberEditText blocPhoneNumberEditText;
  late BlocVerificationCodeTextField blocVerificationCodeTextField;

  // 생성자 설정
  BLocObjects(this._context) {
    // !!!BLoC 조작 객체 생성!!
    // ex :
    // blocSample = BlocProvider.of<BlocSample>(_context);
    blocVerificationCodeTextField =
        BlocProvider.of<BlocVerificationCodeTextField>(_context);
    blocPhoneNumberEditText =
        BlocProvider.of<BlocPhoneNumberEditText>(_context);
  }
}
