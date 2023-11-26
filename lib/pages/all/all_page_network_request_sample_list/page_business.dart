// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// (page)
import 'page_entrance.dart' as page_entrance;

// (all)
import '../../../global_widgets/gw_page_outer_frame/widget_business.dart'
    as gw_page_outer_frame_business;
import '../../../dialogs/all/all_dialog_info/widget_view.dart'
    as all_dialog_info_view;
import '../../../dialogs/all/all_dialog_info/widget_business.dart'
    as all_dialog_info_business;
import '../../../dialogs/all/all_dialog_loading_spinner/page_entrance.dart'
    as all_dialog_loading_spinner;
import '../../../../repositories/network/apis/api_main_server.dart'
    as api_main_server;
import '../../../pages/all/all_page_get_request_sample/page_entrance.dart'
    as all_page_get_request_sample;
import '../../../pages/all/all_page_post_request_sample1/page_entrance.dart'
    as all_page_post_request_sample1;
import '../../../pages/all/all_page_post_request_sample2/page_entrance.dart'
    as all_page_post_request_sample2;
import '../../../pages/all/all_page_post_request_sample3/page_entrance.dart'
    as all_page_post_request_sample3;
import '../../../pages/all/all_page_post_request_sample4/page_entrance.dart'
    as all_page_post_request_sample4;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;

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
  Future<void> onRouteListItemClick(int index) async {
    SampleItem sampleItem = pageViewModel.allSampleList[index];

    switch (sampleItem.sampleItemEnum) {
      case SampleItemEnum.getRequestSample:
        {
          _context.pushNamed(all_page_get_request_sample.pageName);
        }
        break;
      case SampleItemEnum.postRequestSample1:
        {
          _context.pushNamed(all_page_post_request_sample1.pageName);
        }
        break;
      case SampleItemEnum.postRequestSample2:
        {
          _context.pushNamed(all_page_post_request_sample2.pageName);
        }
        break;
      case SampleItemEnum.postRequestSample3:
        {
          _context.pushNamed(all_page_post_request_sample3.pageName);
        }
        break;
      case SampleItemEnum.postRequestSample4:
        {
          _context.pushNamed(all_page_post_request_sample4.pageName);
        }
        break;
      case SampleItemEnum.postReceiveErrorSample:
        {
          // 로딩 다이얼로그 표시
          var loadingSpinnerDialog = all_dialog_loading_spinner.PageEntrance(
            all_dialog_loading_spinner.PageInputVo(),
          );

          showDialog(
              barrierDismissible: false,
              context: _context,
              builder: (context) => loadingSpinnerDialog).then((outputVo) {});

          var response = await api_main_server
              .postService1TkV1RequestTestGenerateErrorAsync();

          // 로딩 다이얼로그 제거
          loadingSpinnerDialog.pageBusiness.closeDialog();

          if (response.dioException == null) {
            // Dio 네트워크 응답

            // (확인 다이얼로그 호출)
            var allDialogInfoBusiness =
                all_dialog_info_business.WidgetBusiness();
            if (!_context.mounted) return;
            showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_info_view.WidgetView(
                      business: allDialogInfoBusiness,
                      inputVo: all_dialog_info_view.InputVo(
                          dialogTitle: "응답 결과",
                          dialogContent:
                              "Http Status Code : ${response.networkResponseObjectOk!.responseStatusCode}\n\nResponse Body:\n${response.networkResponseObjectOk!.responseBody}",
                          checkBtnTitle: "확인"),
                      onDialogCreated: () {},
                    )).then((outputVo) {});
          } else {
            // Dio 네트워크 에러
            var allDialogInfoBusiness =
                all_dialog_info_business.WidgetBusiness();
            if (!_context.mounted) return;
            showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_info_view.WidgetView(
                      business: allDialogInfoBusiness,
                      inputVo: const all_dialog_info_view.InputVo(
                          dialogTitle: "네트워크 에러",
                          dialogContent: "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                          checkBtnTitle: "확인"),
                      onDialogCreated: () {},
                    ));
          }
        }
        break;
      case SampleItemEnum.getStringResponseSample:
        {
          // 로딩 다이얼로그 표시
          var loadingSpinnerDialog = all_dialog_loading_spinner.PageEntrance(
            all_dialog_loading_spinner.PageInputVo(),
          );

          showDialog(
              barrierDismissible: false,
              context: _context,
              builder: (context) => loadingSpinnerDialog).then((outputVo) {});

          var response = await api_main_server
              .getService1TkV1RequestTestReturnTextStringAsync();

          // 로딩 다이얼로그 제거
          loadingSpinnerDialog.pageBusiness.closeDialog();

          if (response.dioException == null) {
            // Dio 네트워크 응답

            var networkResponseObjectOk = response.networkResponseObjectOk!;

            if (networkResponseObjectOk.responseStatusCode == 200) {
              // 정상 응답

              // 응답 body
              var responseBodyString =
                  networkResponseObjectOk.responseBody as String;

              // 확인 다이얼로그 호출
              var allDialogInfoBusiness =
                  all_dialog_info_business.WidgetBusiness();
              if (!_context.mounted) return;
              showDialog(
                  barrierDismissible: true,
                  context: _context,
                  builder: (context) => all_dialog_info_view.WidgetView(
                        business: allDialogInfoBusiness,
                        inputVo: all_dialog_info_view.InputVo(
                            dialogTitle: "응답 결과",
                            dialogContent:
                                "Http Status Code : ${networkResponseObjectOk.responseStatusCode}\n\nResponse Body:\n$responseBodyString",
                            checkBtnTitle: "확인"),
                        onDialogCreated: () {},
                      )).then((outputVo) {});
            } else {
              // 비정상 응답
              var allDialogInfoBusiness =
                  all_dialog_info_business.WidgetBusiness();
              if (!_context.mounted) return;
              showDialog(
                  barrierDismissible: false,
                  context: _context,
                  builder: (context) => all_dialog_info_view.WidgetView(
                        business: allDialogInfoBusiness,
                        inputVo: const all_dialog_info_view.InputVo(
                            dialogTitle: "네트워크 에러",
                            dialogContent: "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                            checkBtnTitle: "확인"),
                        onDialogCreated: () {},
                      ));
            }
          } else {
            // Dio 네트워크 에러
            var allDialogInfoBusiness =
                all_dialog_info_business.WidgetBusiness();
            if (!_context.mounted) return;
            showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_info_view.WidgetView(
                      business: allDialogInfoBusiness,
                      inputVo: const all_dialog_info_view.InputVo(
                          dialogTitle: "네트워크 에러",
                          dialogContent: "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                          checkBtnTitle: "확인"),
                      onDialogCreated: () {},
                    ));
          }
        }
        break;
      case SampleItemEnum.getHtmlResponseSample:
        {
          // 로딩 다이얼로그 표시
          var loadingSpinnerDialog = all_dialog_loading_spinner.PageEntrance(
            all_dialog_loading_spinner.PageInputVo(),
          );

          showDialog(
              barrierDismissible: false,
              context: _context,
              builder: (context) => loadingSpinnerDialog).then((outputVo) {});

          var response = await api_main_server
              .getService1TkV1RequestTestReturnTextHtmlAsync();

          // 로딩 다이얼로그 제거
          loadingSpinnerDialog.pageBusiness.closeDialog();

          if (response.dioException == null) {
            // Dio 네트워크 응답

            var networkResponseObjectOk = response.networkResponseObjectOk!;

            if (networkResponseObjectOk.responseStatusCode == 200) {
              // 정상 응답

              // 응답 body
              var responseBodyHtml =
                  networkResponseObjectOk.responseBody as String;

              // 확인 다이얼로그 호출
              var allDialogInfoBusiness =
                  all_dialog_info_business.WidgetBusiness();
              if (!_context.mounted) return;
              showDialog(
                  barrierDismissible: true,
                  context: _context,
                  builder: (context) => all_dialog_info_view.WidgetView(
                        business: allDialogInfoBusiness,
                        inputVo: all_dialog_info_view.InputVo(
                            dialogTitle: "응답 결과",
                            dialogContent:
                                "Http Status Code : ${networkResponseObjectOk.responseStatusCode}\n\nResponse Body:\n$responseBodyHtml",
                            checkBtnTitle: "확인"),
                        onDialogCreated: () {},
                      )).then((outputVo) {});
            } else {
              // 비정상 응답
              var allDialogInfoBusiness =
                  all_dialog_info_business.WidgetBusiness();
              if (!_context.mounted) return;
              showDialog(
                  barrierDismissible: false,
                  context: _context,
                  builder: (context) => all_dialog_info_view.WidgetView(
                        business: allDialogInfoBusiness,
                        inputVo: const all_dialog_info_view.InputVo(
                            dialogTitle: "네트워크 에러",
                            dialogContent: "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                            checkBtnTitle: "확인"),
                        onDialogCreated: () {},
                      ));
            }
          } else {
            // Dio 네트워크 에러
            var allDialogInfoBusiness =
                all_dialog_info_business.WidgetBusiness();
            if (!_context.mounted) return;
            showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_info_view.WidgetView(
                      business: allDialogInfoBusiness,
                      inputVo: const all_dialog_info_view.InputVo(
                          dialogTitle: "네트워크 에러",
                          dialogContent: "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                          checkBtnTitle: "확인"),
                      onDialogCreated: () {},
                    ));
          }
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
    allSampleList.add(SampleItem(SampleItemEnum.getRequestSample,
        "Get 메소드 요청 샘플", "Get 요청 테스트 (Query Parameter)"));
    allSampleList.add(SampleItem(SampleItemEnum.postRequestSample1,
        "Post 메소드 요청 샘플 1 (application/json)", "Post 요청 테스트 (Request Body)"));
    allSampleList.add(SampleItem(
        SampleItemEnum.postRequestSample2,
        "Post 메소드 요청 샘플 2 (x-www-form-urlencoded)",
        "Post 메소드 요청 테스트 (x-www-form-urlencoded)"));
    allSampleList.add(SampleItem(
        SampleItemEnum.postRequestSample3,
        "Post 메소드 요청 샘플 3 (multipart/form-data)",
        "Post 메소드 요청 테스트 (multipart/form-data)"));
    allSampleList.add(SampleItem(
        SampleItemEnum.postRequestSample4,
        "Post 메소드 요청 샘플 4 (multipart/form-data - JsonString)",
        "Post 메소드 요청 JsonString Parameter (multipart/form-data)"));
    allSampleList.add(SampleItem(SampleItemEnum.postReceiveErrorSample,
        "Post 메소드 에러 발생 샘플", "에러 발생시의 신호를 응답하는 Post 메소드 샘플"));
    allSampleList.add(SampleItem(SampleItemEnum.getStringResponseSample,
        "Get 메소드 String 응답 샘플", "String 을 반환하는 Get 메소드 샘플"));
    allSampleList.add(SampleItem(SampleItemEnum.getHtmlResponseSample,
        "Get 메소드 Html 응답 샘플", "HTML String 을 반환하는 Get 메소드 샘플"));
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
  gw_page_outer_frame_business.WidgetBusiness pageOutFrameBusiness =
      gw_page_outer_frame_business.WidgetBusiness();

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
  getRequestSample,
  postRequestSample1,
  postRequestSample2,
  postRequestSample3,
  postRequestSample4,
  postReceiveErrorSample,
  getStringResponseSample,
  getHtmlResponseSample,
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
