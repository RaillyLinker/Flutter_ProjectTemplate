// (external)
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:go_router/go_router.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

// (page)
import 'page_entrance.dart' as page_entrance;

// (all)
import '../../../../repositories/network/apis/api_main_server.dart'
    as api_main_server;
import '../../../dialogs/all/all_dialog_auth_join_the_membership_select_member_profile_image_src/page_entrance.dart'
    as all_dialog_auth_join_the_membership_select_member_profile_image_src;
import '../../../dialogs/all/all_dialog_info/page_entrance.dart'
    as all_dialog_info;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../../repositories/spws/spw_auth_member_info.dart'
    as spw_auth_member_info;
import '../../../global_functions/gf_my_functions.dart' as gf_my_functions;

// [페이지 비즈니스 로직 및 뷰모델 작성 파일]
// todo : ios에서 테스트.

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

    if (!pageViewModel.goRouterState.uri.queryParameters
        .containsKey("memberId")) {
      showToast(
        "memberId 는 필수입니다.",
        context: _context,
        position: StyledToastPosition.center,
        animation: StyledToastAnimation.scale,
      );
      if (_context.canPop()) {
        // History가 있는 경우, 이전 페이지로 이동(pop)
        _context.pop();
      } else {
        // History가 없는 경우, 앱 종료(exit)
        exit(0);
      }
    }

    if (!pageViewModel.goRouterState.uri.queryParameters
        .containsKey("password")) {
      showToast(
        "password 는 필수입니다.",
        context: _context,
        position: StyledToastPosition.center,
        animation: StyledToastAnimation.scale,
      );
      if (_context.canPop()) {
        // History가 있는 경우, 이전 페이지로 이동(pop)
        _context.pop();
      } else {
        // History가 없는 경우, 앱 종료(exit)
        exit(0);
      }
    }

    if (!pageViewModel.goRouterState.uri.queryParameters
        .containsKey("verificationCode")) {
      showToast(
        "verificationCode 는 필수입니다.",
        context: _context,
        position: StyledToastPosition.center,
        animation: StyledToastAnimation.scale,
      );
      if (_context.canPop()) {
        // History가 있는 경우, 이전 페이지로 이동(pop)
        _context.pop();
      } else {
        // History가 없는 경우, 앱 종료(exit)
        exit(0);
      }
    }

    if (!pageViewModel.goRouterState.uri.queryParameters
        .containsKey("verificationUid")) {
      showToast(
        "verificationUid 는 필수입니다.",
        context: _context,
        position: StyledToastPosition.center,
        animation: StyledToastAnimation.scale,
      );
      if (_context.canPop()) {
        // History가 있는 경우, 이전 페이지로 이동(pop)
        _context.pop();
      } else {
        // History가 없는 경우, 앱 종료(exit)
        exit(0);
      }
    }

    // !!!pageViewModel.goRouterState 에서 PageInputVo 입력!!
    pageViewModel.pageInputVo = page_entrance.PageInputVo(
      pageViewModel.goRouterState.uri.queryParameters["memberId"]!,
      pageViewModel.goRouterState.uri.queryParameters["password"]!,
      pageViewModel.goRouterState.uri.queryParameters["verificationCode"]!,
      int.parse(
          pageViewModel.goRouterState.uri.queryParameters["verificationUid"]!),
    );
  }

  // (페이지 최초 실행 or 다른 페이지에서 복귀)
  Future<void> onPageResumeAsync() async {
    // !!!위젯 최초 실행 및, 다른 페이지에서 복귀 로직 작성!!

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
      _context.go("/");
      return;
    }
  }

  // (페이지 종료 or 다른 페이지로 이동 (강제 종료는 탐지 못함))
  Future<void> onPagePauseAsync() async {
    // !!!위젯 종료 및, 다른 페이지로 이동 로직 작성!!
  }

  // (페이지 종료 (강제 종료는 탐지 못함))
  Future<void> onPageDestroyAsync() async {
    // !!!페이지 종료 로직 작성!!
    pageViewModel.nickNameTextEditController.dispose();
    pageViewModel.nickNameTextEditFocus.dispose();
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

  // (닉네임 체크 버튼 클릭)
  bool onNickNameCheckBtnAsyncClicked = false;

  Future<void> onNickNameCheckBtnClickAsync() async {
    if (onNickNameCheckBtnAsyncClicked) {
      return;
    }
    onNickNameCheckBtnAsyncClicked = true;

    if (pageViewModel.nickNameCheckBtn == "중복\n확인") {
      // 중복 확인 버튼을 눌렀을 때
      // 입력창의 에러를 지우기
      pageViewModel.nickNameTextEditErrorMsg = null;
      blocObjects.blocNicknameEditText
          .add(!blocObjects.blocNicknameEditText.state);

      if (pageViewModel.nickNameTextEditController.text == "") {
        pageViewModel.nickNameTextEditErrorMsg = "닉네임을 입력하세요.";
        blocObjects.blocNicknameEditText
            .add(!blocObjects.blocNicknameEditText.state);
        FocusScope.of(_context)
            .requestFocus(pageViewModel.nickNameTextEditFocus);

        onNickNameCheckBtnAsyncClicked = false;
      } else if (pageViewModel.nickNameTextEditController.text.contains(" ")) {
        pageViewModel.nickNameTextEditErrorMsg = "닉네임에 공백은 허용되지 않습니다.";
        blocObjects.blocNicknameEditText
            .add(!blocObjects.blocNicknameEditText.state);
        FocusScope.of(_context)
            .requestFocus(pageViewModel.nickNameTextEditFocus);
        onNickNameCheckBtnAsyncClicked = false;
      } else if (pageViewModel.nickNameTextEditController.text.length < 2) {
        pageViewModel.nickNameTextEditErrorMsg = "닉네임은 최소 2자 이상 입력하세요.";
        blocObjects.blocNicknameEditText
            .add(!blocObjects.blocNicknameEditText.state);
        FocusScope.of(_context)
            .requestFocus(pageViewModel.nickNameTextEditFocus);
        onNickNameCheckBtnAsyncClicked = false;
      } else if (RegExp(r'[<>()#’/|]')
          .hasMatch(pageViewModel.nickNameTextEditController.text)) {
        pageViewModel.nickNameTextEditErrorMsg =
            "특수문자 < > ( ) # ’ / | 는 사용할 수 없습니다.";
        blocObjects.blocNicknameEditText
            .add(!blocObjects.blocNicknameEditText.state);
        FocusScope.of(_context)
            .requestFocus(pageViewModel.nickNameTextEditFocus);
        onNickNameCheckBtnAsyncClicked = false;
      } else {
        var responseVo = await api_main_server
            .getService1TkV1AuthNicknameDuplicateCheckAsync(api_main_server
                .GetService1TkV1AuthNicknameDuplicateCheckAsyncRequestQueryVo(
                    pageViewModel.nickNameTextEditController.text.trim()));

        if (responseVo.dioException == null) {
          // Dio 네트워크 응답
          var networkResponseObjectOk = responseVo.networkResponseObjectOk!;

          if (networkResponseObjectOk.responseStatusCode == 200) {
            var responseBody = networkResponseObjectOk.responseBody
                as api_main_server
                .GetService1TkV1AuthNicknameDuplicateCheckAsyncResponseBodyVo;

            if (responseBody.duplicated) {
              // 중복시 에러표시
              pageViewModel.nickNameTextEditErrorMsg = "이미 사용중인 닉네임입니다.";
              blocObjects.blocNicknameEditText
                  .add(!blocObjects.blocNicknameEditText.state);
            } else {
              // 중복이 아니라면 에딧 비활성화 및 버튼명 변경
              pageViewModel.nickNameTextEditEnabled = false;
              blocObjects.blocNicknameEditText
                  .add(!blocObjects.blocNicknameEditText.state);

              pageViewModel.nickNameCheckBtn = "재입력";
              blocObjects.blocNicknameCheckBtn
                  .add(!blocObjects.blocNicknameCheckBtn.state);
            }

            onNickNameCheckBtnAsyncClicked = false;
          } else {
            if (!_context.mounted) return;
            showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_info.PageEntrance(
                    all_dialog_info.PageInputVo(
                        "네트워크 에러", "네트워크 상태가 불안정합니다.\n다시 시도해주세요.", "확인"),
                    (pageBusiness) {}));

            onNickNameCheckBtnAsyncClicked = false;
          }
        } else {
          // Dio 네트워크 에러
          if (!_context.mounted) return;
          showDialog(
              barrierDismissible: true,
              context: _context,
              builder: (context) => all_dialog_info.PageEntrance(
                  all_dialog_info.PageInputVo(
                      "네트워크 에러", "네트워크 상태가 불안정합니다.\n다시 시도해주세요.", "확인"),
                  (pageBusiness) {}));

          onNickNameCheckBtnAsyncClicked = false;
        }
      }
    } else {
      // 다시 입력 버튼을 눌렀을 때
      pageViewModel.nickNameTextEditEnabled = true;
      blocObjects.blocNicknameEditText
          .add(!blocObjects.blocNicknameEditText.state);

      pageViewModel.nickNameCheckBtn = "중복\n확인";
      blocObjects.blocNicknameCheckBtn
          .add(!blocObjects.blocNicknameCheckBtn.state);

      onNickNameCheckBtnAsyncClicked = false;
    }
  }

  // (회원가입 버튼 클릭)
  bool onRegisterBtnClickClicked = false;

  Future<void> onRegisterBtnClick() async {
    if (onRegisterBtnClickClicked) {
      return;
    }
    onRegisterBtnClickClicked = true;

    if (pageViewModel.nickNameCheckBtn == "중복\n확인") {
      // 아직 닉네임 검증되지 않았을 때
      // 입력창에 Focus 주기
      FocusScope.of(_context).requestFocus(pageViewModel.nickNameTextEditFocus);

      pageViewModel.nickNameTextEditErrorMsg = "닉네임 중복 확인이 필요합니다.";
      blocObjects.blocNicknameEditText
          .add(!blocObjects.blocNicknameEditText.state);

      onRegisterBtnClickClicked = false;
    } else {
      // 회원가입 절차 진행
      var responseVo = await api_main_server
          .postService1TkV1AuthJoinTheMembershipWithEmailAsync(api_main_server
              .PostService1TkV1AuthJoinTheMembershipWithEmailAsyncRequestBodyVo(
        pageViewModel.pageInputVo.verificationUid,
        pageViewModel.pageInputVo.memberId,
        pageViewModel.pageInputVo.password,
        pageViewModel.nickNameTextEditController.text.trim(),
        pageViewModel.pageInputVo.verificationCode,
        pageViewModel.profileImage == null
            ? null
            : dio.MultipartFile.fromBytes(pageViewModel.profileImage!,
                filename: "profile.png",
                contentType: MediaType('image', "png")),
      ));

      if (responseVo.dioException == null) {
        // Dio 네트워크 응답
        var networkResponseObjectOk = responseVo.networkResponseObjectOk!;

        if (networkResponseObjectOk.responseStatusCode == 200) {
          // 정상 응답
          // 로그인 네트워크 요청
          if (!_context.mounted) return;
          await showDialog(
              barrierDismissible: true,
              context: _context,
              builder: (context) => all_dialog_info.PageEntrance(
                  all_dialog_info.PageInputVo(
                      "회원가입 완료", "회원가입이 완료되었습니다.\n환영합니다.", "확인"),
                  (pageBusiness) {}));

          onRegisterBtnClickClicked = false;
          if (!_context.mounted) return;
          _context.pop(page_entrance.PageOutputVo(true));
        } else {
          // 비정상 응답
          var responseHeaders = networkResponseObjectOk.responseHeaders
              as api_main_server
              .PostService1TkV1AuthJoinTheMembershipWithEmailAsyncResponseHeaderVo;

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
            onRegisterBtnClickClicked = false;
          } else {
            // 서버 지정 에러 코드를 전달 받았을 때
            String apiResultCode = responseHeaders.apiResultCode!;

            switch (apiResultCode) {
              case "1":
                {
                  // 이메일 검증 요청을 보낸 적 없음
                  if (!_context.mounted) return;
                  await showDialog(
                      barrierDismissible: true,
                      context: _context,
                      builder: (context) => all_dialog_info.PageEntrance(
                          all_dialog_info.PageInputVo("회원가입 실패",
                              "본인 인증 요청 정보가 없습니다.\n다시 인증해주세요.", "확인"),
                          (pageBusiness) {}));

                  onRegisterBtnClickClicked = false;
                  if (!_context.mounted) return;
                  _context.pop();
                }
                break;
              case "2":
                {
                  // 이메일 검증 요청이 만료됨
                  if (!_context.mounted) return;
                  await showDialog(
                      barrierDismissible: true,
                      context: _context,
                      builder: (context) => all_dialog_info.PageEntrance(
                          all_dialog_info.PageInputVo("회원가입 실패",
                              "본인 인증 요청 정보가 만료되었습니다.\n다시 인증해주세요.", "확인"),
                          (pageBusiness) {}));

                  onRegisterBtnClickClicked = false;
                  if (!_context.mounted) return;
                  _context.pop();
                }
                break;
              case "3":
                {
                  // verificationCode 가 일치하지 않음
                  if (!_context.mounted) return;
                  await showDialog(
                      barrierDismissible: true,
                      context: _context,
                      builder: (context) => all_dialog_info.PageEntrance(
                          all_dialog_info.PageInputVo("회원가입 실패",
                              "본인 인증 요청 정보가 만료되었습니다.\n다시 인증해주세요.", "확인"),
                          (pageBusiness) {}));

                  onRegisterBtnClickClicked = false;
                  if (!_context.mounted) return;
                  _context.pop();
                }
                break;
              case "4":
                {
                  // 이미 가입된 회원이 있습니다.
                  if (!_context.mounted) return;
                  await showDialog(
                      barrierDismissible: true,
                      context: _context,
                      builder: (context) => all_dialog_info.PageEntrance(
                          all_dialog_info.PageInputVo(
                              "회원가입 실패", "이미 가입된 회원 정보입니다.", "확인"),
                          (pageBusiness) {}));

                  onRegisterBtnClickClicked = false;
                  if (!_context.mounted) return;
                  _context.pop();
                }
                break;
              case "5":
                {
                  // 이미 사용중인 닉네임
                  pageViewModel.nickNameTextEditErrorMsg = "이미 사용중인 닉네임입니다.";
                  blocObjects.blocNicknameEditText
                      .add(!blocObjects.blocNicknameEditText.state);
                  pageViewModel.nickNameCheckBtn = "중복\n확인";
                  blocObjects.blocNicknameCheckBtn
                      .add(!blocObjects.blocNicknameCheckBtn.state);
                  onRegisterBtnClickClicked = false;
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
        // Dio 네트워크 에러
        if (!_context.mounted) return;
        showDialog(
            barrierDismissible: true,
            context: _context,
            builder: (context) => all_dialog_info.PageEntrance(
                all_dialog_info.PageInputVo(
                    "네트워크 에러", "네트워크 상태가 불안정합니다.\n다시 시도해주세요.", "확인"),
                (pageBusiness) {}));
        onRegisterBtnClickClicked = false;
      }
    }
  }

  // (닉네임 텍스트 에디트 입력 변화)
  void nickNameTextEditOnChanged() {
    // 입력창의 에러를 지우기
    pageViewModel.nickNameTextEditErrorMsg = null;
    blocObjects.blocNicknameEditText
        .add(!blocObjects.blocNicknameEditText.state);
  }

  // 닉네임 입력 규칙 클릭
  void onNicknameInputRuleTap() {
    pageViewModel.nicknameInputRuleHide = !pageViewModel.nicknameInputRuleHide;
    blocObjects.blocNicknameInputRule
        .add(!blocObjects.blocNicknameInputRule.state);
  }

  // 프로필 이미지 클릭
  Future<void> onProfileImageTap() async {
    if (!_context.mounted) return;
    all_dialog_auth_join_the_membership_select_member_profile_image_src
        .PageOutputVo? pageOutputVo = await showDialog(
            barrierDismissible: true,
            context: _context,
            builder: (context) =>
                all_dialog_auth_join_the_membership_select_member_profile_image_src
                    .PageEntrance(
                        all_dialog_auth_join_the_membership_select_member_profile_image_src
                            .PageInputVo(
                                // 카메라는 모바일 환경에서만
                                !kIsWeb &&
                                    (Platform.isAndroid || Platform.isIOS)),
                        (pageBusiness) {}));

    if (pageOutputVo != null) {
      switch (pageOutputVo.imageSourceType) {
        case all_dialog_auth_join_the_membership_select_member_profile_image_src
              .ImageSourceType.gallery:
          {
            // 갤러리에서 선택하기
            try {
              final XFile? pickedFile = await pageViewModel.imagePicker
                  .pickImage(
                      source: ImageSource.gallery,
                      maxHeight: 1280,
                      maxWidth: 1280,
                      imageQuality: 70);
              if (pickedFile != null) {
                // JPG or PNG
                var image = XFile(pickedFile.path);
                var bytes = await image.readAsBytes();
                pageViewModel.profileImage = bytes;
                blocObjects.blocProfileImage
                    .add(!blocObjects.blocProfileImage.state);
              }
            } catch (_) {}
          }
          break;
        case all_dialog_auth_join_the_membership_select_member_profile_image_src
              .ImageSourceType.camera:
          {
            // 사진 찍기
            try {
              final XFile? pickedFile = await pageViewModel.imagePicker
                  .pickImage(
                      source: ImageSource.camera,
                      maxHeight: 1280,
                      maxWidth: 1280,
                      imageQuality: 70);
              if (pickedFile != null) {
                // JPG or PNG
                var image = XFile(pickedFile.path);
                var bytes = await image.readAsBytes();
                pageViewModel.profileImage = bytes;
                blocObjects.blocProfileImage
                    .add(!blocObjects.blocProfileImage.state);
              }
            } catch (_) {}
          }
          break;
        case all_dialog_auth_join_the_membership_select_member_profile_image_src
              .ImageSourceType.defaultImage:
          {
            // 기본 프로필 이미지 적용
            pageViewModel.profileImage = null;
            blocObjects.blocProfileImage
                .add(!blocObjects.blocProfileImage.state);
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

  // 이미지 선택자
  ImagePicker imagePicker = ImagePicker();

  // 닉네임 체크 버튼명 (중복 확인 or 다시 입력)
  String nickNameCheckBtn = "중복\n확인";

  // 닉네임 입력창 에러 메세지
  String? nickNameTextEditErrorMsg;

  // 닉네임 입력창 활성화 여부
  bool nickNameTextEditEnabled = true;

  // 닉네임 입력창 컨트롤러
  TextEditingController nickNameTextEditController = TextEditingController();

  // 닉네임 입력창 포커스
  FocusNode nickNameTextEditFocus = FocusNode();

  bool nicknameInputRuleHide = true;

  Uint8List? profileImage;

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

// (닉네임 텍스트 에딧)
class BlocNicknameEditText extends Bloc<bool, bool> {
  BlocNicknameEditText() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }
}

// (중복 확인 버튼)
class BlocNicknameCheckBtn extends Bloc<bool, bool> {
  BlocNicknameCheckBtn() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }
}

class BlocNicknameInputRule extends Bloc<bool, bool> {
  BlocNicknameInputRule() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }
}

class BlocProfileImage extends Bloc<bool, bool> {
  BlocProfileImage() : super(true) {
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
    BlocProvider<BlocNicknameEditText>(
        create: (context) => BlocNicknameEditText()),
    BlocProvider<BlocNicknameCheckBtn>(
        create: (context) => BlocNicknameCheckBtn()),
    BlocProvider<BlocNicknameInputRule>(
        create: (context) => BlocNicknameInputRule()),
    BlocProvider<BlocProfileImage>(create: (context) => BlocProfileImage()),
  ];
}

class BLocObjects {
  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // !!!BLoC 조작 객체 변수 선언!!
  // ex :
  // late BlocSample blocSample;
  late BlocNicknameEditText blocNicknameEditText;
  late BlocNicknameCheckBtn blocNicknameCheckBtn;
  late BlocNicknameInputRule blocNicknameInputRule;
  late BlocProfileImage blocProfileImage;

  // 생성자 설정
  BLocObjects(this._context) {
    // !!!BLoC 조작 객체 생성!!
    // ex :
    // blocSample = BlocProvider.of<BlocSample>(_context);
    blocNicknameEditText = BlocProvider.of<BlocNicknameEditText>(_context);
    blocNicknameCheckBtn = BlocProvider.of<BlocNicknameCheckBtn>(_context);
    blocNicknameInputRule = BlocProvider.of<BlocNicknameInputRule>(_context);
    blocProfileImage = BlocProvider.of<BlocProfileImage>(_context);
  }
}
