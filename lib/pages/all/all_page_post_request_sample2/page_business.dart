// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// (page)
import 'page_entrance.dart' as page_entrance;

// (all)
import '../../../global_widgets/gw_page_out_frames.dart' as gw_page_out_frames;
import '../../../../repositories/network/apis/api_main_server.dart'
    as api_main_server;
import '../../../dialogs/all/all_dialog_info/page_entrance.dart'
    as all_dialog_info;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../dialogs/all/all_dialog_loading_spinner/page_entrance.dart'
    as all_dialog_loading_spinner;

// [페이지 비즈니스 로직 및 뷰모델 작성 파일]
// todo : 입력 부분 Form 방식 변경

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

    pageViewModel.networkRequestParamTextFieldController1.dispose();
    pageViewModel.networkRequestParamTextFieldController2.dispose();
    pageViewModel.networkRequestParamTextFieldController3.dispose();
    pageViewModel.networkRequestParamTextFieldController4.dispose();
    pageViewModel.networkRequestParamTextFieldController5.dispose();
    pageViewModel.networkRequestParamTextFieldController6.dispose();
    for (TextEditingController textFieldController
        in pageViewModel.networkRequestParamTextFieldValue9) {
      textFieldController.dispose();
    }
    for (TextEditingController textFieldController
        in pageViewModel.networkRequestParamTextFieldValue10) {
      textFieldController.dispose();
    }
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

  // (리스트 파라미터 추가)
  void addNetworkRequestParamTextFieldValue9() {
    pageViewModel.networkRequestParamTextFieldValue9
        .add(TextEditingController()..text = "testString");
    blocObjects.blocNetworkRequestParamTextFieldValue9.refresh();
  }

  // (리스트 파라미터 제거)
  void deleteNetworkRequestParamTextFieldValue9(int idx) {
    pageViewModel.networkRequestParamTextFieldValue9.removeAt(idx);
    blocObjects.blocNetworkRequestParamTextFieldValue9.refresh();
  }

  // (리스트 파라미터 추가)
  void addNetworkRequestParamTextFieldValue10() {
    pageViewModel.networkRequestParamTextFieldValue10
        .add(TextEditingController()..text = "testString");
    blocObjects.blocNetworkRequestParamTextFieldValue10.refresh();
  }

  // (리스트 파라미터 제거)
  void deleteNetworkRequestParamTextFieldValue10(int idx) {
    pageViewModel.networkRequestParamTextFieldValue10.removeAt(idx);
    blocObjects.blocNetworkRequestParamTextFieldValue10.refresh();
  }

  // (네트워크 리퀘스트)
  Future<void> doNetworkRequest() async {
    // 로딩 다이얼로그 표시
    var loadingSpinnerDialog = all_dialog_loading_spinner.PageEntrance(
      all_dialog_loading_spinner.PageInputVo(),
    );

    showDialog(
        barrierDismissible: false,
        context: _context,
        builder: (context) => loadingSpinnerDialog).then((outputVo) {});

    List<String> queryParamStringList = [];
    for (TextEditingController tec
        in pageViewModel.networkRequestParamTextFieldValue9) {
      queryParamStringList.add(tec.text);
    }

    List<String>? queryParamStringListNullable;
    if (pageViewModel.networkRequestParamTextFieldValue10.isNotEmpty) {
      queryParamStringListNullable = [];
      for (TextEditingController tec
          in pageViewModel.networkRequestParamTextFieldValue10) {
        queryParamStringListNullable.add(tec.text);
      }
    }

    var response = await api_main_server
        .postService1TkV1RequestTestPostRequestXWwwFromUrlencodedAsync(api_main_server
            .PostService1TkV1RequestTestPostRequestXWwwFromUrlencodedAsyncRequestBodyVo(
                pageViewModel.networkRequestParamTextFieldController1.text,
                (pageViewModel.networkRequestParamTextFieldController2.text == "")
                    ? null
                    : pageViewModel
                        .networkRequestParamTextFieldController2.text,
                int.parse(
                    pageViewModel.networkRequestParamTextFieldController3.text),
                (pageViewModel.networkRequestParamTextFieldController4.text == "")
                    ? null
                    : int.parse(pageViewModel
                        .networkRequestParamTextFieldController4.text),
                double.parse(
                    pageViewModel.networkRequestParamTextFieldController5.text),
                (pageViewModel.networkRequestParamTextFieldController6.text ==
                        "")
                    ? null
                    : double.parse(pageViewModel
                        .networkRequestParamTextFieldController6.text),
                pageViewModel.networkRequestParamTextFieldValue7,
                pageViewModel.networkRequestParamTextFieldValue8,
                queryParamStringList,
                queryParamStringListNullable));

    // 로딩 다이얼로그 제거
    loadingSpinnerDialog.pageBusiness.closeDialog();

    if (response.dioException == null) {
      // Dio 네트워크 응답

      var networkResponseObjectOk = response.networkResponseObjectOk!;

      if (networkResponseObjectOk.responseStatusCode == 200) {
        // 정상 응답

        // 응답 body
        var responseBody = networkResponseObjectOk.responseBody
            as api_main_server
            .PostService1TkV1RequestTestPostRequestXWwwFromUrlencodedAsyncResponseBodyVo;

        // 확인 다이얼로그 호출
        if (!_context.mounted) return;
        showDialog(
            barrierDismissible: true,
            context: _context,
            builder: (context) => all_dialog_info.PageEntrance(
                  all_dialog_info.PageInputVo(
                      "응답 결과",
                      "Http Status Code : ${networkResponseObjectOk.responseStatusCode}\n\nResponse Body:\n${responseBody.toString()}",
                      "확인"),
                )).then((outputVo) {});
      } else {
        // 비정상 응답
        if (!_context.mounted) return;
        showDialog(
            barrierDismissible: false,
            context: _context,
            builder: (context) => all_dialog_info.PageEntrance(
                  all_dialog_info.PageInputVo(
                      "네트워크 에러", "네트워크 상태가 불안정합니다.\n다시 시도해주세요.", "확인"),
                ));
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
              ));
    }
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

  TextEditingController networkRequestParamTextFieldController1 =
      TextEditingController()..text = "testString";

  TextEditingController networkRequestParamTextFieldController2 =
      TextEditingController();

  TextEditingController networkRequestParamTextFieldController3 =
      TextEditingController()..text = "1";

  TextEditingController networkRequestParamTextFieldController4 =
      TextEditingController();

  TextEditingController networkRequestParamTextFieldController5 =
      TextEditingController()..text = "1.0";

  TextEditingController networkRequestParamTextFieldController6 =
      TextEditingController();

  bool networkRequestParamTextFieldValue7 = true;

  bool? networkRequestParamTextFieldValue8;

  List<TextEditingController> networkRequestParamTextFieldValue9 = [
    TextEditingController()..text = "testString"
  ];

  List<TextEditingController> networkRequestParamTextFieldValue10 = [];

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

class BlocNetworkRequestParamTextFieldValue9 extends Bloc<bool, bool> {
  // BLoC 위젯 갱신 함수
  void refresh() {
    add(!state);
  }

  BlocNetworkRequestParamTextFieldValue9() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }
}

class BlocNetworkRequestParamTextFieldValue10 extends Bloc<bool, bool> {
  // BLoC 위젯 갱신 함수
  void refresh() {
    add(!state);
  }

  BlocNetworkRequestParamTextFieldValue10() : super(true) {
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
    BlocProvider<BlocNetworkRequestParamTextFieldValue9>(
        create: (context) => BlocNetworkRequestParamTextFieldValue9()),
    BlocProvider<BlocNetworkRequestParamTextFieldValue10>(
        create: (context) => BlocNetworkRequestParamTextFieldValue10()),
  ];
}

class BLocObjects {
  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // !!!BLoC 조작 객체 변수 선언!!!
  // ex :
  // late BlocSample blocSample;
  late BlocNetworkRequestParamTextFieldValue9
      blocNetworkRequestParamTextFieldValue9;
  late BlocNetworkRequestParamTextFieldValue10
      blocNetworkRequestParamTextFieldValue10;

  // 생성자 설정
  BLocObjects(this._context) {
    // !!!BLoC 조작 객체 생성!!!
    // ex :
    // blocSample = BlocProvider.of<BlocSample>(_context);
    blocNetworkRequestParamTextFieldValue9 =
        BlocProvider.of<BlocNetworkRequestParamTextFieldValue9>(_context);
    blocNetworkRequestParamTextFieldValue10 =
        BlocProvider.of<BlocNetworkRequestParamTextFieldValue10>(_context);
  }
}
