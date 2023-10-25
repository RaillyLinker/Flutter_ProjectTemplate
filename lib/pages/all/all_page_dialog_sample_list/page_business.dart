// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:go_router/go_router.dart';

// (page)
import 'page_entrance.dart' as page_entrance;

// (all)
import '../../../dialogs/all/all_dialog_info/page_entrance.dart'
    as all_dialog_info;
import '../../../a_templates/all_dialog_template/page_entrance.dart'
    as all_dialog_template;
import '../../../dialogs/all/all_dialog_yes_or_no/page_entrance.dart'
    as all_dialog_yes_or_no;
import '../../../dialogs/all/all_dialog_loading_spinner/page_entrance.dart'
    as all_dialog_loading_spinner;
import '../../../dialogs/all/all_dialog_modal_bottom_sheet_sample/page_entrance.dart'
    as all_dialog_modal_bottom_sheet_sample;
import '../../../dialogs/all/all_dialog_dialog_in_dialog/page_entrance.dart'
    as all_dialog_dialog_in_dialog;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../dialogs/all/all_dialog_context_menu_sample/page_entrance.dart'
    as all_dialog_context_menu_sample;

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
  PageBusiness(this._context) {
    pageViewModel = PageViewModel();
  }

  ////
  // [페이지 생명주기]
  // - 페이지 최초 실행 : onPageCreateAsync -> onPageResumeAsync
  // - 다른 페이지 호출 / 복귀, 화면 끄기 / 켜기, 모바일에서 다른 앱으로 이동 및 복귀시 :
  // onPagePauseAsync -> onPageResumeAsync -> onPagePauseAsync -> onPageResumeAsync 반복
  // - 페이지 종료 : onPageWillPopAsync -(return true 일 때)-> onPagePauseAsync -> onPageDestroyAsync 실행

  // (onPageCreateAsync 실행 전 PageInputVo 체크)
  // onPageCreateAsync 과 완전히 동일하나, 입력값 체크만을 위해 분리한 생명주기
  Future<void> onCheckPageInputVoAsync(GoRouterState goRouterState) async {
    // !!!pageInputVo 체크!!
    // ex :
    // if (!goRouterState.uri.queryParameters
    //     .containsKey("inputValueString")) {
    //   // 필수 파라미터가 없는 경우에 대한 처리
    // }

    // !!!PageInputVo 입력!!
    pageViewModel.pageInputVo = page_entrance.PageInputVo();
  }

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

  // (리스트 아이템 클릭 리스너)
  void onRouteListItemClick(int index) {
    SampleItem sampleItem = pageViewModel.allSampleList[index];

    switch (sampleItem.sampleItemEnum) {
      case SampleItemEnum.dialogTemplate:
        {
          // (템플릿 다이얼로그 호출)
          showDialog(
                  barrierDismissible: true,
                  context: _context,
                  builder: (context) => all_dialog_template.PageEntrance(
                      all_dialog_template.PageInputVo(), (pageBusiness) {}))
              .then((outputVo) {});
        }
        break;
      case SampleItemEnum.infoDialog:
        {
          // (확인 다이얼로그 호출)
          showDialog(
              barrierDismissible: true,
              context: _context,
              builder: (context) => all_dialog_info.PageEntrance(
                  all_dialog_info.PageInputVo(
                      "확인 다이얼로그", "확인 다이얼로그를 호출했습니다.", "확인"),
                  (pageBusiness) {})).then((outputVo) {});
        }
        break;
      case SampleItemEnum.yesOrNoDialog:
        {
          // (선택 다이얼로그 호출)
          showDialog(
              barrierDismissible: true,
              context: _context,
              builder: (context) => all_dialog_yes_or_no.PageEntrance(
                  all_dialog_yes_or_no.PageInputVo("예/아니오 다이얼로그",
                      "예/아니오 다이얼로그를 호출했습니다.\n예, 혹은 아니오 버튼을 누르세요.", "예", "아니오"),
                  (pageBusiness) {})).then((outputVo) {
            if (outputVo == null) {
              // 아무것도 누르지 않았을 때
              showToast(
                "아무것도 누르지 않았습니다.",
                context: _context,
                animation: StyledToastAnimation.scale,
              );
            } else if (!outputVo.checkPositiveBtn) {
              // negative 버튼을 눌렀을 때
              showToast(
                "아니오 선택",
                context: _context,
                animation: StyledToastAnimation.scale,
              );
            } else {
              // positive 버튼을 눌렀을 때
              showToast(
                "예 선택",
                context: _context,
                animation: StyledToastAnimation.scale,
              );
            }
          });
        }
        break;
      case SampleItemEnum.loadingSpinnerDialog:
        {
          // (로딩 스피너 다이얼로그 호출)
          var loadingSpinner = all_dialog_loading_spinner.PageEntrance(
              all_dialog_loading_spinner.PageInputVo(), (pageBusiness) {
            // 3초 후 닫힘
            Future.delayed(const Duration(seconds: 2)).then((value) {
              pageBusiness.closeDialog();
            });
          });

          showDialog(
              barrierDismissible: false,
              context: _context,
              builder: (context) => loadingSpinner).then((outputVo) {});
        }
        break;
      case SampleItemEnum.modalBottomSheetDialog:
        {
          // Bottom Sheet 다이얼로그 테스트
          // 일반 다이얼로그 위젯에 호출만 showModalBottomSheet 로 하면 됩니다.
          // BS 다이얼로그는 무조건 width 가 Max 입니다.

          showModalBottomSheet<void>(
            constraints: const BoxConstraints(minWidth: double.infinity),
            context: _context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            // 슬라이드 가능여부
            builder: (context) =>
                all_dialog_modal_bottom_sheet_sample.PageEntrance(
                    all_dialog_modal_bottom_sheet_sample.PageInputVo(),
                    (pageBusiness) {}),
          ).then((outputVo) {});
        }
        break;
      case SampleItemEnum.dialogInDialog:
        {
          // 다이얼로그에서 다른 다이얼로그를 호출하는 샘플
          showDialog(
              barrierDismissible: true,
              context: _context,
              builder: (context) => all_dialog_dialog_in_dialog.PageEntrance(
                  all_dialog_dialog_in_dialog.PageInputVo(),
                  (pageBusiness) {})).then((outputVo) {});
        }
        break;
      case SampleItemEnum.dialogOutsideColorSample:
        {
          // 다이얼로그 외부 색 설정
          showDialog(
                  barrierDismissible: true,
                  context: _context,
                  barrierColor: Colors.blue.withOpacity(0.5),
                  builder: (context) => all_dialog_template.PageEntrance(
                      all_dialog_template.PageInputVo(), (pageBusiness) {}))
              .then((outputVo) {});
        }
        break;
      case SampleItemEnum.contextMenuSample:
        {
          // 다이얼로그 외부 색 설정
          showDialog(
              barrierDismissible: true,
              context: _context,
              builder: (context) => all_dialog_context_menu_sample.PageEntrance(
                  all_dialog_context_menu_sample.PageInputVo(),
                  (pageBusiness) {})).then((outputVo) {});
        }
        break;
    }
  }

////
// [내부 함수]
// !!!내부에서만 사용할 함수를 아래에 구현!!
}

// (페이지 뷰 모델 데이터 형태)
// 페이지의 모든 화면 관련 데이터는 여기에 정의되며, Business 인스턴스 안에 객체로 저장 됩니다.
class PageViewModel {
  // 페이지 생명주기 관련 states
  var pageLifeCycleStates = gc_template_classes.PageLifeCycleStates();

  // 페이지 파라미터 (아래 goRouterState 에서 가져와 대입하기)
  late page_entrance.PageInputVo pageInputVo;

  // !!!페이지 데이터 정의!!
  // ex :
  // int sampleNumber = 0;

  // (샘플 페이지 원본 리스트)
  List<SampleItem> allSampleList = [];

  PageViewModel() {
    // 초기 리스트 추가
    allSampleList.add(SampleItem(
        SampleItemEnum.dialogTemplate, "다이얼로그 템플릿", "템플릿 다이얼로그를 호출합니다."));
    allSampleList.add(SampleItem(
        SampleItemEnum.infoDialog, "확인 다이얼로그", "버튼이 하나인 확인 다이얼로그를 호출합니다."));
    allSampleList.add(SampleItem(
        SampleItemEnum.yesOrNoDialog, "예/아니오 다이얼로그", "버튼이 두개인 다이얼로그를 호출합니다."));
    allSampleList.add(SampleItem(SampleItemEnum.loadingSpinnerDialog,
        "로딩 스피너 다이얼로그", "로딩 스피너 다이얼로그를 호출하고 2초 후 종료합니다."));
    allSampleList.add(SampleItem(SampleItemEnum.modalBottomSheetDialog,
        "아래에 붙은 다이얼로그", "아래에서 올라오는 다이얼로그를 호출합니다."));
    allSampleList.add(SampleItem(SampleItemEnum.dialogInDialog, "다이얼로그 속 다이얼로그",
        "다이얼로그에서 다이얼로그를 호출합니다."));
    allSampleList.add(SampleItem(SampleItemEnum.dialogOutsideColorSample,
        "다이얼로그 외부 색 설정", "다이얼로그 영역 바깥의 색상을 지정합니다."));
    allSampleList.add(SampleItem(SampleItemEnum.contextMenuSample, "컨텍스트 메뉴 샘플",
        "다이얼로그에서 컨텍스트 메뉴를 사용하는 샘플"));
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
  dialogTemplate,
  infoDialog,
  yesOrNoDialog,
  loadingSpinnerDialog,
  modalBottomSheetDialog,
  dialogInDialog,
  dialogOutsideColorSample,
  contextMenuSample,
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
