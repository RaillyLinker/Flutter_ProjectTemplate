// (external)
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;

// [페이지 화면 위젯 작성 파일]
// 페이지 화면 구현을 담당합니다.
// 로직 처리는 pageBusiness 객체에 위임하세요.
// todo: gif bloc 로 바꿀수는 없을까?

//------------------------------------------------------------------------------
// (페이지 UI 위젯)
// !!!세부 화면 정의!!!
class PageView extends StatelessWidget {
  const PageView({super.key});

  @override
  Widget build(BuildContext context) {
    // pageBusiness 객체
    page_business.PageBusiness pageBusiness =
        BlocProvider.of<gc_template_classes.BlocPageInfo>(context)
            .state
            .pageBusiness;

    // Mobile 앱 status bar 색상 변경
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.blue,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));

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
                  child: BlocBuilder<page_business.BlocCountDownNumber, bool>(
                      builder: (c, s) {
                // BLoC 이벤트가 발생하면, businesses 의 viewModel 에서 적합한 state 를 가져와서 그에 맞는 Ui 를 return 해주기.
                return Text("${pageBusiness.pageViewModel.countNumber}",
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontFamily: "MaruBuri"));
              })),
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

class AnimationLogo extends StatefulWidget {
  const AnimationLogo({super.key});

  @override
  AnimationLogoState createState() => AnimationLogoState();
}

class AnimationLogoState extends State<AnimationLogo>
    with SingleTickerProviderStateMixin {
  late page_business.PageBusiness pageBusiness;

  @override
  void dispose() {
    pageBusiness.pageViewModel.animationLogoControllers!.animationController
        .dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // pageBusiness 객체
    pageBusiness = BlocProvider.of<gc_template_classes.BlocPageInfo>(context)
        .state
        .pageBusiness;

    if (pageBusiness.pageViewModel.animationLogoControllers == null) {
      // 컨트롤러 처음 생성시점

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
      pageBusiness.pageViewModel.animationLogoControllers =
          page_business.AnimationLogoControllers(
              animationController, fadeAnimation, scaleAnimation);

      // 애니메이션 실행
      animationController.forward();
    }

    // 애니메이션 적용 위젯 반환
    return AnimatedBuilder(
      animation: pageBusiness
          .pageViewModel.animationLogoControllers!.animationController,
      builder: (context, child) {
        return Opacity(
          opacity: pageBusiness
              .pageViewModel.animationLogoControllers!.fadeAnimation.value,
          child: Transform.scale(
            scale: pageBusiness
                .pageViewModel.animationLogoControllers!.scaleAnimation.value,
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
