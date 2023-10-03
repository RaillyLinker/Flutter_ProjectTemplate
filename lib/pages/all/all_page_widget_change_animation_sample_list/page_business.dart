// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// (page)
import 'page_entrance.dart' as page_entrance;

// (all)
import '../../../global_classes/gc_my_classes.dart' as gc_my_classes;
import '../../../global_functions/gf_my_functions.dart' as gf_my_functions;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../global_classes/gc_animated_builder.dart'
    as gc_animated_builder;

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
  PageBusiness(this._context, GoRouterState goRouterState) {
    pageViewModel = PageViewModel(goRouterState);
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
      case SampleItemEnum.noAnimation:
        {
          // 애니메이션 없음

          int sampleWidgetKeyValue = int.parse(
              gf_my_functions.getWidgetKeyValue(pageViewModel.sampleWidget)!);
          if (pageViewModel.sampleWidgetEnum ==
              SampleWidgetEnum.blueCircleWidget) {
            pageViewModel.sampleWidgetEnum =
                SampleWidgetEnum.greenRoundSquareWidget;
            pageViewModel.sampleWidget = Container(
              // 애니메이션을 적용하려면 적용되는 위젯의 key 가 이전과 달라야 함
              key: ValueKey<int>(sampleWidgetKeyValue + 1),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(30.0),
              ),
              width: 100.0,
              height: 100.0,
            );
          } else if (pageViewModel.sampleWidgetEnum ==
              SampleWidgetEnum.greenRoundSquareWidget) {
            pageViewModel.sampleWidgetEnum = SampleWidgetEnum.redSquareWidget;
            pageViewModel.sampleWidget = Container(
              // 애니메이션을 적용하려면 적용되는 위젯의 key 가 이전과 달라야 함
              key: ValueKey<int>(sampleWidgetKeyValue + 1),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(0.0),
              ),
              width: 100.0,
              height: 100.0,
            );
          } else {
            pageViewModel.sampleWidgetEnum = SampleWidgetEnum.blueCircleWidget;
            pageViewModel.sampleWidget = Container(
              // 애니메이션을 적용하려면 적용되는 위젯의 key 가 이전과 달라야 함
              key: ValueKey<int>(sampleWidgetKeyValue + 1),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(50.0),
              ),
              width: 100.0,
              height: 100.0,
            );
          }

          pageViewModel.widgetChangeAnimatedSwitcherConfig =
              gc_my_classes.AnimatedSwitcherConfig(
                  const Duration(milliseconds: 0));
          blocObjects.blocAnimationSample
              .add(!blocObjects.blocAnimationSample.state);
        }
        break;
      case SampleItemEnum.fadeAnimation:
        {
          // Fade 애니메이션 적용

          int sampleWidgetKeyValue = int.parse(
              gf_my_functions.getWidgetKeyValue(pageViewModel.sampleWidget)!);
          if (pageViewModel.sampleWidgetEnum ==
              SampleWidgetEnum.blueCircleWidget) {
            pageViewModel.sampleWidgetEnum =
                SampleWidgetEnum.greenRoundSquareWidget;
            pageViewModel.sampleWidget = Container(
              // 애니메이션을 적용하려면 적용되는 위젯의 key 가 이전과 달라야 함
              key: ValueKey<int>(sampleWidgetKeyValue + 1),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(30.0),
              ),
              width: 100.0,
              height: 100.0,
            );
          } else if (pageViewModel.sampleWidgetEnum ==
              SampleWidgetEnum.greenRoundSquareWidget) {
            pageViewModel.sampleWidgetEnum = SampleWidgetEnum.redSquareWidget;
            pageViewModel.sampleWidget = Container(
              // 애니메이션을 적용하려면 적용되는 위젯의 key 가 이전과 달라야 함
              key: ValueKey<int>(sampleWidgetKeyValue + 1),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(0.0),
              ),
              width: 100.0,
              height: 100.0,
            );
          } else {
            pageViewModel.sampleWidgetEnum = SampleWidgetEnum.blueCircleWidget;
            pageViewModel.sampleWidget = Container(
              // 애니메이션을 적용하려면 적용되는 위젯의 key 가 이전과 달라야 함
              key: ValueKey<int>(sampleWidgetKeyValue + 1),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(50.0),
              ),
              width: 100.0,
              height: 100.0,
            );
          }

          pageViewModel.widgetChangeAnimatedSwitcherConfig =
              gc_my_classes.AnimatedSwitcherConfig(
                  const Duration(
                    milliseconds: 500,
                  ), transitionBuilder:
                      (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          });
          blocObjects.blocAnimationSample
              .add(!blocObjects.blocAnimationSample.state);
        }
        break;
      case SampleItemEnum.scaleTransition:
        {
          // Fade 애니메이션 적용

          int sampleWidgetKeyValue = int.parse(
              gf_my_functions.getWidgetKeyValue(pageViewModel.sampleWidget)!);
          if (pageViewModel.sampleWidgetEnum ==
              SampleWidgetEnum.blueCircleWidget) {
            pageViewModel.sampleWidgetEnum =
                SampleWidgetEnum.greenRoundSquareWidget;
            pageViewModel.sampleWidget = Container(
              // 애니메이션을 적용하려면 적용되는 위젯의 key 가 이전과 달라야 함
              key: ValueKey<int>(sampleWidgetKeyValue + 1),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(30.0),
              ),
              width: 100.0,
              height: 100.0,
            );
          } else if (pageViewModel.sampleWidgetEnum ==
              SampleWidgetEnum.greenRoundSquareWidget) {
            pageViewModel.sampleWidgetEnum = SampleWidgetEnum.redSquareWidget;
            pageViewModel.sampleWidget = Container(
              // 애니메이션을 적용하려면 적용되는 위젯의 key 가 이전과 달라야 함
              key: ValueKey<int>(sampleWidgetKeyValue + 1),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(0.0),
              ),
              width: 100.0,
              height: 100.0,
            );
          } else {
            pageViewModel.sampleWidgetEnum = SampleWidgetEnum.blueCircleWidget;
            pageViewModel.sampleWidget = Container(
              // 애니메이션을 적용하려면 적용되는 위젯의 key 가 이전과 달라야 함
              key: ValueKey<int>(sampleWidgetKeyValue + 1),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(50.0),
              ),
              width: 100.0,
              height: 100.0,
            );
          }

          pageViewModel.widgetChangeAnimatedSwitcherConfig =
              gc_my_classes.AnimatedSwitcherConfig(
                  const Duration(
                    milliseconds: 500,
                  ), transitionBuilder:
                      (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          });
          blocObjects.blocAnimationSample
              .add(!blocObjects.blocAnimationSample.state);
        }
        break;
      case SampleItemEnum.flipAnimation:
        {
          // Flip 애니메이션 적용

          int sampleWidgetKeyValue = int.parse(
              gf_my_functions.getWidgetKeyValue(pageViewModel.sampleWidget)!);
          if (pageViewModel.sampleWidgetEnum ==
              SampleWidgetEnum.redSquareWidget) {
            pageViewModel.sampleWidgetEnum = SampleWidgetEnum.blueSquareWidget;
            pageViewModel.sampleWidget = Container(
              // 애니메이션을 적용하려면 적용되는 위젯의 key 가 이전과 달라야 함
              key: ValueKey<int>(sampleWidgetKeyValue + 1),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(0.0),
              ),
              width: 100.0,
              height: 100.0,
            );
          } else {
            pageViewModel.sampleWidgetEnum = SampleWidgetEnum.redSquareWidget;
            pageViewModel.sampleWidget = Container(
              // 애니메이션을 적용하려면 적용되는 위젯의 key 가 이전과 달라야 함
              key: ValueKey<int>(sampleWidgetKeyValue + 1),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(0.0),
              ),
              width: 100.0,
              height: 100.0,
            );
          }

          pageViewModel.widgetChangeAnimatedSwitcherConfig =
              gc_my_classes.AnimatedSwitcherConfig(
                  const Duration(
                    milliseconds: 500,
                  ), transitionBuilder:
                      (Widget child, Animation<double> animation) {
            return gc_animated_builder.wrapAnimatedBuilder(child, animation);
          });
          blocObjects.blocAnimationSample
              .add(!blocObjects.blocAnimationSample.state);
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
  GoRouterState goRouterState;

  // !!!페이지 데이터 정의!!
  // ex :
  // int sampleNumber = 0;

  // (샘플 페이지 원본 리스트)
  List<SampleItem> allSampleList = [];

  // 샘플 위젯 타입 (0, 1, 2)
  SampleWidgetEnum sampleWidgetEnum = SampleWidgetEnum.blueCircleWidget;

  // 현재 적용중인 샘플 위젯
  Widget sampleWidget = Container(
    key: const ValueKey<int>(0),
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(50.0),
    ),
    width: 100.0,
    height: 100.0,
  );

  // 위젯 변경 애니메이션
  gc_my_classes.AnimatedSwitcherConfig widgetChangeAnimatedSwitcherConfig =
      gc_my_classes.AnimatedSwitcherConfig(
          const Duration(
            milliseconds: 0,
          ), transitionBuilder: (Widget child, Animation<double> animation) {
    return FadeTransition(opacity: animation, child: child);
  });

  PageViewModel(this.goRouterState) {
    // 초기 리스트 추가
    allSampleList.add(SampleItem(
        SampleItemEnum.noAnimation, "애니메이션 없음", "애니메이션을 적용하지 않고 위젯 변경"));
    allSampleList.add(SampleItem(
        SampleItemEnum.fadeAnimation, "Fade 애니메이션", "Fade 애니메이션을 적용하고 위젯 변경"));
    allSampleList.add(SampleItem(SampleItemEnum.scaleTransition,
        "Scale Transition 애니메이션", "Scale Transition 애니메이션을 적용하고 위젯 변경"));
    allSampleList.add(SampleItem(
        SampleItemEnum.flipAnimation, "Flip 애니메이션", "Flip 애니메이션을 적용하고 위젯 변경"));
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
  noAnimation,
  fadeAnimation,
  scaleTransition,
  flipAnimation
}

enum SampleWidgetEnum {
  blueCircleWidget,
  greenRoundSquareWidget,
  redSquareWidget,
  blueSquareWidget,
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

// (애니메이션 적용 샘플 위젯)
class BlocAnimationSample extends Bloc<bool, bool> {
  BlocAnimationSample() : super(true) {
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
    BlocProvider<BlocAnimationSample>(
        create: (context) => BlocAnimationSample()),
  ];
}

class BLocObjects {
  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // !!!BLoC 조작 객체 변수 선언!!
  // ex :
  // late BlocSample blocSample;
  late BlocSampleList blocSampleList;
  late BlocAnimationSample blocAnimationSample;

  // 생성자 설정
  BLocObjects(this._context) {
    // !!!BLoC 조작 객체 생성!!
    // ex :
    // blocSample = BlocProvider.of<BlocSample>(_context);
    blocSampleList = BlocProvider.of<BlocSampleList>(_context);
    blocAnimationSample = BlocProvider.of<BlocAnimationSample>(_context);
  }
}