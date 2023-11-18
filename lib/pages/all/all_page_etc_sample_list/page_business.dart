// (external)
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// (page)
import 'page_entrance.dart' as page_entrance;

// (all)
import '../../../global_widgets/gw_page_out_frames.dart' as gw_page_out_frames;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../pages/all/all_page_basic_bloc_sample/page_entrance.dart'
    as all_page_basic_bloc_sample;
import '../../../pages/all/all_page_crypt_sample/page_entrance.dart'
    as all_page_crypt_sample;
import '../../../pages/all/all_page_global_variable_state_test_sample/page_entrance.dart'
    as all_page_global_variable_state_test_sample;
import '../../../pages/all/all_page_shared_preferences_sample/page_entrance.dart'
    as all_page_shared_preferences_sample;
import '../../../pages/all/all_page_url_launcher_sample/page_entrance.dart'
    as all_page_url_launcher_sample;
import '../../../pages/all/all_page_widget_change_animation_sample_list/page_entrance.dart'
    as all_page_widget_change_animation_sample_list;
import '../../../pages/all/all_page_gif_sample/page_entrance.dart'
    as all_page_gif_sample;
import '../../../pages/all/all_page_image_selector_sample/page_entrance.dart'
    as all_page_image_selector_sample;
import '../../../pages/all/all_page_image_loading_sample/page_entrance.dart'
    as all_page_image_loading_sample;
import '../../../pages/all/all_page_context_menu_sample/page_entrance.dart'
    as all_page_context_menu_sample;
import '../../../pages/all/all_page_gesture_area_overlap_test/page_entrance.dart'
    as all_page_gesture_area_overlap_test;
import '../../../pages/all/all_page_form_sample/page_entrance.dart'
    as all_page_form_sample;
import '../../../pages/all/all_page_horizontal_scroll_test/page_entrance.dart'
    as all_page_horizontal_scroll_test;

// (app)
import '../../../pages/app/app_page_server_sample/page_entrance.dart'
    as app_page_server_sample;

// [페이지 비즈니스 로직 및 뷰모델 작성 파일]

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

  // (리스트 아이템 클릭 리스너)
  void onRouteListItemClick(int index) {
    SampleItem sampleItem = pageViewModel.allSampleList[index];

    switch (sampleItem.sampleItemEnum) {
      case SampleItemEnum.horizontalScrollTest:
        {
          _context.pushNamed(all_page_horizontal_scroll_test.pageName);
        }
        break;
      case SampleItemEnum.sharedPreferencesSample:
        {
          _context.pushNamed(all_page_shared_preferences_sample.pageName);
        }
        break;
      case SampleItemEnum.urlLauncherSample:
        {
          _context.pushNamed(all_page_url_launcher_sample.pageName);
        }
        break;
      case SampleItemEnum.serverSample:
        {
          _context.pushNamed(app_page_server_sample.pageName);
        }
        break;
      case SampleItemEnum.globalVariableStateTestSample:
        {
          _context
              .pushNamed(all_page_global_variable_state_test_sample.pageName);
        }
        break;
      case SampleItemEnum.widgetChangeAnimationSampleList:
        {
          _context
              .pushNamed(all_page_widget_change_animation_sample_list.pageName);
        }
        break;
      case SampleItemEnum.cryptSample:
        {
          _context.pushNamed(all_page_crypt_sample.pageName);
        }
        break;
      case SampleItemEnum.gifSample:
        {
          _context.pushNamed(all_page_gif_sample.pageName);
        }
        break;
      case SampleItemEnum.imageSelectorSample:
        {
          _context.pushNamed(all_page_image_selector_sample.pageName);
        }
        break;
      case SampleItemEnum.imageLoadingSample:
        {
          _context.pushNamed(all_page_image_loading_sample.pageName);
        }
        break;
      case SampleItemEnum.contextMenuSample:
        {
          _context.pushNamed(all_page_context_menu_sample.pageName);
        }
        break;
      case SampleItemEnum.gestureAreaOverlapTest:
        {
          _context.pushNamed(all_page_gesture_area_overlap_test.pageName);
        }
        break;
      case SampleItemEnum.formSample:
        {
          _context.pushNamed(all_page_form_sample.pageName);
        }
        break;
      case SampleItemEnum.basicBlocSample:
        {
          _context.pushNamed(all_page_basic_bloc_sample.pageName);
        }
        break;
    }
  }

////
// [내부 함수]
// !!!내부에서만 사용할 함수를 아래에 구현!!!
}

// (페이지 뷰 모델 클래스)
// 페이지 전역의 데이터는 여기에 정의되며, Business 인스턴스 안의 pageViewModel 변수로 저장 됩니다.
class PageViewModel {
  PageViewModel(this._context) {
    // 초기 리스트 추가
    allSampleList.add(SampleItem(
        SampleItemEnum.basicBlocSample, "기본 BLoC 샘플", "기본 BLoC 적용 샘플"));
    allSampleList.add(SampleItem(SampleItemEnum.horizontalScrollTest,
        "가로 스크롤 테스트", "모바일 이외 환경에서 가로 스크롤 작동을 테스트 하기 위한 샘플"));
    allSampleList.add(SampleItem(SampleItemEnum.sharedPreferencesSample,
        "SharedPreferences 샘플", "SharedPreferences 사용 샘플"));
    allSampleList.add(SampleItem(SampleItemEnum.urlLauncherSample,
        "Url Launcher 샘플", "Url Launcher 사용 샘플"));
    if (!kIsWeb) {
      // App
      allSampleList
          .add(SampleItem(SampleItemEnum.serverSample, "서버 샘플", "서버 포트 개방 샘플"));
    }
    allSampleList.add(SampleItem(SampleItemEnum.globalVariableStateTestSample,
        "전역 변수 상태 확인 샘플", "전역 변수 사용시의 상태 확인용 샘플 (특히 웹에서 새 탭으로 접속 했을 때를 확인하기)"));
    allSampleList.add(SampleItem(SampleItemEnum.widgetChangeAnimationSampleList,
        "위젯 변경 애니메이션 샘플 리스트", "위젯 변경시의 애니메이션 적용 샘플 리스트"));
    allSampleList.add(
        SampleItem(SampleItemEnum.cryptSample, "암/복호화 샘플", "암호화, 복호화 적용 샘플"));
    allSampleList
        .add(SampleItem(SampleItemEnum.gifSample, "GIF 샘플", "GIF 이미지 샘플"));
    allSampleList.add(SampleItem(SampleItemEnum.imageSelectorSample,
        "이미지 선택 샘플", "로컬 저장소, 혹은 카메라에서 이미지를 가져오는 샘플"));
    allSampleList.add(SampleItem(SampleItemEnum.imageLoadingSample, "이미지 로딩 샘플",
        "네트워크 이미지를 가져올 때 로딩 처리 및 에러 처리 샘플"));
    allSampleList.add(SampleItem(SampleItemEnum.contextMenuSample, "컨텍스트 메뉴 샘플",
        "마우스 우클릭시(모바일에서는 롱 클릭) 나타나는 메뉴 샘플"));
    allSampleList.add(SampleItem(SampleItemEnum.gestureAreaOverlapTest,
        "Gesture 위젯 영역 중첩 테스트", "Gesture 위젯 영역 중첩시 동작을 테스트합니다."));
    allSampleList.add(
        SampleItem(SampleItemEnum.formSample, "Form 입력 샘플", "Form 입력 작성 샘플"));
  }

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
  gw_page_out_frames.PageOutFrameViewModel pageOutFrameViewModel =
      gw_page_out_frames.PageOutFrameViewModel("기타 샘플 리스트");

  // 샘플 목록 필터링용 검색창 컨트롤러 (검색창의 텍스트 정보를 가지고 있으므로 뷰모델에 저장, 여기 있어야 위젯이 변경되어도 검색어가 유지됨)
  TextEditingController sampleSearchBarTextEditController =
      TextEditingController();

  // (샘플 페이지 원본 리스트)
  List<SampleItem> allSampleList = [];
}

class SampleItem {
  SampleItem(
      this.sampleItemEnum, this.sampleItemTitle, this.sampleItemDescription);

  // 샘플 고유값
  SampleItemEnum sampleItemEnum;

  // 샘플 타이틀
  String sampleItemTitle;

  // 샘플 설명
  String sampleItemDescription;

  // 권한 체크 여부
  bool isChecked = false;
}

enum SampleItemEnum {
  basicBlocSample,
  horizontalScrollTest,
  sharedPreferencesSample,
  urlLauncherSample,
  serverSample,
  globalVariableStateTestSample,
  widgetChangeAnimationSampleList,
  cryptSample,
  gifSample,
  imageSelectorSample,
  imageLoadingSample,
  contextMenuSample,
  gestureAreaOverlapTest,
  formSample,
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

class BlocSampleList extends Bloc<bool, bool> {
  BlocSampleList() : super(true) {
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
    BlocProvider<gw_page_out_frames.BlocHeaderGoToHomeIconBtn>(
        create: (context) => gw_page_out_frames.BlocHeaderGoToHomeIconBtn()),
    BlocProvider<BlocSampleList>(create: (context) => BlocSampleList()),
  ];
}

class BLocObjects {
  BLocObjects(this._context) {
    // !!!BLoC 조작 객체 생성!!!
    // ex :
    // blocSample = BlocProvider.of<BlocSample>(_context);
    blocSampleList = BlocProvider.of<BlocSampleList>(_context);
  }

  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // !!!BLoC 조작 객체 변수 선언!!!
  // ex :
  // late BlocSample blocSample;
  late BlocSampleList blocSampleList;
}
