// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// (page)
import 'page_entrance.dart' as page_entrance;

// (all)
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../../repositories/spws/spw_auth_member_info.dart'
    as spw_auth_member_info;
import '../../../global_functions/gf_my_functions.dart' as gf_my_functions;

// [페이지 비즈니스 로직 및 뷰모델 작성 파일]
// todo : 새로운 템플릿 적용

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
  PageBusiness(this._context, page_entrance.PageInputVo pageInputVo) {
    pageViewModel = PageViewModel(pageInputVo);
  }

  ////
  // [페이지 생명주기]
  // - 페이지 최초 실행 : onPageCreateAsync -> onPageResumeAsync
  // - 다른 페이지 호출 / 복귀, 화면 끄기 / 켜기, 모바일에서 다른 앱으로 이동 및 복귀시 :
  // onPagePauseAsync -> onPageResumeAsync -> onPagePauseAsync -> onPageResumeAsync 반복
  // - 페이지 종료 : onPageWillPopAsync -(return true 일 때)-> onPagePauseAsync -> onPageDestroyAsync 실행

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
      // 로그인 상태라면 다이얼로그 닫기
      _context.pop();
      return;
    }
  }

  // (페이지 종료 or 다른 페이지로 이동 (강제 종료는 탐지 못함))
  Future<void> onPagePauseAsync() async {
    // !!!위젯 종료 및, 다른 페이지로 이동 로직 작성!!!
  }

  // (페이지 종료 (강제 종료는 탐지 못함))
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
//     // 뷰모델 state 변경
//     pageViewModel.sampleNumber = newSampleNumber;
//     // 위젯 변경 트리거 발동
//     bLocObjects.blocSample.add(!bLocObjects.blocSample.state);
//   }

  // (확인 버튼 클릭시)
  void onCheckBtnClicked() {
    _context.pop();
  }

  // 이미지 소스 선택함
  void onResultSelected(page_entrance.ImageSourceType imageSourceType) {
    _context.pop(page_entrance.PageOutputVo(imageSourceType));
  }

////
// [내부 함수]
// !!!내부에서만 사용할 함수를 아래에 구현!!!
}

// (페이지 뷰 모델 데이터 형태)
// 페이지의 모든 화면 관련 데이터는 여기에 정의되며, Business 인스턴스 안에 객체로 저장 됩니다.
class PageViewModel {
  // 페이지 생명주기 관련 states
  var pageLifeCycleStates = gc_template_classes.PageLifeCycleStates();

  // 페이지 파라미터
  page_entrance.PageInputVo pageInputVo;

  // 다이얼로그 호출시 pageBusiness 를 전달하기 위한 콜백
  late void Function(PageBusiness) onDialogPageCreated;

  // !!!페이지 데이터 정의!!!
  // ex :
  // int sampleNumber = 0;

  PageViewModel(this.pageInputVo);
}

// (BLoC 클래스 모음)
// 아래엔 런타임 위젯 변경의 트리거가 되는 BLoC 클래스들을 작성해 둡니다.
// !!!각 BLoC 클래스는 아래 예시를 '그대로' 복사 붙여넣기를 하여 클래스 이름만 변경합니다.!!!
// ex :
// class BlocSample extends Bloc<bool, bool> {
//   BlocSample() : super(true) {
//     on<bool>((event, emit) {
//       emit(event);
//     });
//   }
// }

// (BLoC 프로바이더 클래스)
// 본 페이지에서 사용할 BLoC 객체를 모아두어 PageEntrance 에서 페이지 전역 설정에 사용 됩니다.
class BLocProviders {
// !!!이 페이지에서 사용할 "모든" BLoC 클래스들에 대한 Provider 객체들을 아래 리스트에 넣어줄 것!!!
  List<BlocProvider<dynamic>> blocProviders = [
    // ex :
    // BlocProvider<BlocSample>(create: (context) => BlocSample()),
  ];
}

class BLocObjects {
  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // !!!BLoC 조작 객체 변수 선언!!!
  // ex :
  // late BlocSample blocSample;

  // 생성자 설정
  BLocObjects(this._context) {
    // !!!BLoC 조작 객체 생성!!!
    // ex :
    // blocSample = BlocProvider.of<BlocSample>(_context);
  }
}
