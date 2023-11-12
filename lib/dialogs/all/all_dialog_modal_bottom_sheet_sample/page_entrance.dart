// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';

// (page)
import 'page_view.dart' as page_view;
import 'page_business.dart' as page_business;

// (all)
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;

// [페이지 진입 파일]

//------------------------------------------------------------------------------
// (페이지 호출시 필요한 입력값 데이터 형태)
// !!!페이지 입력 데이터 정의!!!
class PageInputVo {}

// (이전 페이지로 전달할 결과 데이터 형태)
// !!!페이지 반환 데이터 정의!!!
class PageOutputVo {}

//------------------------------------------------------------------------------
// 아래부터는 수정이 불필요한 코드입니다.
// 외부에서 페이지 진입시 사용(= 라우터에 등록) 하는 역할.
class PageEntrance extends StatelessWidget {
  // 페이지 진입 파라미터
  final PageInputVo _pageInputVo;

  // 페이지 생성 시점 콜백
  late page_business.PageBusiness pageBusiness;

  PageEntrance(this._pageInputVo, {super.key});

  // 화면 빌드
  @override
  Widget build(BuildContext context) {
    // BLoC Provider 리스트
    List<BlocProvider<dynamic>> blocProviders =
        page_business.BLocProviders().blocProviders;

    // pageBusiness 객체 생성
    pageBusiness = page_business.PageBusiness(context, _pageInputVo);

    // Page Info BLoC 추가 (pageBusiness 를 context 전역에 저장)
    blocProviders.add(
        BlocProvider<gc_template_classes.BlocPageInfo>(create: (innerContext) {
      // pageBusiness 내의 bloc 객체 모음 생성
      pageBusiness.blocObjects = page_business.BLocObjects(innerContext);
      return gc_template_classes.BlocPageInfo(
          gc_template_classes.BlocPageInfoState<page_business.PageBusiness>(
              pageBusiness));
    }));

    // 페이지 사용 BLoC 객체를 모두 설정
    return MultiBlocProvider(
      // 하위 위젯에서 사용할 Businesses BLoC 프로바이더 설정
      // MultiBlocProvider 을 거치지 않는다면 하위 위젯에서 BLoC 조작을 할 수 없습니다.
      providers: blocProviders,
      child: const LifecycleWatcher(),
    );
  }
}

// (페이지 생명주기 탐지용)
class LifecycleWatcher extends StatefulWidget {
  const LifecycleWatcher({super.key});

  @override
  LifecycleWatcherState createState() => LifecycleWatcherState();
}

class LifecycleWatcherState extends State<LifecycleWatcher>
    with WidgetsBindingObserver {
  // Business Logic 위임 객체
  late page_business.PageBusiness _pageBusiness;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // 발동 조건
    // Android 의 onDestroy() 와 비슷
    // mobile : history 가 둘 이상인 상태에서 pop() 사용, back 버튼으로 뒤로가기
    WidgetsBinding.instance.removeObserver(this);
    _pageBusiness.pageLifeCycleStates.isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    gc_template_classes.BlocPageInfoState blocPageInfoState =
        BlocProvider.of<gc_template_classes.BlocPageInfo>(context).state;
    _pageBusiness = blocPageInfoState.pageBusiness;

    return WillPopScope(
        onWillPop: () async {
          bool isPop = await _pageBusiness.onPageWillPopAsync();

          if (isPop) {
            // 페이지 종료(return true) 때에는, 아래 코드 실행
            if (context.mounted) {
              if (Navigator.canPop(context)) {
                _pageBusiness.pageLifeCycleStates.isCanPop = true;
              } else {
                _pageBusiness.pageLifeCycleStates.isNoCanPop = true;
              }
            }
          }

          return isPop;
        },
        // 페이지 생명주기를 Business 에 넘겨주기
        child: FocusDetector(
            // Businesses 에 focus 콜백 전달
            onFocusGained: () async {
              if (!_pageBusiness.pageLifeCycleStates.isPageCreated) {
                _pageBusiness.pageLifeCycleStates.isPageCreated = true;
                await _pageBusiness.onPageCreateAsync();
              } else {}

              await _pageBusiness.onPageResumeAsync();
            },
            onFocusLost: () async {
              if (_pageBusiness.pageLifeCycleStates.isNoCanPop) {
                await _pageBusiness.onPagePauseAsync();
                await _pageBusiness.onPageDestroyAsync();
              } else {
                await _pageBusiness.onPagePauseAsync();
              }
            },
            onVisibilityLost: () async {
              // 발동 조건
              // 위젯이 더이상 화면에서 보이지 않는 상태
              // mobile : 다른 라우트 push, pop() 사용, back 버튼으로 뒤로가기

              // isDisposed 를 그냥 사용하면 onPause 보다 빠르게 실행되므로 실행 타이밍을 뒤로 미루기 위한 로직
              if (_pageBusiness.pageLifeCycleStates.isDisposed) {
                _pageBusiness.pageLifeCycleStates.isDisposed = false;
                if (_pageBusiness.pageLifeCycleStates.isCanPop) {
                  await _pageBusiness.onPageDestroyAsync();
                }
              }
            },
            child: const page_view.PageView()));
  }
}
