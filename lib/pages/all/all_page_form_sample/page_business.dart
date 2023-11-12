// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// (page)
import 'page_entrance.dart' as page_entrance;

// (all)
import '../../../global_widgets/gw_page_out_frames.dart' as gw_page_out_frames;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../dialogs/all/all_dialog_info/page_entrance.dart'
    as all_dialog_info;

// [페이지 비즈니스 로직 및 뷰모델 작성 파일]
// Flutter 에서 값 입력 처리 방식은 여러가지인데,
// Form 형식의 데이터를 입력받는 가장 최적의 방식을 정리한 샘플입니다.
// todo : 에러 처리 개선

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 담당
// PageBusiness 인스턴스는 context 안에 저장되어, 해당 페이지가 소멸하기 전까지 활용됩니다.
class PageBusiness {
  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // BLoC 객체 모음
  late BLocObjects blocObjects;

  // 페이지 생명주기 관련 states
  var pageLifeCycleStates = gc_template_classes.PageLifeCycleStates();

  // 페이지 파라미터 (아래 goRouterState 에서 가져와 대입하기)
  late page_entrance.PageInputVo pageInputVo;

  // 페이지 뷰모델 객체
  PageViewModel pageViewModel = PageViewModel();

  // 생성자 설정
  PageBusiness(this._context);

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

    pageViewModel.inputAnythingTextFieldController.dispose();
    pageViewModel.inputAnythingTextFieldFocus.dispose();

    pageViewModel.inputAlphabetTextFieldController.dispose();
    pageViewModel.inputAlphabetTextFieldFocus.dispose();

    pageViewModel.inputNumberTextFieldController.dispose();
    pageViewModel.inputNumberTextFieldFocus.dispose();

    pageViewModel.inputSecretTextFieldController.dispose();
    pageViewModel.inputSecretTextFieldFocus.dispose();
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

  // (테스트 폼 완료)
  void completeTestForm() {
    String input1 = pageViewModel.inputAnythingTextFieldController.text;
    String input2 = pageViewModel.inputAlphabetTextFieldController.text;
    String input3 = pageViewModel.inputNumberTextFieldController.text;
    String input4 = pageViewModel.inputSecretTextFieldController.text;

    showDialog(
        barrierDismissible: true,
        context: _context,
        builder: (context) => all_dialog_info.PageEntrance(
            all_dialog_info.PageInputVo(
              "폼 입력 결과",
              "입력1 : $input1\n"
                  "입력2 : $input2\n"
                  "입력3 : $input3\n"
                  "입력4 : $input4",
              "확인",
            ),
            (pageBusiness) {}));
  }

////
// [내부 함수]
// !!!내부에서만 사용할 함수를 아래에 구현!!!
}

// (페이지 뷰 모델 클래스)
// 페이지 전역의 데이터는 여기에 정의되며, Business 인스턴스 안의 pageViewModel 변수로 저장 됩니다.
class PageViewModel {
  // 페이지 생명주기 관련 states
  var pageLifeCycleStates = gc_template_classes.PageLifeCycleStates();

  // 페이지 파라미터 (아래 goRouterState 에서 가져와 대입하기)
  late page_entrance.PageInputVo pageInputVo;

  // !!!페이지 데이터 정의!!!
  // ex :
  // int sampleNumber = 0;
  // Form 필드 전체 키
  GlobalKey<FormState> testFormKey = GlobalKey<FormState>();

  final inputAnythingTextFieldKey = GlobalKey<FormFieldState>();
  TextEditingController inputAnythingTextFieldController =
      TextEditingController();
  FocusNode inputAnythingTextFieldFocus = FocusNode();

  final inputAlphabetTextFieldKey = GlobalKey<FormFieldState>();
  TextEditingController inputAlphabetTextFieldController =
      TextEditingController();
  FocusNode inputAlphabetTextFieldFocus = FocusNode();

  final inputNumberTextFieldKey = GlobalKey<FormFieldState>();
  TextEditingController inputNumberTextFieldController =
      TextEditingController();
  FocusNode inputNumberTextFieldFocus = FocusNode();

  final inputSecretTextFieldKey = GlobalKey<FormFieldState>();
  TextEditingController inputSecretTextFieldController =
      TextEditingController();
  FocusNode inputSecretTextFieldFocus = FocusNode();
  bool inputSecretTextFieldHide = true;

  PageViewModel();
}

// (BLoC 클래스)
// ex :
// class BlocSample extends Bloc<bool, bool> {
//   // BLoC 위젯 갱신 함수
//   void refresh() {
//     add(!state);
//   }
//
//   BlocSample() : super(true) {
//     on<bool>((event, emit) {
//       emit(event);
//     });
//   }
// }

class BlocSecretTestInput extends Bloc<bool, bool> {
  // BLoC 위젯 갱신 함수
  void refresh() {
    add(!state);
  }

  BlocSecretTestInput() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
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
    BlocProvider<BlocSecretTestInput>(
        create: (context) => BlocSecretTestInput()),
  ];
}

class BLocObjects {
  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // !!!BLoC 조작 객체 변수 선언!!!
  // ex :
  // late BlocSample blocSample;
  late BlocSecretTestInput blocSecretTestInput;

  // 생성자 설정
  BLocObjects(this._context) {
    // !!!BLoC 조작 객체 생성!!!
    // ex :
    // blocSample = BlocProvider.of<BlocSample>(_context);
    blocSecretTestInput = BlocProvider.of<BlocSecretTestInput>(_context);
  }
}
