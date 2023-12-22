// (external)
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

// (inner_folder)
import 'main_business.dart' as main_business;

// (all)
import 'package:flutter_project_template/global_widgets/gw_sfw_wrapper.dart'
    as gw_sfw_wrapper;
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;

// [위젯 뷰]

//------------------------------------------------------------------------------
// !!!페이지 진입 라우트 Name 정의!!! - 폴더명과 동일하게 작성하세요.
const pageName = "app_page_init_splash";

// !!!페이지 호출/반납 애니메이션!!! - 동적으로 변경이 가능합니다.
Widget Function(BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child)
    pageTransitionsBuilder = (context, animation, secondaryAnimation, child) {
  return FadeTransition(opacity: animation, child: child);
};

// (입력 데이터)
class InputVo {
  // !!!위젯 입력값 선언!!!
  const InputVo();
}

// (결과 데이터)
class OutputVo {
  // !!!위젯 출력값 선언!!!
  const OutputVo();
}

//------------------------------------------------------------------------------
class MainWidget extends StatefulWidget {
  const MainWidget({super.key, required this.goRouterState});

  final GoRouterState goRouterState;

  @override
  MainWidgetState createState() => MainWidgetState();
}

class MainWidgetState extends State<MainWidget> with WidgetsBindingObserver {
  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    mainBusiness.mainContext = context;
    mainBusiness.refreshUi = refreshUi;
    if (mainBusiness.pageInitFirst) {
      mainBusiness.pageInitFirst = false;
      mainBusiness.onCreate();
    }
    return PopScope(
      canPop: mainBusiness.canPop,
      child: FocusDetector(
        onFocusGained: () async {
          await mainBusiness.onFocusGainedAsync();
        },
        onFocusLost: () async {
          await mainBusiness.onFocusLostAsync();
        },
        onVisibilityGained: () async {
          await mainBusiness.onVisibilityGainedAsync();
        },
        onVisibilityLost: () async {
          await mainBusiness.onVisibilityLostAsync();
        },
        onForegroundGained: () async {
          await mainBusiness.onForegroundGainedAsync();
        },
        onForegroundLost: () async {
          await mainBusiness.onForegroundLostAsync();
        },
        child: getScreenWidget(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    mainBusiness.mainContext = context;
    mainBusiness.refreshUi = refreshUi;
    final InputVo? inputVo =
        mainBusiness.onCheckPageInputVo(goRouterState: widget.goRouterState);
    if (inputVo == null) {
      mainBusiness.inputError = true;
    } else {
      mainBusiness.inputVo = inputVo;
    }
    mainBusiness.initState();
  }

  @override
  void dispose() {
    mainBusiness.mainContext = context;
    mainBusiness.refreshUi = refreshUi;
    mainBusiness.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // [public 변수]
  // (mainBusiness) - 데이터 변수 및 함수 저장 역할
  final main_business.MainBusiness mainBusiness = main_business.MainBusiness();

  //----------------------------------------------------------------------------
  // !!!위젯 관련 함수는 이 곳에서 저장 하여 사용 하세요.!!!
  // [public 함수]
  // (MainWidget Refresh 함수)
  void refreshUi() {
    setState(() {});
  }

  // [private 함수]

  //----------------------------------------------------------------------------
  // [화면 작성]
  Widget getScreenWidget() {
    // !!!화면 위젯 작성 하기!!!

    // Mobile 앱 status bar 색상 변경
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.blue,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));

    if (mainBusiness.inputError == true) {
      // 입력값이 미충족 되었을 때의 화면
      return gw_slw_page_outer_frame.ErrorPageWidget(
        business: gw_slw_page_outer_frame.ErrorPageWidgetBusiness(),
        errorMsg: "잘못된 접근입니다.",
      );
    }

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsets.all(20),
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                color: Color(0x77777777),
                shape: BoxShape.circle,
              ),
              child: Center(
                  // 상태 변화가 있는 곳은 BlocBuilder<BLoC 객체, ViewModel 객체> 으로 감싸기
                  child: gw_sfw_wrapper.SfwRefreshWrapper(
                key: mainBusiness.countNumberAreaGk,
                widgetBuild: (context) {
                  mainBusiness.countNumberAreaContext = context;

                  return Text("${mainBusiness.countNumber}",
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: "MaruBuri"));
                },
              )),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: [
                    const AnimationLogo(),
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: const Text(
                        "Flutter Project Template\n어서오세요!",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: "MaruBuri"),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// (AnimationLogo)
class AnimationLogo extends StatefulWidget {
  const AnimationLogo({super.key});

  // !!!외부 입력 변수 선언 하기!!!

  // [콜백 함수]
  @override
  AnimationLogoState createState() => AnimationLogoState();
}

class AnimationLogoState extends State<AnimationLogo>
    with SingleTickerProviderStateMixin {
  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    return getScreenWidget();
  }

  @override
  void initState() {
    super.initState();
    // !!!initState 작성!!!

    // 애니메이션 컨트롤러 생성
    var animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // 서브 애니메이션 생성
    var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );
    var scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    // 애니메이션 컨트롤러 리스너 추가
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // 애니메이션 완료 시점
      }
    });

    // 애니메이션 객체 저장
    animationLogoControllers = AnimationLogoControllers(
        animationController, fadeAnimation, scaleAnimation);

    // 애니메이션 실행
    animationController.forward();
  }

  @override
  void dispose() {
    // !!!dispose 작성!!!
    animationLogoControllers.animationController.dispose();

    super.dispose();
  }

  //----------------------------------------------------------------------------
  // !!!위젯 변수를 저장 하세요.!!!
  // [public 변수]
  late final AnimationLogoControllers animationLogoControllers;

  // [private 변수]

  //----------------------------------------------------------------------------
  // !!!위젯 함수를 작성 하세요.!!!
  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }

  // [private 함수]

  //----------------------------------------------------------------------------
  // [화면 작성]
  Widget getScreenWidget() {
    // !!!위젯 화면을 작성 하세요.!!!

    // 애니메이션 적용 위젯 반환
    return AnimatedBuilder(
      animation: animationLogoControllers.animationController,
      builder: (context, child) {
        return Opacity(
          opacity: animationLogoControllers.fadeAnimation.value,
          child: Transform.scale(
            scale: animationLogoControllers.scaleAnimation.value,
            child: SizedBox(
              width: 130,
              height: 130,
              child: Image(
                image:
                    const AssetImage("lib/assets/images/init_splash_logo.png"),
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  // 로딩 중일 때 플레이스 홀더를 보여줍니다.
                  if (loadingProgress == null) {
                    return child; // 로딩이 끝났을 경우
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  // 에러 발생 시 설정한 에러 위젯을 반환합니다.
                  return const Center(
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class AnimationLogoControllers {
  AnimationLogoControllers(
    this.animationController,
    this.fadeAnimation,
    this.scaleAnimation,
  );

  AnimationController animationController;
  Animation<double> fadeAnimation;
  Animation<double> scaleAnimation;
}
