// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:go_router/go_router.dart';

// (page)
import 'page_entrance.dart' as page_entrance;

// (all)
import '../../../global_widgets/gw_page_out_frames.dart' as gw_page_out_frames;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../../repositories/spws/spw_auth_member_info.dart'
    as spw_auth_member_info;
import '../../../global_functions/gf_my_functions.dart' as gf_my_functions;
import '../../../pages/all/all_page_membership_withdrawal/page_entrance.dart'
    as all_page_membership_withdrawal;
import '../../../pages/all/all_page_login/page_entrance.dart' as all_page_login;

// [페이지 비즈니스 로직 및 뷰모델 작성 파일]
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

    if (nowLoginMemberInfo == null) {
      // 비회원 상태라면 진입 금지
      showToast(
        "로그인이 필요합니다.",
        context: _context,
        animation: StyledToastAnimation.scale,
      );
      // Login 페이지로 이동
      _context.pushNamed(all_page_login.pageName);
      return;
    }

    pageViewModel.nickName = nowLoginMemberInfo.nickName;
    pageViewModel.roleList = nowLoginMemberInfo.roleList;
    pageViewModel.myProfileList = nowLoginMemberInfo.myProfileList;
    for (int i = 0; i < pageViewModel.myProfileList.length; i++) {
      var myProfile = pageViewModel.myProfileList[i];
      if (myProfile.isFront) {
        pageViewModel.frontProfileIdx = i;
        break;
      }
    }
    pageViewModel.myOAuth2List = nowLoginMemberInfo.myOAuth2List;
    pageViewModel.myEmailList = nowLoginMemberInfo.myEmailList;
    pageViewModel.myPhoneNumberList = nowLoginMemberInfo.myPhoneNumberList;
    pageViewModel.authPasswordIsNull = nowLoginMemberInfo.authPasswordIsNull;

    blocObjects.blocProfileImage.refresh();
    blocObjects.blocNickname.refresh();
    blocObjects.blocEmail.refresh();
    blocObjects.blocPhoneNumber.refresh();
    blocObjects.blocPermission.refresh();
    blocObjects.blocOAuth2.refresh();
  }

  // (페이지 종료 or 다른 페이지로 이동 (강제 종료는 탐지 못함))
  Future<void> onPagePauseAsync() async {
    // !!!위젯 종료 및, 다른 페이지로 이동 로직 작성!!!
  }

  // (페이지 종료 (강제 종료, web 에서 브라우저 뒤로가기 버튼을 눌렀을 때는 탐지 못함))
  Future<void> onPageDestroyAsync() async {
    // !!!페이지 종료 로직 작성!!!
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
  // (회원 탈퇴 버튼 누름)
  Future<void> tapWithdrawalBtn() async {
    // 회원탈퇴 페이지로 이동
    all_page_membership_withdrawal.PageOutputVo? pageOutputVo =
        await _context.pushNamed(all_page_membership_withdrawal.pageName);
    if (pageOutputVo != null && pageOutputVo.withdrawalOk) {
      if (!_context.mounted) return;
      _context.pop();
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
      gw_page_out_frames.PageOutFrameBusiness(pageTitle: "회원 정보");

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

class BlocProfileImage extends Bloc<bool, bool> {
  BlocProfileImage() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }

  // BLoC 위젯 갱신 함수
  void refresh() {
    add(!state);
  }
}

class BlocNickname extends Bloc<bool, bool> {
  BlocNickname() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }

  // BLoC 위젯 갱신 함수
  void refresh() {
    add(!state);
  }
}

class BlocEmail extends Bloc<bool, bool> {
  BlocEmail() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }

  // BLoC 위젯 갱신 함수
  void refresh() {
    add(!state);
  }
}

class BlocPhoneNumber extends Bloc<bool, bool> {
  BlocPhoneNumber() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }

  // BLoC 위젯 갱신 함수
  void refresh() {
    add(!state);
  }
}

class BlocPermission extends Bloc<bool, bool> {
  BlocPermission() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }

  // BLoC 위젯 갱신 함수
  void refresh() {
    add(!state);
  }
}

class BlocOAuth2 extends Bloc<bool, bool> {
  BlocOAuth2() : super(true) {
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
    BlocProvider<BlocProfileImage>(create: (context) => BlocProfileImage()),
    BlocProvider<BlocNickname>(create: (context) => BlocNickname()),
    BlocProvider<BlocEmail>(create: (context) => BlocEmail()),
    BlocProvider<BlocPhoneNumber>(create: (context) => BlocPhoneNumber()),
    BlocProvider<BlocPermission>(create: (context) => BlocPermission()),
    BlocProvider<BlocOAuth2>(create: (context) => BlocOAuth2()),
  ];
}

class BLocObjects {
  BLocObjects(this._context) {
    // !!!BLoC 조작 객체 생성!!!
    // ex :
    // blocSample = BlocProvider.of<BlocSample>(_context);
    blocProfileImage = BlocProvider.of<BlocProfileImage>(_context);
    blocNickname = BlocProvider.of<BlocNickname>(_context);
    blocEmail = BlocProvider.of<BlocEmail>(_context);
    blocPhoneNumber = BlocProvider.of<BlocPhoneNumber>(_context);
    blocPermission = BlocProvider.of<BlocPermission>(_context);
    blocOAuth2 = BlocProvider.of<BlocOAuth2>(_context);
  }

  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // !!!BLoC 조작 객체 변수 선언!!!
  // ex :
  // late BlocSample blocSample;
  late BlocProfileImage blocProfileImage;
  late BlocNickname blocNickname;
  late BlocEmail blocEmail;
  late BlocPhoneNumber blocPhoneNumber;
  late BlocPermission blocPermission;
  late BlocOAuth2 blocOAuth2;
}
