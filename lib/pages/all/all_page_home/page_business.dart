// (external)
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// (page)
import 'page_entrance.dart' as page_entrance;

import '../../../pages/all/all_page_global_variable_state_test_sample/page_entrance.dart'
    as all_page_global_variable_state_test_sample;
import '../../../pages/all/all_page_auth_sample/page_entrance.dart'
    as all_page_auth_sample;
import '../../../pages/all/all_page_network_request_sample/page_entrance.dart'
    as all_page_network_request_sample;
import '../../../pages/all/all_page_url_launcher_sample/page_entrance.dart'
    as all_page_url_launcher_sample;
import '../../../pages/all/all_page_shared_preferences_sample/page_entrance.dart'
    as all_page_shared_preferences_sample;
import '../../../pages/all/all_page_page_and_router_test_sample/page_entrance.dart'
    as all_page_page_and_router_test_sample;
import '../../../pages/all/all_page_dialog_sample/page_entrance.dart'
    as all_page_dialog_sample;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../pages/all/all_page_widget_change_animation_sample/page_entrance.dart'
    as all_page_widget_change_animation_sample;
import '../../../pages/all/all_page_crypt_sample/page_entrance.dart'
    as all_page_crypt_sample;

// (app)
import '../../../pages/app/app_page_server_sample/page_entrance.dart'
    as app_page_server_sample;

// (mobile)
import '../../../pages/mobile/mobile_page_permission_sample/page_entrance.dart'
    as mobile_page_permission_sample;

// [페이지 비즈니스 로직 및 뷰모델 작성 파일]

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
    // !!!페이지 최초 실행 로직 작성!!
  }

  // (페이지 최초 실행 or 다른 페이지에서 복귀)
  Future<void> onPageResumeAsync() async {
    // !!!위젯 최초 실행 및, 다른 페이지에서 복귀 로직 작성!!
  }

  // (페이지 종료 or 다른 페이지로 이동 (강제 종료는 탐지 못함))
  Future<void> onPagePauseAsync() async {
    // !!!위젯 종료 및, 다른 페이지로 이동 로직 작성!!
  }

  // (페이지 종료 (강제 종료는 탐지 못함))
  Future<void> onPageDestroyAsync() async {
    // !!!페이지 종료 로직 작성!!

    // 검색창 컨트롤러 닫기
    pageViewModel.sampleSearchBarTextEditController.dispose();
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

  // (검색 결과에 따라 샘플 페이지 리스트 필터링)
  void filteringSamplePageList(String searchKeyword) {
    if (searchKeyword == "") {
      // 원본 리스트로 뷰모델 데이터 변경 후 이벤트 발생
      pageViewModel.filteredSampleList = pageViewModel.allSampleList;
      blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
    } else {
      // 필터링한 리스트로 뷰모델 데이터 변경 후 이벤트 발생
      List<SampleItem> filteredSamplePageList = [];
      // 필터링 하기
      for (SampleItem samplePage in pageViewModel.allSampleList) {
        if (samplePage.sampleItemTitle
            .toLowerCase()
            .contains(searchKeyword.toLowerCase())) {
          filteredSamplePageList.add(samplePage);
        } else if (samplePage.sampleItemDescription
            .toLowerCase()
            .contains(searchKeyword.toLowerCase())) {
          filteredSamplePageList.add(samplePage);
        }
      }
      pageViewModel.filteredSampleList = filteredSamplePageList;
      blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
    }
  }

  // (리스트 아이템 클릭 리스너)
  void onRouteListItemClick(int index) {
    SampleItem sampleItem = pageViewModel.filteredSampleList[index];

    switch (sampleItem.sampleItemEnum) {
      case SampleItemEnum.pageAndRouterTestSample:
        {
          _context.pushNamed(all_page_page_and_router_test_sample.pageName);
        }
        break;
      case SampleItemEnum.dialogSample:
        {
          _context.pushNamed(all_page_dialog_sample.pageName);
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
      case SampleItemEnum.networkRequestSample:
        {
          _context.pushNamed(all_page_network_request_sample.pageName);
        }
        break;
      case SampleItemEnum.mobilePermissionSample:
        {
          _context.pushNamed(mobile_page_permission_sample.pageName);
        }
        break;
      case SampleItemEnum.authSample:
        {
          _context.pushNamed(all_page_auth_sample.pageName);
        }
        break;
      case SampleItemEnum.globalVariableStateTestSample:
        {
          _context
              .pushNamed(all_page_global_variable_state_test_sample.pageName);
        }
        break;
      case SampleItemEnum.widgetChangeAnimationSample:
        {
          _context.pushNamed(all_page_widget_change_animation_sample.pageName);
        }
        break;
      case SampleItemEnum.cryptSample:
        {
          _context.pushNamed(all_page_crypt_sample.pageName);
        }
        break;
    }
  }

////
// [내부 함수]
// !!!내부에서만 사용할 함수를 아래에 구현!!
}

// (페이지 뷰 모델 스키마)
// 페이지의 모든 화면 관련 데이터는 여기에 정의되며, Business 인스턴스 안에 객체로 저장 됩니다.
class PageViewModel {
  // 페이지 생명주기 관련 states
  var pageLifeCycleStates = gc_template_classes.PageLifeCycleStates();

  // 페이지 파라미터
  page_entrance.PageInputVo pageInputVo;

  // !!!페이지 데이터 정의!!
  // ex :
  // int sampleNumber = 0;

  // 샘플 목록 필터링용 검색창 컨트롤러 (검색창의 텍스트 정보를 가지고 있으므로 뷰모델에 저장, 여기 있어야 위젯이 변경되어도 검색어가 유지됨)
  TextEditingController sampleSearchBarTextEditController =
      TextEditingController();

  // (샘플 페이지 원본 리스트)
  List<SampleItem> allSampleList = [];

  // (샘플 페이지 리스트 검색 결과)
  List<SampleItem> filteredSampleList = [];

  PageViewModel(this.pageInputVo) {
    // 초기 리스트 추가
    allSampleList.add(SampleItem(
        SampleItemEnum.pageAndRouterTestSample,
        "Page And Router Test Sample",
        "Test samples for moving pages, passing parameters, etc."));
    allSampleList.add(SampleItem(
        SampleItemEnum.dialogSample, "Dialog Sample", "Dialog call sample"));
    allSampleList.add(SampleItem(SampleItemEnum.sharedPreferencesSample,
        "Shared Preferences Sample", "Sample using Shared Preferences"));
    allSampleList.add(SampleItem(SampleItemEnum.urlLauncherSample,
        "Url Launcher Sample", "Sample using Url Launcher"));
    if (!kIsWeb) {
      // App
      allSampleList.add(SampleItem(SampleItemEnum.serverSample, "Server Sample",
          "Server Port Open Sample"));
    }
    allSampleList.add(SampleItem(
        SampleItemEnum.networkRequestSample,
        "Network Request Sample",
        "Sample Network Request and Response Handling"));
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      // Mobile 환경일 때
      allSampleList.add(SampleItem(SampleItemEnum.mobilePermissionSample,
          "Mobile Permission Sample", "mobile permission sample"));
    }
    allSampleList.add(SampleItem(SampleItemEnum.authSample, "Auth Sample",
        "Authentication/authorization processing sample in application"));
    allSampleList.add(SampleItem(
        SampleItemEnum.globalVariableStateTestSample,
        "Global Variable State Test Sample",
        "Sample state persistence test for global variables. (Especially on the web)"));
    allSampleList.add(SampleItem(
        SampleItemEnum.widgetChangeAnimationSample,
        "Widget Change Animation Sample",
        "animation sample applied when widget changes"));
    allSampleList.add(SampleItem(SampleItemEnum.cryptSample, "Crypt Sample",
        "encoding, decoding crypt sample"));

    filteredSampleList = allSampleList;
  }
}

class SampleItem {
  // 샘플 고유값
  SampleItemEnum sampleItemEnum;

  // 샘플 타이틀
  String sampleItemTitle;

  // 샘플 설명
  String sampleItemDescription;

  // 권한 체크 여부
  bool isChecked = false;

  SampleItem(
      this.sampleItemEnum, this.sampleItemTitle, this.sampleItemDescription);
}

enum SampleItemEnum {
  pageAndRouterTestSample,
  dialogSample,
  sharedPreferencesSample,
  urlLauncherSample,
  serverSample,
  networkRequestSample,
  mobilePermissionSample,
  authSample,
  globalVariableStateTestSample,
  widgetChangeAnimationSample,
  cryptSample,
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

class BlocSampleList extends Bloc<bool, bool> {
  BlocSampleList() : super(true) {
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
    BlocProvider<BlocSampleList>(create: (context) => BlocSampleList()),
  ];
}

class BLocObjects {
  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // !!!BLoC 조작 객체 변수 선언!!
  // ex :
  // late BlocSample blocSample;
  late BlocSampleList blocSampleList;

  // 생성자 설정
  BLocObjects(this._context) {
    // !!!BLoC 조작 객체 생성!!
    // ex :
    // blocSample = BlocProvider.of<BlocSample>(_context);
    blocSampleList = BlocProvider.of<BlocSampleList>(_context);
  }
}
