// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:go_router/go_router.dart';

// (page)
import 'page_entrance.dart' as page_entrance;

// (all)
import '../../../global_widgets/gw_page_outer_frame/widget_business.dart'
    as gw_page_outer_frame_business;
import '../../../../repositories/network/apis/api_main_server.dart'
    as api_main_server;
import '../../../../repositories/spws/spw_auth_member_info.dart'
    as spw_auth_member_info;
import '../../../dialogs/all/all_dialog_info/widget_view.dart'
    as all_dialog_info_view;
import '../../../dialogs/all/all_dialog_info/widget_business.dart'
    as all_dialog_info_business;
import '../../../dialogs/all/all_dialog_loading_spinner/widget_view.dart'
    as all_dialog_loading_spinner_view;
import '../../../dialogs/all/all_dialog_loading_spinner/widget_business.dart'
    as all_dialog_loading_spinner_business;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../pages/all/all_page_find_password_with_email/page_entrance.dart'
    as all_page_find_password_with_email;
import '../../../pages/all/all_page_join_the_membership_email_verification/page_entrance.dart'
    as all_page_join_the_membership_email_verification;
import '../../../global_functions/gf_my_functions.dart' as gf_my_functions;
import '../../../pages/all/all_page_home/page_entrance.dart' as all_page_home;

// [페이지 비즈니스 로직 및 뷰모델 작성 파일]
// todo : 템플릿 적용
// todo : 입력 부분 Form 방식 변경

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 담당
// PageBusiness 인스턴스는 해당 페이지가 소멸하기 전까지 활용됩니다.
class PageBusiness {
  PageBusiness(this._context) {
    pageViewModel = PageViewModel(_context);
  }

  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // BLoC 객체 모음
  late BLocObjects blocObjects;

  // 페이지 생명주기 관련 states
  final gc_template_classes.PageLifeCycleStates pageLifeCycleStates =
      gc_template_classes.PageLifeCycleStates();

  // 페이지 파라미터 (아래 goRouterState 에서 가져와 대입하기)
  late page_entrance.PageInputVo pageInputVo;

  // 페이지 뷰모델 객체
  late PageViewModel pageViewModel;

  ////
  // [페이지 생명주기]
  // - 페이지 최초 실행 : onPageCreateAsync -> onPageResumeAsync
  // - 다른 페이지 호출 / 복귀, 화면 끄기 / 켜기, 모바일에서 다른 앱으로 이동 및 복귀시 :
  // onPagePauseAsync -> onPageResumeAsync -> onPagePauseAsync -> onPageResumeAsync 반복
  // - 페이지 종료 : onPageWillPopAsync -(return true 일 때)-> onPagePauseAsync -> onPageDestroyAsync 실행

  // (onPageCreateAsync 실행 전 PageInputVo 체크)
  // onPageCreateAsync 과 완전히 동일하나, 입력값 체크만을 위해 분리한 생명주기
  Future<void> onCheckPageInputVoAsync(GoRouterState goRouterState) async {
    // !!!pageInputVo 체크!!!
    // ex :
    // if (!goRouterState.uri.queryParameters
    //     .containsKey("inputValueString")) {
    //   // 필수 파라미터가 없는 경우에 대한 처리
    // }

    // !!!PageInputVo 입력!!!
    pageInputVo = page_entrance.PageInputVo();
  }

  // (페이지 최초 실행)
  Future<void> onPageCreateAsync() async {
    // !!!페이지 최초 실행 로직 작성!!!
  }

  // (페이지 최초 실행 or 다른 페이지에서 복귀)
  Future<void> onPageResumeAsync() async {
    // !!!위젯 최초 실행 및, 다른 페이지에서 복귀 로직 작성!!!

    // 검증된 현재 회원 정보 가져오기 (비회원이라면 null)
    spw_auth_member_info.SharedPreferenceWrapperVo? nowLoginMemberInfo =
        gf_my_functions.getNowVerifiedMemberInfo();

    if (nowLoginMemberInfo != null) {
      // 로그인 상태라면 진입금지
      showToast(
        "잘못된 진입입니다.",
        context: _context,
        animation: StyledToastAnimation.scale,
      );
      // 홈 페이지로 이동
      _context.goNamed(all_page_home.pageName);
      return;
    }
  }

  // (페이지 종료 or 다른 페이지로 이동 (강제 종료는 탐지 못함))
  Future<void> onPagePauseAsync() async {
    // !!!위젯 종료 및, 다른 페이지로 이동 로직 작성!!!
  }

  // (페이지 종료 (강제 종료, web 에서 브라우저 뒤로가기 버튼을 눌렀을 때는 탐지 못함))
  Future<void> onPageDestroyAsync() async {
    // !!!페이지 종료 로직 작성!!!
    pageViewModel.idTextFieldController.dispose();
    pageViewModel.passwordTextFieldController.dispose();
    pageViewModel.emailTextFieldFocus.dispose();
    pageViewModel.passwordTextFieldFocus.dispose();
  }

  // (Page Pop 요청)
  // context.pop() 호출 직후 호출
  // return 이 true 라면 onWidgetPause 부터 onPageDestroyAsync 까지 실행 되며 페이지 종료
  // return 이 false 라면 pop 되지 않고 그대로 대기
  Future<bool> onPageWillPopAsync() async {
    // !!!onWillPop 로직 작성!!!

    return true;
  }

////
// [비즈니스 함수]
// !!!외부에서 사용할 비즈니스 로직은 아래에 공개 함수로 구현!!!
// ex :
//   void changeSampleNumber(int newSampleNumber) {
//     // BLoC 위젯 관련 상태 변수 변경
//     pageViewModel.sampleNumber = newSampleNumber;
//     // BLoC 위젯 변경 트리거 발동
//     blocObjects.blocSample.refresh();
//   }

  // (비번 숨기기 버튼 토글링)
  void toggleHidePassword() {
    pageViewModel.hidePassword = !pageViewModel.hidePassword;
    blocObjects.blocPasswordTextField.refresh();
  }

  // (계정 로그인 버튼 클릭)
  bool accountLoginAsyncClicked = false;

  void accountLoginAsync() async {
    if (accountLoginAsyncClicked) {
      return;
    }
    accountLoginAsyncClicked = true;

    String id = pageViewModel.idTextFieldController.text;
    String password = pageViewModel.passwordTextFieldController.text;

    if (id.trim() != "") {
      if (RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-zA-Z]{2,})$')
          .hasMatch(id)) {
        if (password.trim() != "") {
          // 입력창이 모두 충족되었을 때

          // // 비밀번호 형식 검증
          // // 영문 대문자, 소문자, 숫자, 특수문자 허용, 최소 8자 이상, 특수문자 1개 이상 포함
          // RegExp passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
          // bool isPasswordValid =  passwordRegExp.hasMatch(password);

          // 이메일
          if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-zA-Z]{2,})$')
              .hasMatch(id)) {
            // 이메일 형식 맞지 않음
            FocusScope.of(_context)
                .requestFocus(pageViewModel.emailTextFieldFocus);
            showToast(
              "이메일 형식이 아닙니다.",
              context: _context,
              animation: StyledToastAnimation.scale,
            );
            accountLoginAsyncClicked = false;
            return;
          }

          var allDialogLoadingSpinnerBusiness =
              all_dialog_loading_spinner_business.WidgetBusiness();

          showDialog(
              barrierDismissible: false,
              context: _context,
              builder: (context) => all_dialog_loading_spinner_view.WidgetView(
                  business: allDialogLoadingSpinnerBusiness,
                  inputVo: const all_dialog_loading_spinner_view.InputVo(),
                  onDialogCreated: () {}));

          // 네트워크 요청
          var responseVo =
              await api_main_server.postService1TkV1AuthLoginWithPasswordAsync(
                  requestBodyVo: api_main_server
                      .PostService1TkV1AuthLoginWithPasswordAsyncRequestBodyVo(
                          loginTypeCode: 1, id: id, password: password));

          allDialogLoadingSpinnerBusiness.closeDialog();

          if (responseVo.dioException == null) {
            // Dio 네트워크 응답
            var networkResponseObjectOk = responseVo.networkResponseObjectOk!;

            if (networkResponseObjectOk.responseStatusCode == 200) {
              // 정상 응답
              var responseBody = responseVo
                      .networkResponseObjectOk!.responseBody! as api_main_server
                  .PostService1TkV1AuthLoginWithPasswordAsyncResponseBodyVo;

              List<spw_auth_member_info.SharedPreferenceWrapperVoOAuth2Info>
                  myOAuth2ObjectList = [];
              for (var myOAuth2 in responseBody.myOAuth2List) {
                myOAuth2ObjectList.add(
                    spw_auth_member_info.SharedPreferenceWrapperVoOAuth2Info(
                  myOAuth2.uid,
                  myOAuth2.oauth2TypeCode,
                  myOAuth2.oauth2Id,
                ));
              }

              List<spw_auth_member_info.SharedPreferenceWrapperVoProfileInfo>
                  myProfileObjectList = [];
              for (var myProfile in responseBody.myProfileList) {
                myProfileObjectList.add(
                    spw_auth_member_info.SharedPreferenceWrapperVoProfileInfo(
                  myProfile.uid,
                  myProfile.imageFullUrl,
                  myProfile.isFront,
                ));
              }

              List<spw_auth_member_info.SharedPreferenceWrapperVoEmailInfo>
                  myEmailList = [];
              for (var myProfile in responseBody.myEmailList) {
                myEmailList.add(
                    spw_auth_member_info.SharedPreferenceWrapperVoEmailInfo(
                  uid: myProfile.uid,
                  emailAddress: myProfile.emailAddress,
                  isFront: myProfile.isFront,
                ));
              }

              List<spw_auth_member_info.SharedPreferenceWrapperVoPhoneInfo>
                  myPhoneNumberList = [];
              for (var myProfile in responseBody.myPhoneNumberList) {
                myPhoneNumberList.add(
                    spw_auth_member_info.SharedPreferenceWrapperVoPhoneInfo(
                  uid: myProfile.uid,
                  phoneNumber: myProfile.phoneNumber,
                  isFront: myProfile.isFront,
                ));
              }

              spw_auth_member_info.SharedPreferenceWrapper.set(
                  value: spw_auth_member_info.SharedPreferenceWrapperVo(
                responseBody.memberUid,
                responseBody.nickName,
                responseBody.roleList,
                responseBody.tokenType,
                responseBody.accessToken,
                responseBody.accessTokenExpireWhen,
                responseBody.refreshToken,
                responseBody.refreshTokenExpireWhen,
                myOAuth2ObjectList,
                myProfileObjectList,
                myEmailList,
                myPhoneNumberList,
                responseBody.authPasswordIsNull,
              ));

              accountLoginAsyncClicked = false;
              if (!_context.mounted) return;
              if (_context.canPop()) {
                // pop 이 가능하면 pop
                _context.pop();
              } else {
                // pop 이 불가능하면 Home 페이지로 이동
                _context.goNamed(all_page_home.pageName);
              }
            } else {
              // 비정상 응답
              var responseHeaderVo = networkResponseObjectOk.responseHeaders
                  as api_main_server
                  .PostService1TkV1AuthLoginWithPasswordAsyncResponseHeaderVo;

              switch (responseHeaderVo.apiResultCode) {
                case "1":
                  {
                    // 가입 되지 않은 회원
                    var allDialogInfoBusiness =
                        all_dialog_info_business.WidgetBusiness();
                    if (!_context.mounted) return;
                    showDialog(
                        barrierDismissible: true,
                        context: _context,
                        builder: (context) => all_dialog_info_view.WidgetView(
                              business: allDialogInfoBusiness,
                              inputVo: const all_dialog_info_view.InputVo(
                                  dialogTitle: "로그인 실패",
                                  dialogContent: "가입되지 않은 회원입니다.",
                                  checkBtnTitle: "확인"),
                              onDialogCreated: () {},
                            ));
                    accountLoginAsyncClicked = false;
                  }
                  break;
                case "2":
                  {
                    // 로그인 정보 검증 불일치
                    var allDialogInfoBusiness =
                        all_dialog_info_business.WidgetBusiness();
                    if (!_context.mounted) return;
                    showDialog(
                        barrierDismissible: true,
                        context: _context,
                        builder: (context) => all_dialog_info_view.WidgetView(
                              business: allDialogInfoBusiness,
                              inputVo: const all_dialog_info_view.InputVo(
                                  dialogTitle: "로그인 실패",
                                  dialogContent: "비밀번호가 일치하지 않습니다.",
                                  checkBtnTitle: "확인"),
                              onDialogCreated: () {},
                            ));
                    accountLoginAsyncClicked = false;
                  }
                  break;
                default:
                  {
                    // 비정상 응답이면서 서버에서 에러 원인 코드가 전달되지 않았을 때
                    var allDialogInfoBusiness =
                        all_dialog_info_business.WidgetBusiness();
                    if (!_context.mounted) return;
                    showDialog(
                        barrierDismissible: true,
                        context: _context,
                        builder: (context) => all_dialog_info_view.WidgetView(
                              business: allDialogInfoBusiness,
                              inputVo: const all_dialog_info_view.InputVo(
                                  dialogTitle: "네트워크 에러",
                                  dialogContent: "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                                  checkBtnTitle: "확인"),
                              onDialogCreated: () {},
                            ));
                    accountLoginAsyncClicked = false;
                  }
              }
            }
          } else {
            var allDialogInfoBusiness =
                all_dialog_info_business.WidgetBusiness();
            if (!_context.mounted) return;
            showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_info_view.WidgetView(
                      business: allDialogInfoBusiness,
                      inputVo: const all_dialog_info_view.InputVo(
                          dialogTitle: "네트워크 에러",
                          dialogContent: "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                          checkBtnTitle: "확인"),
                      onDialogCreated: () {},
                    ));
            accountLoginAsyncClicked = false;
          }
        } else {
          // 비밀번호 미입력 처리
          // 입력창에 Focus 주기
          FocusScope.of(_context)
              .requestFocus(pageViewModel.passwordTextFieldFocus);
          showToast(
            "비밀번호를 입력하세요.",
            context: _context,
            animation: StyledToastAnimation.scale,
          );
          accountLoginAsyncClicked = false;
        }
      } else {
        // 이메일 형식 맞지 않음
        // 입력창에 Focus 주기
        FocusScope.of(_context).requestFocus(pageViewModel.emailTextFieldFocus);
        showToast(
          "이메일 형식이 아닙니다.",
          context: _context,
          animation: StyledToastAnimation.scale,
        );
        accountLoginAsyncClicked = false;
      }
    } else {
      // 이메일 미입력 처리
      // 입력창에 Focus 주기
      FocusScope.of(_context).requestFocus(pageViewModel.emailTextFieldFocus);
      showToast(
        "이메일을 입력하세요.",
        context: _context,
        animation: StyledToastAnimation.scale,
      );
      accountLoginAsyncClicked = false;
    }
  }

  // (비밀번호 찾기 페이지 이동)
  Future<void> goToFindPasswordPage() async {
    // 이메일 본인 검증 화면으로 이동
    if (!_context.mounted) return;
    all_page_find_password_with_email.PageOutputVo? pageOutputVo =
        await _context.pushNamed(all_page_find_password_with_email.pageName);
    //  종료 여부 확인
    if (pageOutputVo != null && pageOutputVo.complete) {
      if (!_context.mounted) return;
      _context.pop();
    }
  }

  // (회원가입 종류 선택)
  Future<void> selectRegisterWith() async {
    // 이메일 본인 검증 화면으로 이동
    if (!_context.mounted) return;
    all_page_join_the_membership_email_verification.PageOutputVo? pageOutputVo =
        await _context.pushNamed(
            all_page_join_the_membership_email_verification.pageName);
    //  종료 여부 확인
    if (pageOutputVo != null && pageOutputVo.registerComplete) {
      if (!_context.mounted) return;
      _context.pop();
    }
  }

  // (ID 입력창에서 엔터를 쳤을 때)
  void onIdFieldSubmitted() {
    String id = pageViewModel.idTextFieldController.text;

    if (id.trim() == "") {
      // 이메일 미입력 처리
      // 입력창에 Focus 주기
      FocusScope.of(_context).requestFocus(pageViewModel.emailTextFieldFocus);
      showToast(
        "이메일을 입력하세요.",
        context: _context,
        animation: StyledToastAnimation.scale,
      );
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-zA-Z]{2,})$')
        .hasMatch(id)) {
      // 이메일 형식 맞지 않음

      // 입력창에 Focus 주기
      FocusScope.of(_context).requestFocus(pageViewModel.emailTextFieldFocus);
      showToast(
        "이메일 형식이 아닙니다.",
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
    String id = pageViewModel.idTextFieldController.text;
    String pw = pageViewModel.passwordTextFieldController.text;

    if (id.trim() == "") {
      // 이메일 미입력 처리
      // 입력창에 Focus 주기
      FocusScope.of(_context).requestFocus(pageViewModel.emailTextFieldFocus);
      showToast(
        "이메일을 입력하세요.",
        context: _context,
        animation: StyledToastAnimation.scale,
      );
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-zA-Z]{2,})$')
        .hasMatch(id)) {
      // 이메일 형식 맞지 않음

      // 입력창에 Focus 주기
      FocusScope.of(_context).requestFocus(pageViewModel.emailTextFieldFocus);
      showToast(
        "이메일 형식이 아닙니다.",
        context: _context,
        animation: StyledToastAnimation.scale,
      );
    } else if (pw.trim() == "") {
      // 이메일 미입력 처리
      // 입력창에 Focus 주기
      FocusScope.of(_context)
          .requestFocus(pageViewModel.passwordTextFieldFocus);
      showToast(
        "비밀번호를 입력하세요.",
        context: _context,
        animation: StyledToastAnimation.scale,
      );
    } else {
      accountLoginAsync();
    }
  }

////
// [내부 함수]
// !!!내부에서만 사용할 함수를 아래에 구현!!!
}

// (페이지 뷰 모델 클래스)
// 페이지 전역의 데이터는 여기에 정의되며, Business 인스턴스 안의 pageViewModel 변수로 저장 됩니다.
class PageViewModel {
  PageViewModel(this._context);

  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // 페이지 생명주기 관련 states
  final gc_template_classes.PageLifeCycleStates pageLifeCycleStates =
      gc_template_classes.PageLifeCycleStates();

  // 페이지 파라미터 (아래 goRouterState 에서 가져와 대입하기)
  late page_entrance.PageInputVo pageInputVo;

  // !!!페이지 데이터 정의!!!
  // ex :
  // int sampleNumber = 0;

  // PageOutFrameViewModel
  gw_page_outer_frame_business.WidgetBusiness pageOutFrameBusiness =
      gw_page_outer_frame_business.WidgetBusiness();

  bool hidePassword = true;

  TextEditingController idTextFieldController = TextEditingController();

  TextEditingController passwordTextFieldController = TextEditingController();

  FocusNode emailTextFieldFocus = FocusNode();
  FocusNode passwordTextFieldFocus = FocusNode();
}

// (BLoC 클래스)
// ex :
// class BlocSample extends Bloc<bool, bool> {
//   BlocSample() : super(true) {
//     on<bool>((event, emit) {
//       emit(event);
//     });
//   }
//
//   // BLoC 위젯 갱신 함수
//   void refresh() {
//     add(!state);
//   }
// }

class BlocPasswordTextField extends Bloc<bool, bool> {
  BlocPasswordTextField() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }

  // BLoC 위젯 갱신 함수
  void refresh() {
    add(!state);
  }
}

// (BLoC 프로바이더 클래스)
// 본 페이지에서 사용할 BLoC 객체를 모아두어 PageEntrance 에서 페이지 전역 설정에 사용 됩니다.
class BLocProviders {
// !!!이 페이지에서 사용할 "모든" BLoC 클래스들에 대한 Provider 객체들을 아래 리스트에 넣어줄 것!!!
  List<BlocProvider<dynamic>> blocProviders = [
    // ex :
    // BlocProvider<BlocSample>(create: (context) => BlocSample())
    BlocProvider<BlocPasswordTextField>(
        create: (context) => BlocPasswordTextField()),
  ];
}

class BLocObjects {
  BLocObjects(this._context) {
    // !!!BLoC 조작 객체 생성!!!
    // ex :
    // blocSample = BlocProvider.of<BlocSample>(_context);
    blocPasswordTextField = BlocProvider.of<BlocPasswordTextField>(_context);
  }

  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // !!!BLoC 조작 객체 변수 선언!!!
  // ex :
  // late BlocSample blocSample;
  late BlocPasswordTextField blocPasswordTextField;
}
