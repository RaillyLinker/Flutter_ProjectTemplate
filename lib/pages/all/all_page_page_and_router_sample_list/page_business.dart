// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:go_router/go_router.dart';

// (page)
import 'page_entrance.dart' as page_entrance;

// (all)
import '../../../global_widgets/gw_page_out_frames.dart' as gw_page_out_frames;
import '../all_page_input_and_output_push_test/page_entrance.dart'
    as all_page_input_and_output_push_test;
import '../../../pages/all/all_page_just_push_test1/page_entrance.dart'
    as all_page_just_push_test1;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../a_templates/all_page_template/page_entrance.dart'
    as all_page_template;
import '../../../pages/all/all_page_page_transition_animation_sample_list/page_entrance.dart'
    as all_page_page_transition_animation_sample_list;
import '../../../pages/all/all_page_grid_sample/page_entrance.dart'
    as all_page_grid_sample;

// [페이지 비즈니스 로직 및 뷰모델 작성 파일]
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
  }

  // (페이지 종료 or 다른 페이지로 이동 (강제 종료는 탐지 못함))
  Future<void> onPagePauseAsync() async {
    // !!!위젯 종료 및, 다른 페이지로 이동 로직 작성!!!
  }

  // (페이지 종료 (강제 종료, web 에서 브라우저 뒤로가기 버튼을 눌렀을 때는 탐지 못함))
  Future<void> onPageDestroyAsync() async {
    // !!!페이지 종료 로직 작성!!!

    // 검색창 컨트롤러 닫기
    pageViewModel.inputAndOutputFormInputValueTextFieldController.dispose();
    pageViewModel.inputAndOutputFormInputValueTextFieldFocus.dispose();
    pageViewModel.inputAndOutputFormNullableInputValueTextFieldController
        .dispose();
    pageViewModel.inputAndOutputFormNullableInputValueTextFieldFocus.dispose();
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
  Future<void> onRouteListItemClickAsync(int index) async {
    SampleItem sampleItem = pageViewModel.allSampleList[index];

    switch (sampleItem.sampleItemEnum) {
      case SampleItemEnum.pageTemplate:
        {
          _context.pushNamed(all_page_template.pageName);
        }
        break;
      case SampleItemEnum.justPushTest:
        {
          _context.pushNamed(all_page_just_push_test1.pageName);
        }
        break;
      case SampleItemEnum.inputAndOutputPushTest:
        {
          if (pageViewModel.inputAndOutputFormKey.currentState!.validate()) {
            String inputParamText = pageViewModel
                .inputAndOutputFormInputValueTextFieldController.value.text;

            String inputParamOptText = pageViewModel
                .inputAndOutputFormNullableInputValueTextFieldController
                .value
                .text;

            dynamic value;
            if (inputParamOptText == "") {
              value = await _context.pushNamed(
                  all_page_input_and_output_push_test.pageName,
                  queryParameters: {
                    "inputValueString": inputParamText,
                    "inputValueStringList": ["a", "b", "c"],
                    "inputValueInt": "1234" // int 를 원하더라도, 여기선 String 으로 줘야함
                  });
            } else {
              value = await _context.pushNamed(
                  all_page_input_and_output_push_test.pageName,
                  queryParameters: {
                    "inputValueString": inputParamText,
                    "inputValueStringOpt": inputParamOptText,
                    "inputValueStringList": ["a", "b", "c"],
                    "inputValueInt": "1234" // int 를 원하더라도, 여기선 String 으로 줘야함
                  });
            }

            all_page_input_and_output_push_test.PageOutputVo? pageResult =
                value as all_page_input_and_output_push_test.PageOutputVo?;
            // 반환 파라미터 받아서 토스트 처리
            if (pageResult == null) {
              if (!_context.mounted) return;
              showToast(
                "반환값이 없습니다.",
                context: _context,
                animation: StyledToastAnimation.scale,
              );
            } else {
              if (!_context.mounted) return;
              showToast(
                pageResult.resultValue,
                context: _context,
                animation: StyledToastAnimation.scale,
              );
            }
          }
        }
        break;
      case SampleItemEnum.pageTransitionAnimationSampleList:
        {
          _context.pushNamed(
              all_page_page_transition_animation_sample_list.pageName);
        }
        break;
      case SampleItemEnum.gridSample:
        {
          _context.pushNamed(all_page_grid_sample.pageName);
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
    allSampleList.add(
        SampleItem(SampleItemEnum.pageTemplate, "페이지 템플릿", "템플릿 페이지를 호출합니다."));
    allSampleList.add(SampleItem(SampleItemEnum.justPushTest, "페이지 Push 테스트",
        "페이지 Push 를 통한 페이지 이동을 테스트합니다."));
    allSampleList.add(SampleItem(SampleItemEnum.inputAndOutputPushTest,
        "페이지 입/출력 테스트", "페이지 Push 시에 전달하는 입력값, Pop 시에 반환하는 출력값 테스트"));
    allSampleList.add(SampleItem(
        SampleItemEnum.pageTransitionAnimationSampleList,
        "페이지 이동 애니메이션 샘플 리스트",
        "페이지 이동시 적용되는 애니메이션 샘플 리스트"));
    allSampleList.add(SampleItem(SampleItemEnum.gridSample, "페이지 Grid 샘플",
        "화면 사이즈에 따라 동적으로 변하는 Grid 페이지 샘플"));
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
      gw_page_out_frames.PageOutFrameViewModel("페이지 / 라우터 샘플 리스트");

  // (샘플 페이지 원본 리스트)
  List<SampleItem> allSampleList = [];

  // 입출력 테스트 Form 필드 전체 키
  GlobalKey<FormState> inputAndOutputFormKey = GlobalKey<FormState>();

  final inputAndOutputFormInputValueTextFieldKey = GlobalKey<FormFieldState>();
  TextEditingController inputAndOutputFormInputValueTextFieldController =
      TextEditingController();
  FocusNode inputAndOutputFormInputValueTextFieldFocus = FocusNode();

  final inputAndOutputFormNullableInputValueTextFieldKey =
      GlobalKey<FormFieldState>();
  TextEditingController
      inputAndOutputFormNullableInputValueTextFieldController =
      TextEditingController();
  FocusNode inputAndOutputFormNullableInputValueTextFieldFocus = FocusNode();
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
  pageTemplate,
  justPushTest,
  inputAndOutputPushTest,
  pageTransitionAnimationSampleList,
  gridSample,
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
