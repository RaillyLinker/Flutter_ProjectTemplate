// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:go_router/go_router.dart';

// (page)
import 'page_entrance.dart' as page_entrance;

// (all)
import '../../../global_widgets/gw_page_out_frames.dart' as gw_page_out_frames;
import '../../../../repositories/network/apis/api_main_server.dart'
    as api_main_server;
import '../../../dialogs/all/all_dialog_auth_join_the_membership_email_verification/page_entrance.dart'
    as all_dialog_auth_join_the_membership_email_verification;
import '../../../dialogs/all/all_dialog_info/page_entrance.dart'
    as all_dialog_info;
import '../../../dialogs/all/all_dialog_loading_spinner/page_entrance.dart'
    as all_dialog_loading_spinner;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../pages/all/all_page_join_the_membership_edit_member_info/page_entrance.dart'
    as all_page_join_the_membership_edit_member_info;
import '../../../../repositories/spws/spw_auth_member_info.dart'
    as spw_auth_member_info;
import '../../../global_functions/gf_my_functions.dart' as gf_my_functions;
import '../../../pages/all/all_page_home/page_entrance.dart' as all_page_home;

// [페이지 비즈니스 로직 및 뷰모델 작성 파일]

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 담당
// PageBusiness 인스턴스는 context 안에 저장되어, 해당 페이지가 소멸하기 전까지 활용됩니다.
class PageBusiness {
  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // BLoC 객체 모음
  late BLocObjects blocObjects;

  // 페이지 생명주기 관련 states
  var pageLifeCycleStates = gc_template_classes.PageLifeCycleStates();

  // 페이지 파라미터 (아래 goRouterState 에서 가져와 대입하기)
  late page_entrance.PageInputVo pageInputVo;

  // 페이지 뷰모델 객체
  PageViewModel pageViewModel = PageViewModel();

  // 생성자 설정
  PageBusiness(this._context);

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
    pageViewModel.emailTextEditController.dispose();
    pageViewModel.passwordTextFieldController.dispose();
    pageViewModel.passwordCheckTextFieldController.dispose();
    pageViewModel.emailTextEditFocus.dispose();
    pageViewModel.passwordTextFieldFocus.dispose();
    pageViewModel.passwordCheckTextFieldFocus.dispose();
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

  // (이메일 체크 버튼 클릭)
  void onEmailBtnClick() {
    if (pageViewModel.emailTextEditEnabled) {
      // 이메일 입력 활성화 상태 (= 아직 이메일 확인하지 않은 상태)
      sendVerificationEmail();
    } else {
      // 이메일 입력 비활성화 상태 (= 이메일 확인한 상태)
      pageViewModel.emailTextEditEnabled = true;
      pageViewModel.emailTextEditErrorMsg = null;
      blocObjects.blocEmailEditText.refresh();

      pageViewModel.emailCheckBtn = "이메일\n발송";
      blocObjects.blocEmailCheckBtn.refresh();
    }
  }

  // (인증 이메일 발송)
  bool isSendVerificationEmailClicked = false;

  void sendVerificationEmail() async {
    if (isSendVerificationEmailClicked) {
      return;
    }
    isSendVerificationEmailClicked = true;

    var email = pageViewModel.emailTextEditController.text.trim();
    if (email == "") {
      pageViewModel.emailTextEditErrorMsg = "이메일 주소를 입력하세요.";
      blocObjects.blocEmailEditText.refresh();
      isSendVerificationEmailClicked = false;
      FocusScope.of(_context).requestFocus(pageViewModel.emailTextEditFocus);
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-zA-Z]{2,})$')
        .hasMatch(pageViewModel.emailTextEditController.text)) {
      pageViewModel.emailTextEditErrorMsg = "올바른 이메일 형식이 아닙니다.";
      blocObjects.blocEmailEditText.refresh();
      isSendVerificationEmailClicked = false;
      FocusScope.of(_context).requestFocus(pageViewModel.emailTextEditFocus);
    } else {
      // 입력값 검증 완료
      // (로딩 스피너 다이얼로그 호출)
      var loadingSpinner = all_dialog_loading_spinner.PageEntrance(
          all_dialog_loading_spinner.PageInputVo(), (pageBusiness) async {
        var responseVo = await api_main_server
            .postService1TkV1AuthJoinTheMembershipEmailVerificationAsync(
                api_main_server
                    .PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncRequestBodyVo(
                        email));

        if (responseVo.dioException == null) {
          // Dio 네트워크 응답
          pageBusiness.closeDialog();
          var networkResponseObjectOk = responseVo.networkResponseObjectOk!;

          if (networkResponseObjectOk.responseStatusCode == 200) {
            var responseBody = networkResponseObjectOk.responseBody
                as api_main_server
                .PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncResponseBodyVo;

            // 정상 응답
            // 검증번호 입력 다이얼로그 띄우기
            if (!_context.mounted) return;
            all_dialog_auth_join_the_membership_email_verification.PageOutputVo?
                dialogResult = await showDialog(
                    barrierDismissible: false,
                    context: _context,
                    builder: (context) =>
                        all_dialog_auth_join_the_membership_email_verification
                            .PageEntrance(
                                all_dialog_auth_join_the_membership_email_verification
                                    .PageInputVo(
                                        email, responseBody.verificationUid),
                                (pageBusiness) {}));

            if (dialogResult != null) {
              pageViewModel.verificationUid = responseBody.verificationUid;
              pageViewModel.checkedEmailVerificationCode =
                  dialogResult.checkedVerificationCode;
              pageViewModel.emailTextEditEnabled = false;
              pageViewModel.emailTextEditErrorMsg = null;
              blocObjects.blocEmailEditText.refresh();

              pageViewModel.emailCheckBtn = "인증\n초기화";
              blocObjects.blocEmailCheckBtn.refresh();
            }
          } else {
            // 비정상 응답
            var responseHeaders = networkResponseObjectOk.responseHeaders!
                as api_main_server
                .PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncResponseHeaderVo;

            if (responseHeaders.apiResultCode == null) {
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
              String apiResultCode = responseHeaders.apiResultCode!;

              switch (apiResultCode) {
                case "1":
                  {
                    // 기존 회원 존재
                    if (!_context.mounted) return;
                    showDialog(
                        barrierDismissible: true,
                        context: _context,
                        builder: (context) => all_dialog_info.PageEntrance(
                            all_dialog_info.PageInputVo(
                                "인증 이메일 발송 실패", "이미 가입된 이메일입니다.", "확인"),
                            (pageBusiness) {}));
                  }
                  break;
                default:
                  {
                    // 알 수 없는 코드일 때
                    throw Exception("unKnown Error Code");
                  }
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

      isSendVerificationEmailClicked = false;
    }
  }

  // (이메일 텍스트 에디트 입력 변화)
  void emailTextEditOnChanged() {
    // 입력창의 에러를 지우기
    pageViewModel.emailTextEditErrorMsg = null;
    blocObjects.blocEmailEditText.refresh();
  }

  void passwordCheckTextEditOnChanged() {
    // 입력창의 에러를 지우기
    pageViewModel.passwordCheckTextEditErrorMsg = null;
    blocObjects.blocPasswordCheckTextField.refresh();
  }

  void passwordTextEditOnChanged() {
    // 입력창의 에러를 지우기
    pageViewModel.passwordTextEditErrorMsg = null;
    blocObjects.blocPasswordTextField.refresh();
  }

  // (패스워드 입력창에서 엔터를 친 경우)
  void onPasswordFieldSubmitted() {
    if (pageViewModel.passwordTextFieldController.text == "") {
      pageViewModel.passwordTextEditErrorMsg = "비밀번호를 입력하세요.";
      blocObjects.blocPasswordTextField.refresh();
      FocusScope.of(_context)
          .requestFocus(pageViewModel.passwordTextFieldFocus);
    } else if (pageViewModel.passwordTextFieldController.text.contains(" ")) {
      pageViewModel.passwordTextEditErrorMsg = "비밀번호에 공백은 허용되지 않습니다.";
      blocObjects.blocPasswordTextField.refresh();
      FocusScope.of(_context)
          .requestFocus(pageViewModel.passwordTextFieldFocus);
    } else if (pageViewModel.passwordTextFieldController.text.length < 8) {
      pageViewModel.passwordTextEditErrorMsg = "비밀번호는 최소 8자 이상 입력하세요.";
      blocObjects.blocPasswordTextField.refresh();
      FocusScope.of(_context)
          .requestFocus(pageViewModel.passwordTextFieldFocus);
    } else if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$&*])')
        .hasMatch(pageViewModel.passwordTextFieldController.text)) {
      pageViewModel.passwordTextEditErrorMsg =
          "비밀번호는 영문 대/소문자, 숫자, 그리고 특수문자의 조합을 입력하세요.";
      blocObjects.blocPasswordTextField.refresh();
      FocusScope.of(_context)
          .requestFocus(pageViewModel.passwordTextFieldFocus);
    } else if (RegExp(r'[<>()#’/|]')
        .hasMatch(pageViewModel.passwordTextFieldController.text)) {
      pageViewModel.passwordTextEditErrorMsg =
          "특수문자 < > ( ) # ’ / | 는 사용할 수 없습니다.";
      blocObjects.blocPasswordTextField.refresh();
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
    blocObjects.blocPasswordTextField.refresh();
  }

  void toggleHidePasswordCheck() {
    pageViewModel.hidePasswordCheck = !pageViewModel.hidePasswordCheck;
    blocObjects.blocPasswordCheckTextField.refresh();
  }

  void onPasswordCheckFieldSubmitted() {
    goToNextStep();
  }

  // (회원가입 다음 단계로 이동)
  Future<void> goToNextStep() async {
    pageViewModel.emailTextEditErrorMsg = null;
    blocObjects.blocEmailEditText.refresh();
    pageViewModel.passwordTextEditErrorMsg = null;
    blocObjects.blocPasswordTextField.refresh();
    pageViewModel.passwordCheckTextEditErrorMsg = null;
    blocObjects.blocPasswordCheckTextField.refresh();

    if (pageViewModel.checkedEmailVerificationCode == null) {
      pageViewModel.emailTextEditErrorMsg = "이메일 본인 인증이 필요합니다.";
      blocObjects.blocEmailEditText.refresh();
      FocusScope.of(_context).requestFocus(pageViewModel.emailTextEditFocus);
    } else if (pageViewModel.passwordTextFieldController.text == "") {
      pageViewModel.passwordTextEditErrorMsg = "비밀번호를 입력하세요.";
      blocObjects.blocPasswordTextField.refresh();
      FocusScope.of(_context)
          .requestFocus(pageViewModel.passwordTextFieldFocus);
    } else if (pageViewModel.passwordTextFieldController.text.contains(" ")) {
      pageViewModel.passwordTextEditErrorMsg = "비밀번호에 공백은 허용되지 않습니다.";
      blocObjects.blocPasswordTextField.refresh();
      FocusScope.of(_context)
          .requestFocus(pageViewModel.passwordTextFieldFocus);
    } else if (pageViewModel.passwordTextFieldController.text.length < 8) {
      pageViewModel.passwordTextEditErrorMsg = "비밀번호는 최소 8자 이상 입력하세요.";
      blocObjects.blocPasswordTextField.refresh();
      FocusScope.of(_context)
          .requestFocus(pageViewModel.passwordTextFieldFocus);
    } else if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$&*])')
        .hasMatch(pageViewModel.passwordTextFieldController.text)) {
      pageViewModel.passwordTextEditErrorMsg =
          "비밀번호는 영문 대/소문자, 숫자, 그리고 특수문자의 조합을 입력하세요.";
      blocObjects.blocPasswordTextField.refresh();
      FocusScope.of(_context)
          .requestFocus(pageViewModel.passwordTextFieldFocus);
    } else if (RegExp(r'[<>()#’/|]')
        .hasMatch(pageViewModel.passwordTextFieldController.text)) {
      pageViewModel.passwordTextEditErrorMsg =
          "특수문자 < > ( ) # ’ / | 는 사용할 수 없습니다.";
      blocObjects.blocPasswordTextField.refresh();
      FocusScope.of(_context)
          .requestFocus(pageViewModel.passwordTextFieldFocus);
    } else if (pageViewModel.passwordCheckTextFieldController.text == "") {
      pageViewModel.passwordCheckTextEditErrorMsg = "비밀번호 확인을 입력하세요.";
      blocObjects.blocPasswordCheckTextField.refresh();
      FocusScope.of(_context)
          .requestFocus(pageViewModel.passwordCheckTextFieldFocus);
    } else if (pageViewModel.passwordCheckTextFieldController.text !=
        pageViewModel.passwordTextFieldController.text) {
      pageViewModel.passwordCheckTextEditErrorMsg = "비밀번호와 일치하지 않습니다.";
      blocObjects.blocPasswordCheckTextField.refresh();
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
      var pageResult = await _context.pushNamed(
          all_page_join_the_membership_edit_member_info.pageName,
          queryParameters: {
            "memberId": pageViewModel.emailTextEditController.text.trim(),
            "password": pageViewModel.passwordTextFieldController.text,
            "verificationCode": pageViewModel.checkedEmailVerificationCode,
            "verificationUid": pageViewModel.verificationUid.toString(),
          });
      if (pageResult != null &&
          (pageResult
                  as all_page_join_the_membership_edit_member_info.PageOutputVo)
              .registerComplete) {
        if (!_context.mounted) return;
        _context.pop(page_entrance.PageOutputVo(true));
      }
    }
  }

  // 비밀번호 입력 규칙 클릭
  void onPasswordInputRuleTap() {
    pageViewModel.passwordInputRuleHide = !pageViewModel.passwordInputRuleHide;
    blocObjects.blocPasswordInputRule.refresh();
  }

////
// [내부 함수]
// !!!내부에서만 사용할 함수를 아래에 구현!!!
}

// (페이지 뷰 모델 클래스)
// 페이지 전역의 데이터는 여기에 정의되며, Business 인스턴스 안의 pageViewModel 변수로 저장 됩니다.
class PageViewModel {
  // 페이지 생명주기 관련 states
  var pageLifeCycleStates = gc_template_classes.PageLifeCycleStates();

  // 페이지 파라미터 (아래 goRouterState 에서 가져와 대입하기)
  late page_entrance.PageInputVo pageInputVo;

  // !!!페이지 데이터 정의!!!
  // ex :
  // int sampleNumber = 0;

  // 이메일 입력창 에러 메세지
  String? emailTextEditErrorMsg;

  String? passwordTextEditErrorMsg;

  String? passwordCheckTextEditErrorMsg;

  // 이메일 입력창 컨트롤러
  TextEditingController emailTextEditController = TextEditingController();

  TextEditingController passwordTextFieldController = TextEditingController();

  TextEditingController passwordCheckTextFieldController =
      TextEditingController();

  // 이메일 입력창 포커스
  FocusNode emailTextEditFocus = FocusNode();

  FocusNode passwordTextFieldFocus = FocusNode();

  FocusNode passwordCheckTextFieldFocus = FocusNode();

  bool emailTextEditEnabled = true;

  String? checkedEmailVerificationCode;

  String emailCheckBtn = "이메일\n발송";

  bool hidePassword = true;

  bool hidePasswordCheck = true;

  late int verificationUid;

  bool passwordInputRuleHide = true;

  PageViewModel();
}

// (BLoC 클래스)
// ex :
// class BlocSample extends Bloc<bool, bool> {
//   // BLoC 위젯 갱신 함수
//   void refresh() {
//     add(!state);
//   }
//
//   BlocSample() : super(true) {
//     on<bool>((event, emit) {
//       emit(event);
//     });
//   }
// }

class BlocEmailEditText extends Bloc<bool, bool> {
  // BLoC 위젯 갱신 함수
  void refresh() {
    add(!state);
  }

  BlocEmailEditText() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }
}

class BlocEmailCheckBtn extends Bloc<bool, bool> {
  // BLoC 위젯 갱신 함수
  void refresh() {
    add(!state);
  }

  BlocEmailCheckBtn() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }
}

class BlocPasswordTextField extends Bloc<bool, bool> {
  // BLoC 위젯 갱신 함수
  void refresh() {
    add(!state);
  }

  BlocPasswordTextField() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }
}

class BlocPasswordCheckTextField extends Bloc<bool, bool> {
  // BLoC 위젯 갱신 함수
  void refresh() {
    add(!state);
  }

  BlocPasswordCheckTextField() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }
}

class BlocPasswordInputRule extends Bloc<bool, bool> {
  // BLoC 위젯 갱신 함수
  void refresh() {
    add(!state);
  }

  BlocPasswordInputRule() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }
}

// (BLoC 프로바이더 클래스)
// 본 페이지에서 사용할 BLoC 객체를 모아두어 PageEntrance 에서 페이지 전역 설정에 사용 됩니다.
class BLocProviders {
// !!!이 페이지에서 사용할 "모든" BLoC 클래스들에 대한 Provider 객체들을 아래 리스트에 넣어줄 것!!!
  List<BlocProvider<dynamic>> blocProviders = [
    // ex :
    // BlocProvider<BlocSample>(create: (context) => BlocSample())
    BlocProvider<gw_page_out_frames.BlocHeaderGoToHomeIconBtn>(
        create: (context) => gw_page_out_frames.BlocHeaderGoToHomeIconBtn()),
    BlocProvider<BlocEmailEditText>(create: (context) => BlocEmailEditText()),
    BlocProvider<BlocEmailCheckBtn>(create: (context) => BlocEmailCheckBtn()),
    BlocProvider<BlocPasswordTextField>(
        create: (context) => BlocPasswordTextField()),
    BlocProvider<BlocPasswordCheckTextField>(
        create: (context) => BlocPasswordCheckTextField()),
    BlocProvider<BlocPasswordInputRule>(
        create: (context) => BlocPasswordInputRule()),
  ];
}

class BLocObjects {
  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // !!!BLoC 조작 객체 변수 선언!!!
  // ex :
  // late BlocSample blocSample;
  late BlocEmailEditText blocEmailEditText;
  late BlocEmailCheckBtn blocEmailCheckBtn;
  late BlocPasswordTextField blocPasswordTextField;
  late BlocPasswordCheckTextField blocPasswordCheckTextField;
  late BlocPasswordInputRule blocPasswordInputRule;

  // 생성자 설정
  BLocObjects(this._context) {
    // !!!BLoC 조작 객체 생성!!!
    // ex :
    // blocSample = BlocProvider.of<BlocSample>(_context);
    blocPasswordTextField = BlocProvider.of<BlocPasswordTextField>(_context);
    blocPasswordCheckTextField =
        BlocProvider.of<BlocPasswordCheckTextField>(_context);
    blocEmailEditText = BlocProvider.of<BlocEmailEditText>(_context);
    blocEmailCheckBtn = BlocProvider.of<BlocEmailCheckBtn>(_context);
    blocPasswordInputRule = BlocProvider.of<BlocPasswordInputRule>(_context);
  }
}
