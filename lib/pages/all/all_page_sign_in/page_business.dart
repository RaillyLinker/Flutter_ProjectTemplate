// (external)
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

// (page)
import 'page_entrance.dart' as page_entrance;

import '../../../../repositories/spws/spw_sign_in_member_info.dart'
    as spw_sign_in_member_info;
import '../../../../repositories/network/apis/api_main_server.dart'
    as api_main_server;
import '../../../dialogs/all/all_dialog_info/page_entrance.dart'
    as all_dialog_info;
import '../../../dialogs/all/all_dialog_loading_spinner/page_entrance.dart'
    as all_dialog_loading_spinner;
import '../../../dialogs/all/all_dialog_auth_choice_register_with/page_entrance.dart'
    as all_dialog_auth_choice_register_with;
import '../../../dialogs/all/all_dialog_auth_choice_find_password_with/page_entrance.dart'
    as all_dialog_auth_choice_find_password_with;
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
    pageViewModel.emailTextFieldController.dispose();
    pageViewModel.passwordTextFieldController.dispose();
    pageViewModel.emailTextFieldFocus.dispose();
    pageViewModel.passwordTextFieldFocus.dispose();
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

  // (비번 숨기기 버튼 토글링)
  void toggleHidePassword() {
    pageViewModel.hidePassword = !pageViewModel.hidePassword;
    blocObjects.blocPasswordTextField
        .add(!blocObjects.blocPasswordTextField.state);
  }

  // (계정 로그인 버튼 클릭)
  bool accountSignInAsyncClicked = false;

  void accountSignInAsync() async {
    if (accountSignInAsyncClicked) {
      return;
    }
    accountSignInAsyncClicked = true;

    String id = pageViewModel.emailTextFieldController.text;
    String password = pageViewModel.passwordTextFieldController.text;

    if (id.trim() != "") {
      if (password.trim() != "") {
        // 입력창이 모두 충족되었을 때

        // // 비밀번호 형식 검증
        // // 영문 대문자, 소문자, 숫자, 특수문자 허용, 최소 8자 이상, 특수문자 1개 이상 포함
        // RegExp passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
        // bool isPasswordValid =  passwordRegExp.hasMatch(password);

        // 로그인 타입 검증
        int loginTypeCode;

        switch (pageViewModel.accountSignInType) {
          case SignInType.nickname:
            {
              // 닉네임
              loginTypeCode = 0;
            }
            break;
          case SignInType.email:
            {
              // 이메일
              if (RegExp(
                      r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-zA-Z]{2,})$')
                  .hasMatch(id)) {
                // 이메일 형식이 맞음
                loginTypeCode = 1;
              } else {
                // 이메일 형식 맞지 않음
                FocusScope.of(_context)
                    .requestFocus(pageViewModel.emailTextFieldFocus);
                showToast(
                  "ID format is incorrect",
                  context: _context,
                  animation: StyledToastAnimation.scale,
                );
                accountSignInAsyncClicked = false;
                return;
              }
            }
            break;
          case SignInType.phoneNumber:
            {
              // 전화번호
              if (RegExp(r'^\d{1,4}\)\d{1,3}-\d{1,4}-\d{1,4}$').hasMatch(id)) {
                // 형식이 맞음
                loginTypeCode = 2;
              } else {
                // 전화번호 형식 맞지 않음
                FocusScope.of(_context)
                    .requestFocus(pageViewModel.emailTextFieldFocus);
                showToast(
                  "ID format is incorrect",
                  context: _context,
                  animation: StyledToastAnimation.scale,
                );
                accountSignInAsyncClicked = false;
                return;
              }
            }
            break;
          default:
            {
              throw Exception("accountSignInType not supported");
            }
        }

        var loadingSpinner = all_dialog_loading_spinner.PageEntrance(
            all_dialog_loading_spinner.PageInputVo(), (pageBusiness) async {
          // 네트워크 요청
          var responseVo = await api_main_server.postSignInWithPasswordAsync(
              api_main_server.PostSignInWithPasswordAsyncRequestBodyVo(
                  loginTypeCode, id, password));

          pageBusiness.closeDialog();

          if (responseVo.dioException == null) {
            // Dio 네트워크 응답
            var networkResponseObjectOk = responseVo.networkResponseObjectOk!;

            if (networkResponseObjectOk.responseStatusCode == 200) {
              // 정상 응답
              var responseBody =
                  responseVo.networkResponseObjectOk!.responseBody!;
              List<spw_sign_in_member_info.SharedPreferenceWrapperVoOAuth2Info>
                  myOAuth2ObjectList = [];
              for (api_main_server
                  .PostSignInWithPasswordAsyncResponseBodyVoOAuth2Info myOAuth2
                  in responseBody.myOAuth2List) {
                myOAuth2ObjectList.add(
                    spw_sign_in_member_info.SharedPreferenceWrapperVoOAuth2Info(
                        myOAuth2.oauth2TypeCode, myOAuth2.oauth2Id));
              }

              spw_sign_in_member_info.SharedPreferenceWrapper.set(
                  spw_sign_in_member_info.SharedPreferenceWrapperVo(
                responseBody.memberUid,
                responseBody.nickName,
                responseBody.roleCodeList,
                responseBody.tokenType,
                responseBody.accessToken,
                responseBody.accessTokenExpireWhen,
                responseBody.refreshToken,
                responseBody.refreshTokenExpireWhen,
                responseBody.myEmailList,
                responseBody.myPhoneNumberList,
                myOAuth2ObjectList,
              ));

              accountSignInAsyncClicked = false;
              if (!_context.mounted) return;
              if (_context.canPop()) {
                // History가 있는 경우, 이전 페이지로 이동(pop)
                _context.pop();
              } else {
                // History가 없는 경우, 앱 종료(exit)
                exit(0);
              }
            } else {
              // 비정상 응답
              if (networkResponseObjectOk.responseHeaders.apiErrorCodes ==
                  null) {
                // 비정상 응답이면서 서버에서 에러 원인 코드가 전달되지 않았을 때
                if (!_context.mounted) return;
                showDialog(
                    barrierDismissible: true,
                    context: _context,
                    builder: (context) => all_dialog_info.PageEntrance(
                        all_dialog_info.PageInputVo(
                            "네트워크 에러",
                            "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                            "확인"),
                        (pageBusiness) {}));
                accountSignInAsyncClicked = false;
              } else {
                // 서버 지정 에러 코드를 전달 받았을 때
                List<String> apiErrorCodes =
                    networkResponseObjectOk.responseHeaders.apiErrorCodes;
                if (apiErrorCodes.contains("1")) {
                  // 가입 되지 않은 회원
                  if (!_context.mounted) return;
                  showDialog(
                      barrierDismissible: true,
                      context: _context,
                      builder: (context) => all_dialog_info.PageEntrance(
                          all_dialog_info.PageInputVo("Sign in failed",
                              "You are a non-registered member.", "확인"),
                          (pageBusiness) {}));
                  accountSignInAsyncClicked = false;
                } else if (apiErrorCodes.contains("2")) {
                  // 로그인 정보 검증 불일치
                  if (!_context.mounted) return;
                  showDialog(
                      barrierDismissible: true,
                      context: _context,
                      builder: (context) => all_dialog_info.PageEntrance(
                          all_dialog_info.PageInputVo("Sign in failed",
                              "Sign in information does not match.", "확인"),
                          (pageBusiness) {}));
                  accountSignInAsyncClicked = false;
                } else if (apiErrorCodes.contains("3")) {
                  // 추가 로그인 금지됨(동시 로그인 제한시 추가 로그인을 금지한 상황일 때)
                  if (!_context.mounted) return;
                  showDialog(
                      barrierDismissible: true,
                      context: _context,
                      builder: (context) => all_dialog_info.PageEntrance(
                          all_dialog_info.PageInputVo(
                              "Sign in failed",
                              "This account is logging in from somewhere else.\nFurther logins are prohibited.",
                              "확인"),
                          (pageBusiness) {}));
                  accountSignInAsyncClicked = false;
                } else {
                  // 알 수 없는 에러 코드일 때
                  throw Exception("unKnown Error Code");
                }
              }
            }
          } else {
            if (!_context.mounted) return;
            showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_info.PageEntrance(
                    all_dialog_info.PageInputVo(
                        "네트워크 에러",
                        "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                        "확인"),
                    (pageBusiness) {}));
            accountSignInAsyncClicked = false;
          }
        });

        showDialog(
            barrierDismissible: false,
            context: _context,
            builder: (context) => loadingSpinner);
      } else {
        // 비밀번호 미입력 처리
        // 입력창에 Focus 주기
        FocusScope.of(_context)
            .requestFocus(pageViewModel.passwordTextFieldFocus);
        showToast(
          "Please enter your Password",
          context: _context,
          animation: StyledToastAnimation.scale,
        );
        accountSignInAsyncClicked = false;
      }
    } else {
      // 이메일 미입력 처리
      // 입력창에 Focus 주기
      FocusScope.of(_context).requestFocus(pageViewModel.emailTextFieldFocus);
      showToast(
        "Please enter your ID",
        context: _context,
        animation: StyledToastAnimation.scale,
      );
      accountSignInAsyncClicked = false;
    }
  }

  // (비밀번호 찾기 페이지 이동)
  void goToFindPasswordPage() {
    showDialog(
        barrierDismissible: true,
        context: _context,
        builder: (context) =>
            all_dialog_auth_choice_find_password_with.PageEntrance(
                all_dialog_auth_choice_find_password_with.PageInputVo(),
                (pageBusiness) {}));
  }

  // (회원가입 종류 선택)
  void selectRegisterWith() {
    // 회원가입 타입 선택 다이얼로그 표시
    showDialog(
        barrierDismissible: true,
        context: _context,
        builder: (context) => all_dialog_auth_choice_register_with.PageEntrance(
            all_dialog_auth_choice_register_with.PageInputVo(),
            (pageBusiness) {}));
  }

  // (Id 입력창 아이콘 클릭시)
  void changeSigninType() {
    pageViewModel.emailTextFieldController.text = "";
    if (pageViewModel.accountSignInType == SignInType.nickname) {
      pageViewModel.accountSignInType = SignInType.email;
    } else if (pageViewModel.accountSignInType == SignInType.email) {
      pageViewModel.accountSignInType = SignInType.phoneNumber;
    } else if (pageViewModel.accountSignInType == SignInType.phoneNumber) {
      pageViewModel.accountSignInType = SignInType.nickname;
    }

    blocObjects.blocAccountId.add(!blocObjects.blocAccountId.state);
  }

  // (ID 입력창에서 엔터를 쳤을 때)
  void onIdFieldSubmitted() {
    String id = pageViewModel.emailTextFieldController.text;

    if (id.trim() == "") {
      // 이메일 미입력 처리
      // 입력창에 Focus 주기
      FocusScope.of(_context).requestFocus(pageViewModel.emailTextFieldFocus);
      showToast(
        "Please enter your ID",
        context: _context,
        animation: StyledToastAnimation.scale,
      );
    } else {
      FocusScope.of(_context)
          .requestFocus(pageViewModel.passwordTextFieldFocus);
    }
  }

  // (Password 입력창에서 엔터를 쳤을 때)
  void onPasswordFieldSubmitted() {
    String id = pageViewModel.emailTextFieldController.text;
    String pw = pageViewModel.passwordTextFieldController.text;

    if (id.trim() == "") {
      // 이메일 미입력 처리
      // 입력창에 Focus 주기
      FocusScope.of(_context).requestFocus(pageViewModel.emailTextFieldFocus);
      showToast(
        "Please enter your ID",
        context: _context,
        animation: StyledToastAnimation.scale,
      );
    } else if (pw.trim() == "") {
      // 이메일 미입력 처리
      // 입력창에 Focus 주기
      FocusScope.of(_context)
          .requestFocus(pageViewModel.passwordTextFieldFocus);
      showToast(
        "Please enter your Password",
        context: _context,
        animation: StyledToastAnimation.scale,
      );
    } else {
      accountSignInAsync();
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

  bool hidePassword = true;

  TextEditingController emailTextFieldController = TextEditingController();

  TextEditingController passwordTextFieldController = TextEditingController();

  FocusNode emailTextFieldFocus = FocusNode();
  FocusNode passwordTextFieldFocus = FocusNode();

  // 계정 로그인 타입
  SignInType accountSignInType = SignInType.nickname;

  PageViewModel(this.goRouterState);
}

// 계정 로그인 타입
enum SignInType {
  // 닉네임
  nickname,
  // 이메일
  email,
  // 전화번호
  phoneNumber,
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

class BlocAccountId extends Bloc<bool, bool> {
  BlocAccountId() : super(true) {
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
    BlocProvider<BlocAccountId>(create: (context) => BlocAccountId()),
  ];
}

class BLocObjects {
  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // !!!BLoC 조작 객체 변수 선언!!
  // ex :
  // late BlocSample blocSample;
  late BlocPasswordTextField blocPasswordTextField;
  late BlocAccountId blocAccountId;

  // 생성자 설정
  BLocObjects(this._context) {
    // !!!BLoC 조작 객체 생성!!
    // ex :
    // blocSample = BlocProvider.of<BlocSample>(_context);
    blocPasswordTextField = BlocProvider.of<BlocPasswordTextField>(_context);
    blocAccountId = BlocProvider.of<BlocAccountId>(_context);
  }
}
