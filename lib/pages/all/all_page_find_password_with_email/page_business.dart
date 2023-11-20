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
import '../../../dialogs/all/all_dialog_info/page_entrance.dart'
    as all_dialog_info;
import '../../../dialogs/all/all_dialog_loading_spinner/page_entrance.dart'
    as all_dialog_loading_spinner;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../../repositories/spws/spw_auth_member_info.dart'
    as spw_auth_member_info;
import '../../../global_functions/gf_my_functions.dart' as gf_my_functions;
import '../../../pages/all/all_page_home/page_entrance.dart' as all_page_home;

// [페이지 비즈니스 로직 및 뷰모델 작성 파일]
// todo : 입력 부분 Form 방식 변경
// todo : 템플릿 적용

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
    pageViewModel.emailTextEditController.dispose();
    pageViewModel.verificationCodeTextFieldController.dispose();
    pageViewModel.emailTextEditFocus.dispose();
    pageViewModel.verificationCodeTextFieldFocus.dispose();
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
        all_dialog_loading_spinner.PageInputVo(),
      );

      showDialog(
          barrierDismissible: false,
          context: _context,
          builder: (context) => loadingSpinner).then((outputVo) {});

      // 비번 찾기 검증 요청
      var responseVo = await api_main_server
          .postService1TkV1AuthFindPasswordEmailVerificationAsync(
              requestBodyVo: api_main_server
                  .PostService1TkV1AuthFindPasswordEmailVerificationAsyncRequestBodyVo(
                      email: email));

      if (responseVo.dioException == null) {
        // Dio 네트워크 응답
        loadingSpinner.pageBusiness.closeDialog();
        var networkResponseObjectOk = responseVo.networkResponseObjectOk!;

        if (networkResponseObjectOk.responseStatusCode == 200) {
          var networkResponseObjectBody = networkResponseObjectOk.responseBody
              as api_main_server
              .PostService1TkV1AuthFindPasswordEmailVerificationAsyncResponseBodyVo;

          // 정상 응답
          pageViewModel.emailTextEditErrorMsg = null;
          blocObjects.blocEmailEditText.refresh();

          pageViewModel.emailVerificationUid =
              networkResponseObjectBody.verificationUid;

          if (!_context.mounted) return;
          showToast(
            "본인 인증 이메일 발송 완료",
            context: _context,
            position: StyledToastPosition.bottom,
            animation: StyledToastAnimation.scale,
          );
        } else {
          // 비정상 응답
          var responseHeaders = networkResponseObjectOk.responseHeaders!
              as api_main_server
              .PostService1TkV1AuthFindPasswordEmailVerificationAsyncResponseHeaderVo;

          if (responseHeaders.apiResultCode == null) {
            // 비정상 응답이면서 서버에서 에러 원인 코드가 전달되지 않았을 때
            if (!_context.mounted) return;
            showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_info.PageEntrance(
                      all_dialog_info.PageInputVo(
                          "네트워크 에러", "네트워크 상태가 불안정합니다.\n다시 시도해주세요.", "확인"),
                    ));
          } else {
            // 서버 지정 에러 코드를 전달 받았을 때
            String apiResultCode = responseHeaders.apiResultCode!;

            switch (apiResultCode) {
              case "1":
                {
                  // 가입되지 않은 회원
                  if (!_context.mounted) return;
                  showDialog(
                      barrierDismissible: true,
                      context: _context,
                      builder: (context) => all_dialog_info.PageEntrance(
                            all_dialog_info.PageInputVo(
                                "인증 이메일 발송 실패", "가입되지 않은 이메일입니다.", "확인"),
                          ));
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
        loadingSpinner.pageBusiness.closeDialog();
        if (!_context.mounted) return;
        showDialog(
            barrierDismissible: true,
            context: _context,
            builder: (context) => all_dialog_info.PageEntrance(
                  all_dialog_info.PageInputVo(
                      "네트워크 에러", "네트워크 상태가 불안정합니다.\n다시 시도해주세요.", "확인"),
                ));
      }

      isSendVerificationEmailClicked = false;
    }
  }

  // (이메일 텍스트 에디트 입력 변화)
  void emailTextEditOnChanged() {
    // 입력창의 에러를 지우기
    pageViewModel.emailTextEditErrorMsg = null;
    blocObjects.blocEmailEditText.refresh();
  }

  void verificationCodeTextEditOnChanged() {
    // 입력창의 에러를 지우기
    pageViewModel.verificationCodeTextEditErrorMsg = null;
    blocObjects.blocVerificationCodeTextField.refresh();
  }

  // (검증 코드 입력창에서 엔터를 친 경우)
  void onVerificationCodeFieldSubmitted() {
    if (pageViewModel.verificationCodeTextFieldController.text.trim() == "") {
      pageViewModel.verificationCodeTextEditErrorMsg = "본인 인증 코드를 입력하세요.";
      blocObjects.blocVerificationCodeTextField.refresh();
      FocusScope.of(_context)
          .requestFocus(pageViewModel.verificationCodeTextFieldFocus);
    } else {
      findPassword();
    }
  }

  // (비밀번호 찾기)
  Future<void> findPassword() async {
    pageViewModel.emailTextEditErrorMsg = null;
    blocObjects.blocEmailEditText.refresh();
    pageViewModel.verificationCodeTextEditErrorMsg = null;
    blocObjects.blocVerificationCodeTextField.refresh();

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
    } else if (pageViewModel.verificationCodeTextFieldController.text.trim() ==
        "") {
      pageViewModel.verificationCodeTextEditErrorMsg = "본인 인증 코드를 입력하세요.";
      blocObjects.blocVerificationCodeTextField.refresh();
      FocusScope.of(_context)
          .requestFocus(pageViewModel.verificationCodeTextFieldFocus);
    } else {
      // 비밀번호 변경 요청 후 처리
      // 입력값 검증 완료
      // (로딩 스피너 다이얼로그 호출)
      var loadingSpinner = all_dialog_loading_spinner.PageEntrance(
        all_dialog_loading_spinner.PageInputVo(),
      );

      showDialog(
          barrierDismissible: false,
          context: _context,
          builder: (context) => loadingSpinner).then((outputVo) {});

      // 비번 찾기 검증 요청
      var responseVo =
          await api_main_server.postService1TkV1AuthFindPasswordWithEmailAsync(
              requestBodyVo: api_main_server
                  .PostService1TkV1AuthFindPasswordWithEmailAsyncRequestBodyVo(
                      email: email,
                      verificationUid: pageViewModel.emailVerificationUid!,
                      verificationCode: pageViewModel
                          .verificationCodeTextFieldController.text));

      if (responseVo.dioException == null) {
        // Dio 네트워크 응답
        loadingSpinner.pageBusiness.closeDialog();
        var networkResponseObjectOk = responseVo.networkResponseObjectOk!;

        if (networkResponseObjectOk.responseStatusCode == 200) {
          // 정상 응답
          pageViewModel.emailTextEditErrorMsg = null;
          blocObjects.blocEmailEditText.refresh();

          if (!_context.mounted) return;
          await showDialog(
              barrierDismissible: true,
              context: _context,
              builder: (context) => all_dialog_info.PageEntrance(
                    all_dialog_info.PageInputVo(
                        "비밀번호 찾기 완료",
                        "새로운 비밀번호가\n"
                            "이메일로 전송되었습니다.\n"
                            "($email)",
                        "확인"),
                  ));

          if (!_context.mounted) return;
          _context.pop(page_entrance.PageOutputVo(true));
        } else {
          // 비정상 응답
          var responseHeaders = networkResponseObjectOk.responseHeaders!
              as api_main_server
              .PostService1TkV1AuthFindPasswordWithEmailAsyncResponseHeaderVo;

          if (responseHeaders.apiResultCode == null) {
            // 비정상 응답이면서 서버에서 에러 원인 코드가 전달되지 않았을 때
            if (!_context.mounted) return;
            showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_info.PageEntrance(
                      all_dialog_info.PageInputVo(
                          "네트워크 에러", "네트워크 상태가 불안정합니다.\n다시 시도해주세요.", "확인"),
                    ));
          } else {
            // 서버 지정 에러 코드를 전달 받았을 때
            String apiResultCode = responseHeaders.apiResultCode!;

            switch (apiResultCode) {
              case "1":
                {
                  // 이메일 검증 요청을 보낸 적 없음
                  if (!_context.mounted) return;
                  showDialog(
                      barrierDismissible: true,
                      context: _context,
                      builder: (context) => all_dialog_info.PageEntrance(
                            all_dialog_info.PageInputVo(
                                "비밀번호 찾기 실패",
                                "이메일 검증 요청을 보내지 않았습니다.\n"
                                    "이메일 발송 버튼을 누르세요.",
                                "확인"),
                          ));
                }
                break;
              case "2":
                {
                  // 이메일 검증 요청이 만료됨
                  if (!_context.mounted) return;
                  showDialog(
                      barrierDismissible: true,
                      context: _context,
                      builder: (context) => all_dialog_info.PageEntrance(
                            all_dialog_info.PageInputVo(
                                "비밀번호 찾기 실패", "이메일 검증 요청이 만료되었습니다.", "확인"),
                          ));
                }
                break;
              case "3":
                {
                  // verificationCode 가 일치하지 않음
                  if (!_context.mounted) return;
                  showDialog(
                      barrierDismissible: true,
                      context: _context,
                      builder: (context) => all_dialog_info.PageEntrance(
                            all_dialog_info.PageInputVo(
                                "비밀번호 찾기 실패", "본인 인증 코드가 일치하지 않습니다.", "확인"),
                          ));
                }
                break;
              case "4":
                {
                  // 탈퇴한 회원입니다.
                  if (!_context.mounted) return;
                  showDialog(
                      barrierDismissible: true,
                      context: _context,
                      builder: (context) => all_dialog_info.PageEntrance(
                            all_dialog_info.PageInputVo(
                                "비밀번호 찾기 실패", "탈퇴된 이메일입니다.", "확인"),
                          ));
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
        loadingSpinner.pageBusiness.closeDialog();
        if (!_context.mounted) return;
        showDialog(
            barrierDismissible: true,
            context: _context,
            builder: (context) => all_dialog_info.PageEntrance(
                  all_dialog_info.PageInputVo(
                      "네트워크 에러", "네트워크 상태가 불안정합니다.\n다시 시도해주세요.", "확인"),
                ));
      }
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
  gw_page_out_frames.PageOutFrameBusiness pageOutFrameBusiness =
      gw_page_out_frames.PageOutFrameBusiness(pageTitle: "비밀번호 찾기");

  // 이메일 입력창 에러 메세지
  String? emailTextEditErrorMsg;

  String? verificationCodeTextEditErrorMsg;

  // 이메일 입력창 컨트롤러
  TextEditingController emailTextEditController = TextEditingController();

  TextEditingController verificationCodeTextFieldController =
      TextEditingController();

  // 이메일 입력창 포커스
  FocusNode emailTextEditFocus = FocusNode();

  FocusNode verificationCodeTextFieldFocus = FocusNode();

  // 검증 고유값
  int? emailVerificationUid;
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

class BlocEmailEditText extends Bloc<bool, bool> {
  BlocEmailEditText() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }

  // BLoC 위젯 갱신 함수
  void refresh() {
    add(!state);
  }
}

class BlocVerificationCodeTextField extends Bloc<bool, bool> {
  BlocVerificationCodeTextField() : super(true) {
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
    BlocProvider<BlocEmailEditText>(create: (context) => BlocEmailEditText()),
    BlocProvider<BlocVerificationCodeTextField>(
        create: (context) => BlocVerificationCodeTextField()),
  ];
}

class BLocObjects {
  BLocObjects(this._context) {
    // !!!BLoC 조작 객체 생성!!!
    // ex :
    // blocSample = BlocProvider.of<BlocSample>(_context);
    blocVerificationCodeTextField =
        BlocProvider.of<BlocVerificationCodeTextField>(_context);
    blocEmailEditText = BlocProvider.of<BlocEmailEditText>(_context);
  }

  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // !!!BLoC 조작 객체 변수 선언!!!
  // ex :
  // late BlocSample blocSample;
  late BlocEmailEditText blocEmailEditText;
  late BlocVerificationCodeTextField blocVerificationCodeTextField;
}
