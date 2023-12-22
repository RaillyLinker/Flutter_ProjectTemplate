// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

// (inner_folder)
import 'main_widget.dart' as main_widget;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/global_widgets/gw_sfw_wrapper.dart'
    as gw_sfw_wrapper;
import 'package:flutter_project_template/repositories/network/apis/api_main_server.dart'
    as api_main_server;
import 'package:flutter_project_template/dialogs/all/all_dialog_image_selector_menu/main_widget.dart'
    as all_dialog_image_selector_menu;
import 'package:flutter_project_template/dialogs/all/all_dialog_info/main_widget.dart'
    as all_dialog_info;
import 'package:flutter_project_template/repositories/spws/spw_auth_member_info.dart'
    as spw_auth_member_info;
import 'package:flutter_project_template/global_functions/gf_my_functions.dart'
    as gf_my_functions;
import 'package:flutter_project_template/pages/all/all_page_home/main_widget.dart'
    as all_page_home;

// [위젯 비즈니스]

//------------------------------------------------------------------------------
class MainBusiness {
  // [CallBack 함수]
  // (inputVo 확인 콜백)
  // State 클래스의 initState 에서 실행 되며, Business 클래스의 initState 실행 전에 실행 됩니다.
  // 필수 정보 누락시 null 을 반환, null 이 반환 되었을 때는 inputError 가 true 가 됩니다.
  main_widget.InputVo? onCheckPageInputVo(
      {required GoRouterState goRouterState}) {
    // !!!pageInputVo 체크!!!
    // ex :
    // if (!goRouterState.uri.queryParameters.containsKey("inputValueString")) {
    //   return null;
    // }

    if (!goRouterState.uri.queryParameters.containsKey("memberId")) {
      return null;
    }
    if (!goRouterState.uri.queryParameters.containsKey("password")) {
      return null;
    }
    if (!goRouterState.uri.queryParameters.containsKey("verificationCode")) {
      return null;
    }
    if (!goRouterState.uri.queryParameters.containsKey("verificationUid")) {
      return null;
    }

    // !!!PageInputVo 입력!!!
    return main_widget.InputVo(
      memberId: goRouterState.uri.queryParameters["memberId"]!,
      password: goRouterState.uri.queryParameters["password"]!,
      verificationCode: goRouterState.uri.queryParameters["verificationCode"]!,
      verificationUid:
          int.parse(goRouterState.uri.queryParameters["verificationUid"]!),
    );
  }

  // (진입 최초 단 한번 실행) - 아직 위젯이 생성 되기 전
  void initState() {
    // !!!initState 로직 작성!!!
  }

  // (종료 시점 단 한번 실행)
  void dispose() {
    // !!!dispose 로직 작성!!!
    nickNameTextFieldController.dispose();
    nickNameTextFieldFocus.dispose();
  }

  // (최초 실행시 단 한번 실행) - 위젯 build 바로 직전, 모든 것이 준비 되었을 때
  void onCreate() {
    // !!!onCreate 로직 작성!!!
  }

  Future<void> onFocusGainedAsync() async {
    // !!!onFocusGainedAsync 로직 작성!!!

    // 검증된 현재 회원 정보 가져오기 (비회원이라면 null)
    spw_auth_member_info.SharedPreferenceWrapperVo? nowLoginMemberInfo =
        gf_my_functions.getNowVerifiedMemberInfo();

    if (nowLoginMemberInfo != null) {
      // 로그인 상태라면 진입금지
      showToast(
        "잘못된 진입입니다.",
        context: mainContext,
        animation: StyledToastAnimation.scale,
      );
      // 홈 페이지로 이동
      mainContext.goNamed(all_page_home.pageName);
      return;
    }
  }

  Future<void> onFocusLostAsync() async {
    // !!!onFocusLostAsync 로직 작성!!!
  }

  Future<void> onVisibilityGainedAsync() async {
    // !!!onVisibilityGainedAsync 로직 작성!!!
  }

  Future<void> onVisibilityLostAsync() async {
    // !!!onVisibilityLostAsync 로직 작성!!!
  }

  Future<void> onForegroundGainedAsync() async {
    // !!!onForegroundGainedAsync 로직 작성!!!
  }

  Future<void> onForegroundLostAsync() async {
    // !!!onForegroundLostAsync 로직 작성!!!
  }

  //----------------------------------------------------------------------------
  // !!!메인 위젯에서 사용할 변수는 이곳에서 저장하여 사용하세요.!!!
  // [public 변수]
  // (위젯 입력값)
  late main_widget.InputVo inputVo;

  // (페이지 pop 가능 여부 변수) - false 로 설정시 pop 불가
  bool canPop = true;

  // (입력값 미충족 여부)
  bool inputError = false;

  // (context 객체)
  late BuildContext mainContext;

  // (최초 실행 플래그)
  bool pageInitFirst = true;

  // (pageOutFrameBusiness)
  final gw_slw_page_outer_frame.SlwPageOuterFrameBusiness pageOutFrameBusiness =
      gw_slw_page_outer_frame.SlwPageOuterFrameBusiness();

  // 이미지 선택자
  ImagePicker imagePicker = ImagePicker();

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> profileImageAreaGk =
      GlobalKey();
  late BuildContext profileImageContext;
  Uint8List? profileImage;

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState>
      nickNameTextFieldAreaGk = GlobalKey();
  late BuildContext nickNameTextFieldContext;
  final TextEditingController nickNameTextFieldController =
      TextEditingController();
  final FocusNode nickNameTextFieldFocus = FocusNode();
  String? nickNameTextFieldErrorMsg;
  bool nickNameTextEditEnabled = true;

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState>
      nickNameCheckBtnAreaGk = GlobalKey();
  late BuildContext nickNameCheckBtnContext;
  String nickNameCheckBtn = "중복\n확인";

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState>
      nicknameInputRuleHideAreaGk = GlobalKey();
  late BuildContext nicknameInputRuleHideContext;
  bool nicknameInputRuleHide = true;

  // [private 변수]

  //----------------------------------------------------------------------------
  // !!!비즈니스 함수는 이 곳에서 저장 하여 사용 하세요.!!!
  // [public 함수]
  // (메인 위젯 화면 갱신)
  late VoidCallback refreshUi;

  // 프로필 이미지 클릭
  Future<void> onProfileImageTap() async {
    final GlobalKey<all_dialog_image_selector_menu.MainWidgetState>
        allDialogImageSelectorMenuAreaGk = GlobalKey();
    if (!mainContext.mounted) return;
    var pageOutputVo = await showDialog(
        barrierDismissible: true,
        context: mainContext,
        builder: (context) => all_dialog_image_selector_menu.MainWidget(
              key: allDialogImageSelectorMenuAreaGk,
              inputVo: all_dialog_image_selector_menu.InputVo(
                onDialogCreated: () {},
              ),
            ));

    if (pageOutputVo != null) {
      switch (pageOutputVo.imageSourceType) {
        case all_dialog_image_selector_menu.ImageSourceType.gallery:
          {
            // 갤러리에서 선택하기
            try {
              final XFile? pickedFile = await imagePicker.pickImage(
                  source: ImageSource.gallery,
                  maxHeight: 1280,
                  maxWidth: 1280,
                  imageQuality: 70);
              if (pickedFile != null) {
                // todo 로딩
                // JPG or PNG
                var image = XFile(pickedFile.path);
                var bytes = await image.readAsBytes();
                profileImage = bytes;
                profileImageAreaGk.currentState?.refreshUi();
              }
            } catch (_) {}
          }
          break;
        case all_dialog_image_selector_menu.ImageSourceType.camera:
          {
            // 사진 찍기
            try {
              final XFile? pickedFile = await imagePicker.pickImage(
                  source: ImageSource.camera,
                  maxHeight: 1280,
                  maxWidth: 1280,
                  imageQuality: 70);
              if (pickedFile != null) {
                // JPG or PNG
                var image = XFile(pickedFile.path);
                var bytes = await image.readAsBytes();
                profileImage = bytes;
                profileImageAreaGk.currentState?.refreshUi();
              }
            } catch (_) {}
          }
          break;
        case all_dialog_image_selector_menu.ImageSourceType.defaultImage:
          {
            // 기본 프로필 이미지 적용
            profileImage = null;
            profileImageAreaGk.currentState?.refreshUi();
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

  // (닉네임 체크 버튼 클릭)
  bool onNickNameCheckBtnAsyncClicked = false;

  Future<void> onNickNameCheckBtnClickAsync() async {
    if (onNickNameCheckBtnAsyncClicked) {
      return;
    }
    onNickNameCheckBtnAsyncClicked = true;

    if (nickNameCheckBtn == "중복\n확인") {
      // 중복 확인 버튼을 눌렀을 때
      // 입력창의 에러를 지우기
      nickNameTextFieldErrorMsg = null;
      nickNameTextFieldAreaGk.currentState?.refreshUi();

      if (nickNameTextFieldController.text == "") {
        nickNameTextFieldErrorMsg = "닉네임을 입력하세요.";
        nickNameTextFieldAreaGk.currentState?.refreshUi();
        FocusScope.of(nickNameTextFieldContext)
            .requestFocus(nickNameTextFieldFocus);
        onNickNameCheckBtnAsyncClicked = false;
        return;
      }
      if (nickNameTextFieldController.text.contains(" ")) {
        nickNameTextFieldErrorMsg = "닉네임에 공백은 허용되지 않습니다.";
        nickNameTextFieldAreaGk.currentState?.refreshUi();
        FocusScope.of(nickNameTextFieldContext)
            .requestFocus(nickNameTextFieldFocus);
        onNickNameCheckBtnAsyncClicked = false;
        return;
      }
      if (nickNameTextFieldController.text.length < 2) {
        nickNameTextFieldErrorMsg = "닉네임은 최소 2자 이상 입력하세요.";
        nickNameTextFieldAreaGk.currentState?.refreshUi();
        FocusScope.of(nickNameTextFieldContext)
            .requestFocus(nickNameTextFieldFocus);
        onNickNameCheckBtnAsyncClicked = false;
        return;
      }
      if (RegExp(r'[<>()#’/|]').hasMatch(nickNameTextFieldController.text)) {
        nickNameTextFieldErrorMsg = "특수문자 < > ( ) # ’ / | 는 사용할 수 없습니다.";
        nickNameTextFieldAreaGk.currentState?.refreshUi();
        FocusScope.of(nickNameTextFieldContext)
            .requestFocus(nickNameTextFieldFocus);
        onNickNameCheckBtnAsyncClicked = false;
        return;
      }

      var responseVo =
          await api_main_server.getService1TkV1AuthNicknameDuplicateCheckAsync(
              requestQueryVo: api_main_server
                  .GetService1TkV1AuthNicknameDuplicateCheckAsyncRequestQueryVo(
                      nickName: nickNameTextFieldController.text.trim()));

      onNickNameCheckBtnAsyncClicked = false;
      if (responseVo.dioException == null) {
        // Dio 네트워크 응답
        var networkResponseObjectOk = responseVo.networkResponseObjectOk!;

        if (networkResponseObjectOk.responseStatusCode == 200) {
          var responseBody = networkResponseObjectOk.responseBody
              as api_main_server
              .GetService1TkV1AuthNicknameDuplicateCheckAsyncResponseBodyVo;

          if (responseBody.duplicated) {
            // 중복시 에러표시
            nickNameTextFieldErrorMsg = "이미 사용중인 닉네임입니다.";
            nickNameTextFieldAreaGk.currentState?.refreshUi();
            if (!nickNameTextFieldContext.mounted) return;
            FocusScope.of(nickNameTextFieldContext)
                .requestFocus(nickNameTextFieldFocus);
          } else {
            // 중복이 아니라면 에딧 비활성화 및 버튼명 변경
            nickNameTextEditEnabled = false;
            nickNameTextFieldAreaGk.currentState?.refreshUi();

            nickNameCheckBtn = "재입력";
            nickNameCheckBtnAreaGk.currentState?.refreshUi();
          }
        } else {
          final GlobalKey<all_dialog_info.MainWidgetState>
              allDialogInfoStateGk =
              GlobalKey<all_dialog_info.MainWidgetState>();
          if (!mainContext.mounted) return;
          showDialog(
              barrierDismissible: true,
              context: mainContext,
              builder: (context) => all_dialog_info.MainWidget(
                    key: allDialogInfoStateGk,
                    inputVo: all_dialog_info.InputVo(
                      dialogTitle: "네트워크 에러",
                      dialogContent: "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                      checkBtnTitle: "확인",
                      onDialogCreated: () {},
                    ),
                  ));
        }
      } else {
        // Dio 네트워크 에러
        final GlobalKey<all_dialog_info.MainWidgetState> allDialogInfoStateGk =
            GlobalKey<all_dialog_info.MainWidgetState>();
        if (!mainContext.mounted) return;
        showDialog(
            barrierDismissible: true,
            context: mainContext,
            builder: (context) => all_dialog_info.MainWidget(
                  key: allDialogInfoStateGk,
                  inputVo: all_dialog_info.InputVo(
                    dialogTitle: "네트워크 에러",
                    dialogContent: "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                    checkBtnTitle: "확인",
                    onDialogCreated: () {},
                  ),
                ));
      }
    } else {
      // 다시 입력 버튼을 눌렀을 때
      nickNameTextEditEnabled = true;
      nickNameTextFieldAreaGk.currentState?.refreshUi();

      nickNameCheckBtn = "중복\n확인";
      nickNameCheckBtnAreaGk.currentState?.refreshUi();
    }
  }

  // (회원가입 버튼 클릭)
  bool onRegisterBtnClickClicked = false;

  Future<void> onRegisterBtnClick() async {
    if (onRegisterBtnClickClicked) {
      return;
    }
    onRegisterBtnClickClicked = true;

    if (nickNameCheckBtn == "중복\n확인") {
      // 아직 닉네임 검증되지 않았을 때
      // 입력창에 Focus 주기

      nickNameTextFieldErrorMsg = "닉네임 중복 확인이 필요합니다.";
      nickNameTextFieldAreaGk.currentState?.refreshUi();

      onRegisterBtnClickClicked = false;
      FocusScope.of(nickNameTextFieldContext)
          .requestFocus(nickNameTextFieldFocus);
      return;
    }

    // todo 로딩 다이얼로그
    // 회원가입 절차 진행
    var responseVo = await api_main_server
        .postService1TkV1AuthJoinTheMembershipWithEmailAsync(
            requestBodyVo: api_main_server
                .PostService1TkV1AuthJoinTheMembershipWithEmailAsyncRequestBodyVo(
      verificationUid: inputVo.verificationUid,
      email: inputVo.memberId,
      password: inputVo.password,
      nickName: nickNameTextFieldController.text.trim(),
      verificationCode: inputVo.verificationCode,
      profileImageFile: profileImage == null
          ? null
          : dio.MultipartFile.fromBytes(profileImage!,
              filename: "profile.png", contentType: MediaType('image', "png")),
    ));

    if (responseVo.dioException == null) {
      // Dio 네트워크 응답
      var networkResponseObjectOk = responseVo.networkResponseObjectOk!;

      if (networkResponseObjectOk.responseStatusCode == 200) {
        // 정상 응답
        // 로그인 네트워크 요청
        final GlobalKey<all_dialog_info.MainWidgetState> allDialogInfoStateGk =
            GlobalKey<all_dialog_info.MainWidgetState>();
        if (!mainContext.mounted) return;
        await showDialog(
            barrierDismissible: true,
            context: mainContext,
            builder: (context) => all_dialog_info.MainWidget(
                  key: allDialogInfoStateGk,
                  inputVo: all_dialog_info.InputVo(
                    dialogTitle: "회원가입 완료",
                    dialogContent: "회원가입이 완료되었습니다.\n환영합니다.",
                    checkBtnTitle: "확인",
                    onDialogCreated: () {},
                  ),
                ));

        onRegisterBtnClickClicked = false;
        if (!mainContext.mounted) return;
        mainContext.pop(const main_widget.OutputVo(registerComplete: true));
      } else {
        // 비정상 응답
        var responseHeaders = networkResponseObjectOk.responseHeaders
            as api_main_server
            .PostService1TkV1AuthJoinTheMembershipWithEmailAsyncResponseHeaderVo;

        if (responseHeaders.apiResultCode == null) {
          // 비정상 응답이면서 서버에서 에러 원인 코드가 전달되지 않았을 때
          final GlobalKey<all_dialog_info.MainWidgetState>
              allDialogInfoStateGk =
              GlobalKey<all_dialog_info.MainWidgetState>();
          if (!mainContext.mounted) return;
          showDialog(
              barrierDismissible: true,
              context: mainContext,
              builder: (context) => all_dialog_info.MainWidget(
                    key: allDialogInfoStateGk,
                    inputVo: all_dialog_info.InputVo(
                      dialogTitle: "네트워크 에러",
                      dialogContent: "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                      checkBtnTitle: "확인",
                      onDialogCreated: () {},
                    ),
                  ));
          onRegisterBtnClickClicked = false;
        } else {
          // 서버 지정 에러 코드를 전달 받았을 때
          String apiResultCode = responseHeaders.apiResultCode!;

          switch (apiResultCode) {
            case "1":
              {
                // 이메일 검증 요청을 보낸 적 없음
                final GlobalKey<all_dialog_info.MainWidgetState>
                    allDialogInfoStateGk =
                    GlobalKey<all_dialog_info.MainWidgetState>();
                if (!mainContext.mounted) return;
                await showDialog(
                    barrierDismissible: true,
                    context: mainContext,
                    builder: (context) => all_dialog_info.MainWidget(
                          key: allDialogInfoStateGk,
                          inputVo: all_dialog_info.InputVo(
                            dialogTitle: "회원가입 실패",
                            dialogContent: "본인 인증 요청 정보가 없습니다.\n다시 인증해주세요.",
                            checkBtnTitle: "확인",
                            onDialogCreated: () {},
                          ),
                        ));

                onRegisterBtnClickClicked = false;
                if (!mainContext.mounted) return;
                mainContext.pop();
              }
              break;
            case "2":
              {
                // 이메일 검증 요청이 만료됨
                final GlobalKey<all_dialog_info.MainWidgetState>
                    allDialogInfoStateGk =
                    GlobalKey<all_dialog_info.MainWidgetState>();
                if (!mainContext.mounted) return;
                await showDialog(
                    barrierDismissible: true,
                    context: mainContext,
                    builder: (context) => all_dialog_info.MainWidget(
                          key: allDialogInfoStateGk,
                          inputVo: all_dialog_info.InputVo(
                            dialogTitle: "회원가입 실패",
                            dialogContent: "본인 인증 요청 정보가 만료되었습니다.\n다시 인증해주세요.",
                            checkBtnTitle: "확인",
                            onDialogCreated: () {},
                          ),
                        ));

                onRegisterBtnClickClicked = false;
                if (!mainContext.mounted) return;
                mainContext.pop();
              }
              break;
            case "3":
              {
                // verificationCode 가 일치하지 않음
                final GlobalKey<all_dialog_info.MainWidgetState>
                    allDialogInfoStateGk =
                    GlobalKey<all_dialog_info.MainWidgetState>();
                if (!mainContext.mounted) return;
                await showDialog(
                    barrierDismissible: true,
                    context: mainContext,
                    builder: (context) => all_dialog_info.MainWidget(
                          key: allDialogInfoStateGk,
                          inputVo: all_dialog_info.InputVo(
                            dialogTitle: "회원가입 실패",
                            dialogContent: "본인 인증 요청 정보가 만료되었습니다.\n다시 인증해주세요.",
                            checkBtnTitle: "확인",
                            onDialogCreated: () {},
                          ),
                        ));

                onRegisterBtnClickClicked = false;
                if (!mainContext.mounted) return;
                mainContext.pop();
              }
              break;
            case "4":
              {
                // 이미 가입된 회원이 있습니다.
                final GlobalKey<all_dialog_info.MainWidgetState>
                    allDialogInfoStateGk =
                    GlobalKey<all_dialog_info.MainWidgetState>();
                if (!mainContext.mounted) return;
                await showDialog(
                    barrierDismissible: true,
                    context: mainContext,
                    builder: (context) => all_dialog_info.MainWidget(
                          key: allDialogInfoStateGk,
                          inputVo: all_dialog_info.InputVo(
                            dialogTitle: "회원가입 실패",
                            dialogContent: "이미 가입된 회원 정보입니다.",
                            checkBtnTitle: "확인",
                            onDialogCreated: () {},
                          ),
                        ));

                onRegisterBtnClickClicked = false;
                if (!mainContext.mounted) return;
                mainContext
                    .pop(const main_widget.OutputVo(registerComplete: true));
              }
              break;
            case "5":
              {
                // 이미 사용중인 닉네임
                nickNameTextFieldErrorMsg = "이미 사용중인 닉네임입니다.";
                nickNameTextFieldAreaGk.currentState?.refreshUi();
                nickNameCheckBtn = "중복\n확인";
                nickNameCheckBtnAreaGk.currentState?.refreshUi();
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
      final GlobalKey<all_dialog_info.MainWidgetState> allDialogInfoStateGk =
          GlobalKey<all_dialog_info.MainWidgetState>();
      if (!mainContext.mounted) return;
      showDialog(
          barrierDismissible: true,
          context: mainContext,
          builder: (context) => all_dialog_info.MainWidget(
                key: allDialogInfoStateGk,
                inputVo: all_dialog_info.InputVo(
                  dialogTitle: "네트워크 에러",
                  dialogContent: "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                  checkBtnTitle: "확인",
                  onDialogCreated: () {},
                ),
              ));
      onRegisterBtnClickClicked = false;
    }
  }

  // 닉네임 입력 규칙 클릭
  void onNicknameInputRuleTap() {
    nicknameInputRuleHide = !nicknameInputRuleHide;
    nicknameInputRuleHideAreaGk.currentState?.refreshUi();
  }

  // [private 함수]
  void _doNothing() {}
}
