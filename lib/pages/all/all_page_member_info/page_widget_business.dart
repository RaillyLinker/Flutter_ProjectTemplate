// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

// (inner Folder)
import 'page_widget.dart' as page_widget;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/a_must_delete/todo_gc_delete.dart'
    as gc_template_classes;
import 'package:flutter_project_template/repositories/spws/spw_auth_member_info.dart'
    as spw_auth_member_info;
import 'package:flutter_project_template/global_functions/gf_my_functions.dart'
    as gf_my_functions;
import 'package:flutter_project_template/pages/all/all_page_membership_withdrawal/page_widget.dart'
    as all_page_membership_withdrawal;
import 'package:flutter_project_template/pages/all/all_page_login/page_entrance.dart'
    as all_page_login;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.
// todo : 회원 정보 페이지에서 닉네임 변경 기능 추가
// todo : 회원 정보 페이지에서 프로필 추가 / 삭제 / 대표 프로필 변경 기능 추가
// todo : 회원 정보 페이지에서 이메일 추가 / 삭제 기능 추가
// todo : 회원 정보 페이지에서 전화번호 추가 / 삭제 기능 추가
// todo : 회원 정보 페이지에서 비밀번호 없을 때 계정 비밀번호 추가하기 / 있으면 수정하기 기능 추가
// todo : 템플릿 적용
// 비밀번호 변경 페이지로 이동
// _context.pushNamed(all_page_change_password.pageName);

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 담당
// PageBusiness 인스턴스는 해당 페이지가 소멸하기 전까지 활용됩니다.
class PageWidgetBusiness {
  // [콜백 함수]
  // (전체 위젯 initState)
  void initState() {
    // !!!initState 로직 작성!!!
    // todo 데이터
    setNowMemberInfo();
    profileImageBloc.refreshUi();
    nicknameBloc.refreshUi();
    emailBloc.refreshUi();
    phoneNumberBloc.refreshUi();
    permissionBloc.refreshUi();
    oAuth2Bloc.refreshUi();
  }

  // (전체 위젯 dispose)
  void dispose() {
    // !!!initState 로직 작성!!!
  }

  // (전체 위젯의 FocusDetector 콜백들)
  Future<void> onFocusGained() async {
    // !!!onFocusGained 로직 작성!!!
    // todo 데이터
    setNowMemberInfo();
    profileImageBloc.refreshUi();
    nicknameBloc.refreshUi();
    emailBloc.refreshUi();
    phoneNumberBloc.refreshUi();
    permissionBloc.refreshUi();
    oAuth2Bloc.refreshUi();
  }

  Future<void> onFocusLost() async {
    // !!!onFocusLost 로직 작성!!!
  }

  Future<void> onVisibilityGained() async {
    // !!!onFocusLost 로직 작성!!!
  }

  Future<void> onVisibilityLost() async {
    // !!!onVisibilityLost 로직 작성!!!
  }

  Future<void> onForegroundGained() async {
    // !!!onForegroundGained 로직 작성!!!
  }

  Future<void> onForegroundLost() async {
    // !!!onForegroundLost 로직 작성!!!
  }

  void onCheckPageInputVo({required GoRouterState goRouterState}) {
    // !!!pageInputVo 체크!!!
    // ex :
    // if (!goRouterState.uri.queryParameters
    //     .containsKey("inputValueString")) {
    //   // 필수 파라미터가 없는 경우에 대한 처리
    // }

    // !!!PageInputVo 입력!!!
    inputVo = const page_widget.InputVo();
  }

  // [public 변수]
  // BLoC 객체 샘플 :
  // final gc_template_classes.RefreshableBloc refreshableBloc = gc_template_classes.RefreshableBloc();

  late BuildContext context;

  // (위젯 입력값)
  late page_widget.InputVo inputVo;

  // (페이지 pop 가능 여부 변수)
  bool canPop = true;

  // (pageOutFrameBusiness)
  final gw_slw_page_outer_frame.SlwPageOuterFrameBusiness pageOutFrameBusiness =
      gw_slw_page_outer_frame.SlwPageOuterFrameBusiness();

  String? nickName; // 닉네임
  List<String>? roleList; // 멤버 권한 리스트 (관리자 : ROLE_ADMIN, 개발자 : ROLE_DEVELOPER)
  late List<spw_auth_member_info.SharedPreferenceWrapperVoProfileInfo>
      myProfileList; // 내가 등록한 Profile 정보 리스트
  int? frontProfileIdx; // myProfileList 의 대표 프로필 인덱스
  List<spw_auth_member_info.SharedPreferenceWrapperVoOAuth2Info>?
      myOAuth2List; // 내가 등록한 OAuth2 정보 리스트
  List<spw_auth_member_info.SharedPreferenceWrapperVoEmailInfo>?
      myEmailList; // 내가 등록한 이메일 정보 리스트
  List<spw_auth_member_info.SharedPreferenceWrapperVoPhoneInfo>?
      myPhoneNumberList; // 내가 등록한 전화번호 정보 리스트
  bool?
      authPasswordIsNull; // 계정 로그인 비밀번호 설정 Null 여부 (OAuth2 만으로 회원가입한 경우는 비밀번호가 없으므로 true)

  final gc_template_classes.RefreshableBloc profileImageBloc =
      gc_template_classes.RefreshableBloc();
  final gc_template_classes.RefreshableBloc nicknameBloc =
      gc_template_classes.RefreshableBloc();
  final gc_template_classes.RefreshableBloc emailBloc =
      gc_template_classes.RefreshableBloc();
  final gc_template_classes.RefreshableBloc phoneNumberBloc =
      gc_template_classes.RefreshableBloc();
  final gc_template_classes.RefreshableBloc oAuth2Bloc =
      gc_template_classes.RefreshableBloc();
  final gc_template_classes.RefreshableBloc permissionBloc =
      gc_template_classes.RefreshableBloc();

  // [private 변수]

  // [public 함수]
  // (Widget 화면 갱신) - WidgetUi.viewWidgetBuild 의 return 값을 다시 불러 옵니다.
  late VoidCallback refreshUi;

  // (회원 탈퇴 버튼 누름)
  Future<void> tapWithdrawalBtn() async {
    // 회원탈퇴 페이지로 이동
    context.pushNamed(all_page_membership_withdrawal.pageName);
  }

  void setNowMemberInfo() {
    // 검증된 현재 회원 정보 가져오기 (비회원이라면 null)
    spw_auth_member_info.SharedPreferenceWrapperVo? nowLoginMemberInfo =
        gf_my_functions.getNowVerifiedMemberInfo();

    if (nowLoginMemberInfo == null) {
      // 비회원 상태라면 진입 금지
      showToast(
        "로그인이 필요합니다.",
        context: context,
        animation: StyledToastAnimation.scale,
      );
      // Login 페이지로 이동
      context.pushNamed(all_page_login.pageName);
      return;
    }

    nickName = nowLoginMemberInfo.nickName;
    roleList = nowLoginMemberInfo.roleList;
    myProfileList = nowLoginMemberInfo.myProfileList;
    for (int i = 0; i < myProfileList.length; i++) {
      var myProfile = myProfileList[i];
      if (myProfile.isFront) {
        frontProfileIdx = i;
        break;
      }
    }
    myOAuth2List = nowLoginMemberInfo.myOAuth2List;
    myEmailList = nowLoginMemberInfo.myEmailList;
    myPhoneNumberList = nowLoginMemberInfo.myPhoneNumberList;
    authPasswordIsNull = nowLoginMemberInfo.authPasswordIsNull;
  }

// [private 함수]
}
