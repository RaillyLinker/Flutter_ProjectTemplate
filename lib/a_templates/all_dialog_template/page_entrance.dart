// (external)
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';

// (page)
import 'page_view.dart' as page_view;
import 'page_business.dart' as page_business;

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
// ignore: must_be_immutable
class PageEntrance extends StatefulWidget {
  PageEntrance({super.key, required this.pageInputVo});

  // 페이지 진입 파라미터
  final PageInputVo pageInputVo;

  // 페이지 비즈니스 객체
  late page_business.PageBusiness pageBusiness;

  @override
  PageEntranceState createState() => PageEntranceState();
}

class PageEntranceState extends State<PageEntrance>
    with WidgetsBindingObserver {
  // 페이지 비즈니스 객체
  late page_business.PageBusiness pageBusiness;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    pageBusiness = page_business.PageBusiness(
        context: context, pageInputVo: widget.pageInputVo);
    widget.pageBusiness = pageBusiness;

    pageBusiness.onPageInit();
  }

  @override
  void dispose() {
    // 발동 조건
    // Android 의 onDestroy() 와 비슷
    // mobile : history 가 둘 이상인 상태에서 pop() 사용, back 버튼으로 뒤로가기
    WidgetsBinding.instance.removeObserver(this);
    pageBusiness.onPageDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: pageBusiness.pageCanPop,
        // 페이지 생명주기를 Business 에 넘겨주기
        child: FocusDetector(
            onFocusGained: () {
              pageBusiness.onPageFocusGained();
            },
            onFocusLost: () {
              pageBusiness.onPageFocusLost();
            },
            onVisibilityGained: () {
              pageBusiness.onPageVisibilityGained();
            },
            onVisibilityLost: () {
              pageBusiness.onPageVisibilityLost();
            },
            onForegroundGained: () {
              pageBusiness.onPageForegroundGained();
            },
            onForegroundLost: () {
              pageBusiness.onPageForegroundLost();
            },
            child: page_view.PageView(pageBusiness: pageBusiness)));
  }
}
