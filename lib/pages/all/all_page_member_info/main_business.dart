// (external)
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

// (inner_folder)
import 'main_widget.dart' as main_widget;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/global_widgets/gw_sfw_wrapper.dart'
    as gw_sfw_wrapper;
import 'package:flutter_project_template/repositories/spws/spw_auth_member_info.dart'
    as spw_auth_member_info;
import 'package:flutter_project_template/global_functions/gf_my_functions.dart'
    as gf_my_functions;
import 'package:flutter_project_template/pages/all/all_page_membership_withdrawal/main_widget.dart'
    as all_page_membership_withdrawal;
import 'package:flutter_project_template/pages/all/all_page_login/main_widget.dart'
    as all_page_login;
import 'package:flutter_project_template/pages/all/all_page_change_password/main_widget.dart'
    as all_page_change_password;

// [위젯 비즈니스]
// todo : 회원 정보 페이지에서 닉네임 변경 기능 추가
// todo : 회원 정보 페이지에서 프로필 추가 / 삭제 / 대표 프로필 변경 기능 추가
// todo : 회원 정보 페이지에서 이메일 추가 / 삭제 기능 추가
// todo : 회원 정보 페이지에서 전화번호 추가 / 삭제 기능 추가
// todo : 회원 정보 페이지에서 비밀번호 없을 때 계정 비밀번호 추가하기 / 있으면 수정하기 기능 추가
// 비밀번호 변경 페이지로 이동
// _context.pushNamed(all_page_change_password.pageName);

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

    // !!!PageInputVo 입력!!!
    return const main_widget.InputVo();
  }

  // (진입 최초 단 한번 실행) - 아직 위젯이 생성 되기 전
  void initState() {
    // !!!initState 로직 작성!!!

    // todo 에러 화면 처리
    setNowMemberInfo();
  }

  // (종료 시점 단 한번 실행)
  void dispose() {
    // !!!dispose 로직 작성!!!
  }

  // (최초 실행시 단 한번 실행) - 위젯 build 바로 직전, 모든 것이 준비 되었을 때
  void onCreate() {
    // !!!onCreate 로직 작성!!!
  }

  Future<void> onFocusGainedAsync() async {
    // !!!onFocusGainedAsync 로직 작성!!!

    // 검증된 현재 회원 정보 가져오기 (비회원이라면 null)
    final spw_auth_member_info.SharedPreferenceWrapperVo? nowLoginMemberInfo =
        gf_my_functions.getNowVerifiedMemberInfo();

    if (nowLoginMemberInfo == null) {
      // 로그아웃 상태
      showToast(
        "로그인이 필요합니다.",
        context: mainContext,
        animation: StyledToastAnimation.scale,
      );
      mainContext.goNamed(all_page_login.pageName);
      return;
    }

    setNowMemberInfo();
    myProfileAreaGk.currentState?.refreshUi();
    nicknameAreaGk.currentState?.refreshUi();
    emailAreaGk.currentState?.refreshUi();
    myPhoneNumberAreaGk.currentState?.refreshUi();
    myOAuth2AreaGk.currentState?.refreshUi();
    roleListAreaGk.currentState?.refreshUi();
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

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> myProfileAreaGk =
      GlobalKey();
  late BuildContext myProfileAreaContext;
  late List<spw_auth_member_info.SharedPreferenceWrapperVoProfileInfo>
      myProfileList; // 내가 등록한 Profile 정보 리스트
  int? frontProfileIdx; // myProfileList 의 대표 프로필 인덱스

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> nicknameAreaGk =
      GlobalKey();
  late BuildContext nicknameAreaContext;
  String? nickName; // 닉네임

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> emailAreaGk =
      GlobalKey();
  late BuildContext emailAreaContext;
  List<spw_auth_member_info.SharedPreferenceWrapperVoEmailInfo>?
      myEmailList; // 내가 등록한 이메일 정보 리스트

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> myPhoneNumberAreaGk =
      GlobalKey();
  late BuildContext myPhoneNumberAreaContext;
  List<spw_auth_member_info.SharedPreferenceWrapperVoPhoneInfo>?
      myPhoneNumberList; // 내가 등록한 전화번호 정보 리스트

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> myOAuth2AreaGk =
      GlobalKey();
  late BuildContext myOAuth2AreaContext;
  List<spw_auth_member_info.SharedPreferenceWrapperVoOAuth2Info>?
      myOAuth2List; // 내가 등록한 OAuth2 정보 리스트

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> roleListAreaGk =
      GlobalKey();
  late BuildContext roleListAreaContext;
  List<String>? roleList; // 멤버 권한 리스트 (관리자 : ROLE_ADMIN, 개발자 : ROLE_DEVELOPER)

  late bool authPasswordIsNull;

  // [private 변수]

  //----------------------------------------------------------------------------
  // !!!비즈니스 함수는 이 곳에서 저장 하여 사용 하세요.!!!
  // [public 함수]
  // (메인 위젯 화면 갱신)
  late VoidCallback refreshUi;

  // (회원 탈퇴 버튼 누름)
  Future<void> tapWithdrawalBtn() async {
    // 회원탈퇴 페이지로 이동
    mainContext.pushNamed(all_page_membership_withdrawal.pageName);
  }

  void setNowMemberInfo() {
    // 검증된 현재 회원 정보 가져오기 (비회원이라면 null)
    spw_auth_member_info.SharedPreferenceWrapperVo? nowLoginMemberInfo =
        gf_my_functions.getNowVerifiedMemberInfo();

    if (nowLoginMemberInfo == null) {
      inputError = true;
      return;
    }

    myProfileList = nowLoginMemberInfo.myProfileList;
    for (int i = 0; i < myProfileList.length; i++) {
      var myProfile = myProfileList[i];
      if (myProfile.isFront) {
        frontProfileIdx = i;
        break;
      }
    }
    nickName = nowLoginMemberInfo.nickName;
    myEmailList = nowLoginMemberInfo.myEmailList;
    myPhoneNumberList = nowLoginMemberInfo.myPhoneNumberList;
    myOAuth2List = nowLoginMemberInfo.myOAuth2List;
    roleList = nowLoginMemberInfo.roleList;

    authPasswordIsNull = nowLoginMemberInfo.authPasswordIsNull;
  }

  void goToChangePasswordPage() {
    mainContext.pushNamed(all_page_change_password.pageName);
  }

  // [private 함수]
  void _doNothing() {}
}
