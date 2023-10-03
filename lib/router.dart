// (external)
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

// (all)
import 'a_templates/all_page_template/page_entrance.dart' as all_page_template;
import 'pages/all/all_page_home/page_entrance.dart' as all_page_home;
import 'pages/all/all_page_register_member_info/page_entrance.dart'
    as all_page_register_member_info;
import 'pages/all/all_page_login/page_entrance.dart' as all_page_login;
import 'pages/all/all_page_register_email_verification/page_entrance.dart'
    as all_page_register_email_verification;
import 'pages/all/all_page_find_password_with_email/page_entrance.dart'
    as all_page_find_password_with_email;
import 'pages/all/all_page_find_password_with_phone_number/page_entrance.dart'
    as all_page_find_password_with_phone_number;
import 'pages/all/all_page_page_and_router_sample_list/page_entrance.dart'
    as all_page_page_and_router_sample_list;
import 'pages/all/all_page_global_variable_state_test_sample/page_entrance.dart'
    as all_page_global_variable_state_test_sample;
import 'pages/all/all_page_url_launcher_sample/page_entrance.dart'
    as all_page_url_launcher_sample;
import 'pages/all/all_page_dialog_sample_list/page_entrance.dart'
    as all_page_dialog_sample_list;
import 'pages/all/all_page_shared_preferences_sample/page_entrance.dart'
    as all_page_shared_preferences_sample;
import 'pages/all/all_page_network_request_sample_list/page_entrance.dart'
    as all_page_network_request_sample_list;
import 'pages/all/all_page_auth_sample/page_entrance.dart'
    as all_page_auth_sample;
import 'pages/all/all_page_authorization_test_sample_list/page_entrance.dart'
    as all_page_authorization_test_sample_list;
import 'pages/all/all_page_get_request_sample/page_entrance.dart'
    as all_page_get_request_sample;
import 'pages/all/all_page_post_request_sample1/page_entrance.dart'
    as all_page_post_request_sample1;
import 'pages/all/all_page_post_request_sample2/page_entrance.dart'
    as all_page_post_request_sample2;
import 'pages/all/all_page_post_request_sample3/page_entrance.dart'
    as all_page_post_request_sample3;
import 'pages/all/all_page_post_request_sample4/page_entrance.dart'
    as all_page_post_request_sample4;
import 'pages/all/all_page_just_push_test1/page_entrance.dart'
    as all_page_just_push_test1;
import 'pages/all/all_page_just_push_test2/page_entrance.dart'
    as all_page_just_push_test2;
import 'pages/all/all_page_input_and_output_push_test/page_entrance.dart'
    as all_page_input_and_output_push_test;
import 'pages/all/all_page_page_transition_animation_sample_list/page_entrance.dart'
    as all_page_page_transition_animation_sample_list;
import 'pages/all/all_page_widget_change_animation_sample_list/page_entrance.dart'
    as all_page_widget_change_animation_sample_list;
import 'pages/all/all_page_membership_withdrawal/page_entrance.dart'
    as all_page_membership_withdrawal;
import 'pages/all/all_page_crypt_sample/page_entrance.dart'
    as all_page_crypt_sample;
import 'pages/all/all_page_change_password/page_entrance.dart'
    as all_page_change_password;

// (app)
import 'pages/app/app_page_init_splash/page_entrance.dart'
    as app_page_init_splash;
import 'pages/app/app_page_server_sample/page_entrance.dart'
    as app_page_server_sample;

// (mobile)
import 'pages/mobile/mobile_page_permission_sample_list/page_entrance.dart'
    as mobile_page_permission_sample_list;

// [프로그램 라우터 설정 파일]
// main.dart 에서 라우팅 설정에 사용되는 GoRouter 를 정의합니다.
// 프로그램 내에서 사용할 모든 페이지는 여기에 등록 되어야 접근 및 사용이 가능합니다.

// -----------------------------------------------------------------------------
// (프로그램 라우터 클래스)
// 아래의 라우터 클래스를 구현하면, main 함수에서 goRouter 객체 변수를 사용하여 라우터를 설정합니다.
GoRouter getRouter() {
  // 초기 진입 라우트 경로
  late String initialLocation;

  // 라우트 리스트
  final List<RouteBase> routeList = [];

  // / 경로 서브 라우트 리스트
  final List<RouteBase> subRouteList = [];

  // /page-and-router-test-sample 경로 서브 라우트 리스트
  final List<RouteBase> subRouteListPageAndRouterTestSample = [];

  // /network-request-sample 경로 서브 라우트 리스트
  final List<RouteBase> subRouteListNetworkRequestSample = [];

  // /auth-sample 경로 서브 라우트 리스트
  final List<RouteBase> subRouteListAuthSample = [];

  // /auth-sample/auth-sign-in 경로 서브 라우트 리스트
  final List<RouteBase> subRouteListAuthSampleAuthSignIn = [];

  // (모든 환경)
  // !!!초기 진입 라우트 경로 설정!!
  initialLocation = "/";

  // !!!사용할 라우터 리스트 추가!!
  routeList.add(GoRoute(
    path: "/",
    name: all_page_home.pageName,
    pageBuilder: (c, s) {
      return CustomTransitionPage(
        key: s.pageKey,
        child: all_page_home.PageEntrance(s),
        transitionsBuilder: all_page_home.pageTransitionsBuilder,
      );
    },
    routes: subRouteList,
  ));

  subRouteList.add(GoRoute(
    path: "page-and-router-sample-list",
    name: all_page_page_and_router_sample_list.pageName,
    pageBuilder: (c, s) {
      return CustomTransitionPage(
        key: s.pageKey,
        child: all_page_page_and_router_sample_list.PageEntrance(s),
        transitionsBuilder:
            all_page_page_and_router_sample_list.pageTransitionsBuilder,
      );
    },
    routes: subRouteListPageAndRouterTestSample,
  ));

  subRouteListPageAndRouterTestSample.add(GoRoute(
    path: "page-template",
    name: all_page_template.pageName,
    pageBuilder: (c, s) {
      return CustomTransitionPage(
        key: s.pageKey,
        child: all_page_template.PageEntrance(s),
        transitionsBuilder: all_page_template.pageTransitionsBuilder,
      );
    },
  ));

  subRouteListPageAndRouterTestSample.add(GoRoute(
    path: "just-push-test1",
    name: all_page_just_push_test1.pageName,
    pageBuilder: (c, s) {
      return CustomTransitionPage(
        key: s.pageKey,
        child: all_page_just_push_test1.PageEntrance(s),
        transitionsBuilder: all_page_just_push_test1.pageTransitionsBuilder,
      );
    },
  ));

  subRouteListPageAndRouterTestSample.add(GoRoute(
    path: "just-push-test2",
    name: all_page_just_push_test2.pageName,
    pageBuilder: (c, s) {
      return CustomTransitionPage(
        key: s.pageKey,
        child: all_page_just_push_test2.PageEntrance(s),
        transitionsBuilder: all_page_just_push_test2.pageTransitionsBuilder,
      );
    },
  ));

  subRouteListPageAndRouterTestSample.add(GoRoute(
    path: "input-and-output-push-test",
    name: all_page_input_and_output_push_test.pageName,
    pageBuilder: (c, s) {
      return CustomTransitionPage(
        key: s.pageKey,
        child: all_page_input_and_output_push_test.PageEntrance(s),
        transitionsBuilder:
            all_page_input_and_output_push_test.pageTransitionsBuilder,
      );
    },
  ));

  subRouteListPageAndRouterTestSample.add(GoRoute(
    path: "page-transition-animation-sample-list",
    name: all_page_page_transition_animation_sample_list.pageName,
    pageBuilder: (c, s) {
      return CustomTransitionPage(
        key: s.pageKey,
        child: all_page_page_transition_animation_sample_list.PageEntrance(s),
        transitionsBuilder: all_page_page_transition_animation_sample_list
            .pageTransitionsBuilder,
      );
    },
  ));

  subRouteList.add(GoRoute(
    path: "dialog-sample-list",
    name: all_page_dialog_sample_list.pageName,
    pageBuilder: (c, s) {
      return CustomTransitionPage(
        key: s.pageKey,
        child: all_page_dialog_sample_list.PageEntrance(s),
        transitionsBuilder: all_page_dialog_sample_list.pageTransitionsBuilder,
      );
    },
  ));

  subRouteList.add(GoRoute(
    path: "shared-preferences-sample",
    name: all_page_shared_preferences_sample.pageName,
    pageBuilder: (c, s) {
      return CustomTransitionPage(
        key: s.pageKey,
        child: all_page_shared_preferences_sample.PageEntrance(s),
        transitionsBuilder:
            all_page_shared_preferences_sample.pageTransitionsBuilder,
      );
    },
  ));

  subRouteList.add(GoRoute(
    path: "url-launcher-sample",
    name: all_page_url_launcher_sample.pageName,
    pageBuilder: (c, s) {
      return CustomTransitionPage(
        key: s.pageKey,
        child: all_page_url_launcher_sample.PageEntrance(s),
        transitionsBuilder: all_page_url_launcher_sample.pageTransitionsBuilder,
      );
    },
  ));

  subRouteList.add(GoRoute(
    path: "network-request-sample-list",
    name: all_page_network_request_sample_list.pageName,
    pageBuilder: (c, s) {
      return CustomTransitionPage(
        key: s.pageKey,
        child: all_page_network_request_sample_list.PageEntrance(s),
        transitionsBuilder:
            all_page_network_request_sample_list.pageTransitionsBuilder,
      );
    },
    routes: subRouteListNetworkRequestSample,
  ));

  subRouteListNetworkRequestSample.add(GoRoute(
    path: "get-request-sample",
    name: all_page_get_request_sample.pageName,
    pageBuilder: (c, s) {
      return CustomTransitionPage(
        key: s.pageKey,
        child: all_page_get_request_sample.PageEntrance(s),
        transitionsBuilder: all_page_get_request_sample.pageTransitionsBuilder,
      );
    },
  ));

  subRouteListNetworkRequestSample.add(GoRoute(
    path: "post-request-sample1",
    name: all_page_post_request_sample1.pageName,
    pageBuilder: (c, s) {
      return CustomTransitionPage(
        key: s.pageKey,
        child: all_page_post_request_sample1.PageEntrance(s),
        transitionsBuilder:
            all_page_post_request_sample1.pageTransitionsBuilder,
      );
    },
  ));

  subRouteListNetworkRequestSample.add(GoRoute(
    path: "post-request-sample2",
    name: all_page_post_request_sample2.pageName,
    pageBuilder: (c, s) {
      return CustomTransitionPage(
        key: s.pageKey,
        child: all_page_post_request_sample2.PageEntrance(s),
        transitionsBuilder:
            all_page_post_request_sample2.pageTransitionsBuilder,
      );
    },
  ));

  subRouteListNetworkRequestSample.add(GoRoute(
    path: "post-request-sample3",
    name: all_page_post_request_sample3.pageName,
    pageBuilder: (c, s) {
      return CustomTransitionPage(
        key: s.pageKey,
        child: all_page_post_request_sample3.PageEntrance(s),
        transitionsBuilder:
            all_page_post_request_sample3.pageTransitionsBuilder,
      );
    },
  ));

  subRouteListNetworkRequestSample.add(GoRoute(
    path: "post-request-sample4",
    name: all_page_post_request_sample4.pageName,
    pageBuilder: (c, s) {
      return CustomTransitionPage(
        key: s.pageKey,
        child: all_page_post_request_sample4.PageEntrance(s),
        transitionsBuilder:
            all_page_post_request_sample4.pageTransitionsBuilder,
      );
    },
  ));

  subRouteList.add(GoRoute(
    path: "auth-sample",
    name: all_page_auth_sample.pageName,
    pageBuilder: (c, s) {
      return CustomTransitionPage(
        key: s.pageKey,
        child: all_page_auth_sample.PageEntrance(s),
        transitionsBuilder: all_page_auth_sample.pageTransitionsBuilder,
      );
    },
    routes: subRouteListAuthSample,
  ));

  subRouteListAuthSample.add(GoRoute(
    path: "authorization-test-sample-list",
    name: all_page_authorization_test_sample_list.pageName,
    pageBuilder: (c, s) {
      return CustomTransitionPage(
        key: s.pageKey,
        child: all_page_authorization_test_sample_list.PageEntrance(s),
        transitionsBuilder:
            all_page_authorization_test_sample_list.pageTransitionsBuilder,
      );
    },
  ));

  subRouteListAuthSample.add(GoRoute(
    path: "login",
    name: all_page_login.pageName,
    pageBuilder: (c, s) {
      return CustomTransitionPage(
        key: s.pageKey,
        child: all_page_login.PageEntrance(s),
        transitionsBuilder: all_page_login.pageTransitionsBuilder,
      );
    },
    routes: subRouteListAuthSampleAuthSignIn,
  ));

  subRouteListAuthSample.add(GoRoute(
    path: "membership-withdrawal",
    name: all_page_membership_withdrawal.pageName,
    pageBuilder: (c, s) {
      return CustomTransitionPage(
        key: s.pageKey,
        child: all_page_membership_withdrawal.PageEntrance(s),
        transitionsBuilder:
            all_page_membership_withdrawal.pageTransitionsBuilder,
      );
    },
  ));

  subRouteListAuthSample.add(GoRoute(
    path: "change-password",
    name: all_page_change_password.pageName,
    pageBuilder: (c, s) {
      return CustomTransitionPage(
        key: s.pageKey,
        child: all_page_change_password.PageEntrance(s),
        transitionsBuilder: all_page_change_password.pageTransitionsBuilder,
      );
    },
  ));

  subRouteListAuthSampleAuthSignIn.add(GoRoute(
    path: "register-email-verification",
    name: all_page_register_email_verification.pageName,
    pageBuilder: (c, s) {
      return CustomTransitionPage(
        key: s.pageKey,
        child: all_page_register_email_verification.PageEntrance(s),
        transitionsBuilder:
            all_page_register_email_verification.pageTransitionsBuilder,
      );
    },
  ));

  subRouteListAuthSampleAuthSignIn.add(GoRoute(
    path: "find-password-with-phone-number",
    name: all_page_find_password_with_phone_number.pageName,
    pageBuilder: (c, s) {
      return CustomTransitionPage(
        key: s.pageKey,
        child: all_page_find_password_with_phone_number.PageEntrance(s),
        transitionsBuilder:
            all_page_find_password_with_phone_number.pageTransitionsBuilder,
      );
    },
  ));

  subRouteListAuthSampleAuthSignIn.add(GoRoute(
    path: "find-password-with-email",
    name: all_page_find_password_with_email.pageName,
    pageBuilder: (c, s) {
      return CustomTransitionPage(
        key: s.pageKey,
        child: all_page_find_password_with_email.PageEntrance(s),
        transitionsBuilder:
            all_page_find_password_with_email.pageTransitionsBuilder,
      );
    },
  ));

  subRouteListAuthSampleAuthSignIn.add(GoRoute(
    path: "register-member-info",
    name: all_page_register_member_info.pageName,
    pageBuilder: (c, s) {
      return CustomTransitionPage(
        key: s.pageKey,
        child: all_page_register_member_info.PageEntrance(s),
        transitionsBuilder:
            all_page_register_member_info.pageTransitionsBuilder,
      );
    },
  ));

  subRouteList.add(GoRoute(
    path: "global-variable-state-test-sample",
    name: all_page_global_variable_state_test_sample.pageName,
    pageBuilder: (c, s) {
      return CustomTransitionPage(
        key: s.pageKey,
        child: all_page_global_variable_state_test_sample.PageEntrance(s),
        transitionsBuilder:
            all_page_global_variable_state_test_sample.pageTransitionsBuilder,
      );
    },
  ));

  subRouteList.add(GoRoute(
    path: "widget-change-animation-sample-list",
    name: all_page_widget_change_animation_sample_list.pageName,
    pageBuilder: (c, s) {
      return CustomTransitionPage(
        key: s.pageKey,
        child: all_page_widget_change_animation_sample_list.PageEntrance(s),
        transitionsBuilder:
            all_page_widget_change_animation_sample_list.pageTransitionsBuilder,
      );
    },
  ));

  subRouteList.add(GoRoute(
    path: "crypt-sample",
    name: all_page_crypt_sample.pageName,
    pageBuilder: (c, s) {
      return CustomTransitionPage(
        key: s.pageKey,
        child: all_page_crypt_sample.PageEntrance(s),
        transitionsBuilder: all_page_crypt_sample.pageTransitionsBuilder,
      );
    },
  ));

  // ---------------------------------------------------------------------------
  if (kIsWeb) {
    // (Web 환경)
    // !!!초기 진입 라우트 경로 설정!!
    initialLocation = "/";

    // !!!사용할 라우터 리스트 추가!!

    // -------------------------------------------------------------------------
  } else {
    // (App 환경)
    // !!!초기 진입 라우트 경로 설정!!
    initialLocation = "/init-splash";

    // !!!사용할 라우터 리스트 추가!!
    routeList.add(GoRoute(
      path: "/init-splash",
      name: app_page_init_splash.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
          key: s.pageKey,
          child: app_page_init_splash.PageEntrance(s),
          transitionsBuilder: app_page_init_splash.pageTransitionsBuilder,
        );
      },
    ));

    subRouteList.add(GoRoute(
      path: "server-sample",
      name: app_page_server_sample.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
          key: s.pageKey,
          child: app_page_server_sample.PageEntrance(s),
          transitionsBuilder: app_page_server_sample.pageTransitionsBuilder,
        );
      },
    ));

    // -------------------------------------------------------------------------
    if (Platform.isAndroid || Platform.isIOS) {
      // (Mobile 환경)
      // !!!초기 진입 라우트 경로 설정!!
      // !!!사용할 라우터 리스트 추가!!
      subRouteList.add(GoRoute(
        path: "mobile-page-permission-sample-list",
        name: mobile_page_permission_sample_list.pageName,
        pageBuilder: (c, s) {
          return CustomTransitionPage(
            key: s.pageKey,
            child: mobile_page_permission_sample_list.PageEntrance(s),
            transitionsBuilder:
                mobile_page_permission_sample_list.pageTransitionsBuilder,
          );
        },
      ));

      // -----------------------------------------------------------------------

      if (Platform.isAndroid) {
        // (Android 환경)
        // !!!초기 진입 라우트 경로 설정!!
        // !!!사용할 라우터 리스트 추가!!

        // ---------------------------------------------------------------------
      } else if (Platform.isIOS) {
        // (Ios 환경)
        // !!!초기 진입 라우트 경로 설정!!
        // !!!사용할 라우터 리스트 추가!!

        // ---------------------------------------------------------------------
      }
    } else {
      // (PC 환경)
      // !!!초기 진입 라우트 경로 설정!!
      // !!!사용할 라우터 리스트 추가!!

      // -----------------------------------------------------------------------
      if (Platform.isWindows) {
        // (Windows 환경)
        // !!!초기 진입 라우트 경로 설정!!
        // !!!사용할 라우터 리스트 추가!!

        // ---------------------------------------------------------------------
      } else if (Platform.isMacOS) {
        // (MacOS 환경)
        // !!!초기 진입 라우트 경로 설정!!
        // !!!사용할 라우터 리스트 추가!!

        // ---------------------------------------------------------------------
      } else if (Platform.isLinux) {
        // (Linux 환경)
        // !!!초기 진입 라우트 경로 설정!!
        // !!!사용할 라우터 리스트 추가!!

        // ---------------------------------------------------------------------
      }
    }
  }

  // 라우터 객체 생성
  return GoRouter(
    initialLocation: initialLocation,
    routes: routeList,
  );
}
