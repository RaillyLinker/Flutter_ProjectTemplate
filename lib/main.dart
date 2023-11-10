// (external)
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:seo_renderer/helpers/robot_detector_vm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter/gestures.dart';

// (all)
import 'router.dart' as router;
import 'repositories/network/network_repositories.dart' as network_repositories;
import 'global_data/gd_const_config.dart' as gd_const_config;
import 'global_data/gd_const.dart' as gd_const;

// [프로그램 최초 실행 파일]
// 본 프로그램이 실행될 때 가장 처음으로 실행되는 main 함수가 존재하는 파일입니다.
// Web 에서는 브라우저 주소창 입력 진입, 혹은 브라우저 리플레시마다 실행됩니다.

// -----------------------------------------------------------------------------
// (프로그램 최초 실행 함수)
void main() async {
  // (모든 환경)
  // !!!모든 환경 프로그램 최초 실행 로직 작성!!!

  // main 을 async 로 쓰기 위해 바인딩 초기화
  WidgetsFlutterBinding.ensureInitialized();

  // Web Url 에서 # 제거
  setPathUrlStrategy();

  // SharedPreferences 객체 생성
  gd_const.sharedPreferences = await SharedPreferences.getInstance();

  // Dio 객체 설정
  network_repositories.setDioObjects();

  // Web 에서 개별 페이지 주소 보이기
  GoRouter.optionURLReflectsImperativeAPIs = true;

  // ---------------------------------------------------------------------------
  if (kIsWeb) {
    // (Web 환경)
    // !!!Web 환경 프로그램 최초 실행 로직 작성!!!

    // 마우스 우클릭 메뉴 금지 (현 시점, 플러터 웹에서 마우스 우클릭이 유용하지 않으며, 커스텀 메뉴를 사용하기 위해 필요한 조치)
    BrowserContextMenu.disableContextMenu();

    // -------------------------------------------------------------------------
  } else {
    // (App 환경)
    // !!!App 환경 프로그램 최초 실행 로직 작성!!!

    // -------------------------------------------------------------------------
    if (Platform.isAndroid || Platform.isIOS) {
      // (Mobile 환경)
      // !!!Mobile 환경 프로그램 최초 실행 로직 작성!!!

      // -----------------------------------------------------------------------

      if (Platform.isAndroid) {
        // (Android 환경)
        // !!!Android 환경 프로그램 최초 실행 로직 작성!!!

        // android 환경 정보 가져오기
        AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
        gd_const.androidApiLevel = androidInfo.version.sdkInt;

        // ---------------------------------------------------------------------
      } else if (Platform.isIOS) {
        // (Ios 환경)
        // !!!Ios 환경 프로그램 최초 실행 로직 작성!!!

        // ---------------------------------------------------------------------
      }
    } else {
      // (PC 환경)
      // !!!PC 환경 프로그램 최초 실행 로직 작성!!!

      // -----------------------------------------------------------------------
      if (Platform.isWindows) {
        // (Windows 환경)
        // !!!Windows 환경 프로그램 최초 실행 로직 작성!!!

        // ---------------------------------------------------------------------
      } else if (Platform.isMacOS) {
        // (MacOS 환경)
        // !!!MacOS 환경 프로그램 최초 실행 로직 작성!!!

        // ---------------------------------------------------------------------
      } else if (Platform.isLinux) {
        // (Linux 환경)
        // !!!Linux 환경 프로그램 최초 실행 로직 작성!!!

        // ---------------------------------------------------------------------
      }
    }
  }

  // 첫 화면 실행
  runApp(
    // 검색 엔진 로봇 방문 감지
    RobotDetector(
      debug: gd_const_config.isDebugMode,
      child: MaterialApp.router(
        // 웹 브라우저 탭 타이틀 설정
        title: gd_const_config.title,
        // 디버그 모드에서 디버그 리본 적용
        debugShowCheckedModeBanner: gd_const_config.isDebugMode,
        routerConfig: router.getRouter(), // 라우트 경로 주입
        // Mobile 외 환경의 스크롤링을 마우스 터치로 가능하도록 처리
        scrollBehavior: MouseTouchScrollBehavior(),
      ),
    ),
  );
}

// Web 에서의 스크롤링을 마우스 터치로 가능하도록 처리
class MouseTouchScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
