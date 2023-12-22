// (external)
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

// (all)
import 'a_templates/all_page_template/main_widget.dart' as all_page_template;
import 'pages/all/all_page_stateful_and_lifecycle_test/main_widget.dart'
    as all_page_stateful_and_lifecycle_test;
import 'pages/all/all_page_auth_sample/main_widget.dart'
    as all_page_auth_sample;
import 'pages/all/all_page_authorization_test_sample_list/main_widget.dart'
    as all_page_authorization_test_sample_list;
import 'pages/all/all_page_change_password/main_widget.dart'
    as all_page_change_password;
import 'pages/all/all_page_crypt_sample/main_widget.dart'
    as all_page_crypt_sample;
import 'pages/all/all_page_dialog_sample_list/main_widget.dart'
    as all_page_dialog_sample_list;
import 'pages/all/all_page_etc_sample_list/main_widget.dart'
    as all_page_etc_sample_list;
import 'pages/all/all_page_find_password_with_email/main_widget.dart'
    as all_page_find_password_with_email;
import 'pages/all/all_page_get_request_sample/main_widget.dart'
    as all_page_get_request_sample;
import 'pages/all/all_page_global_variable_state_test_sample/main_widget.dart'
    as all_page_global_variable_state_test_sample;
import 'pages/all/all_page_home/main_widget.dart' as all_page_home;
import 'pages/all/all_page_input_and_output_push_test/main_widget.dart'
    as all_page_input_and_output_push_test;
import 'pages/all/all_page_join_the_membership_edit_member_info/main_widget.dart'
    as all_page_join_the_membership_edit_member_info;
import 'pages/all/all_page_join_the_membership_email_verification/main_widget.dart'
    as all_page_join_the_membership_email_verification;
import 'pages/all/all_page_login/main_widget.dart' as all_page_login;
import 'pages/all/all_page_member_info/main_widget.dart'
    as all_page_member_info;
import 'pages/all/all_page_membership_withdrawal/main_widget.dart'
    as all_page_membership_withdrawal;
import 'pages/all/all_page_network_request_sample_list/main_widget.dart'
    as all_page_network_request_sample_list;
import 'pages/all/all_page_page_and_router_sample_list/main_widget.dart'
    as all_page_page_and_router_sample_list;
import 'pages/all/all_page_page_transition_animation_sample_list/main_widget.dart'
    as all_page_page_transition_animation_sample_list;
import 'pages/all/all_page_post_request_sample1/main_widget.dart'
    as all_page_post_request_sample1;
import 'pages/all/all_page_post_request_sample2/main_widget.dart'
    as all_page_post_request_sample2;
import 'pages/all/all_page_post_request_sample3/main_widget.dart'
    as all_page_post_request_sample3;
import 'pages/all/all_page_post_request_sample4/main_widget.dart'
    as all_page_post_request_sample4;
import 'pages/all/all_page_shared_preferences_sample/main_widget.dart'
    as all_page_shared_preferences_sample;
import 'pages/all/all_page_url_launcher_sample/main_widget.dart'
    as all_page_url_launcher_sample;
import 'pages/all/all_page_widget_change_animation_sample_list/main_widget.dart'
    as all_page_widget_change_animation_sample_list;
import 'pages/all/all_page_gif_sample/main_widget.dart' as all_page_gif_sample;
import 'pages/all/all_page_dialog_animation_sample_list/main_widget.dart'
    as all_page_dialog_animation_sample_list;
import 'pages/all/all_page_grid_sample/main_widget.dart'
    as all_page_grid_sample;
import 'pages/all/all_page_image_selector_sample/main_widget.dart'
    as all_page_image_selector_sample;
import 'pages/all/all_page_image_loading_sample/main_widget.dart'
    as all_page_image_loading_sample;
import 'pages/all/all_page_context_menu_sample/main_widget.dart'
    as all_page_context_menu_sample;
import 'pages/all/all_page_gesture_area_overlap_test/main_widget.dart'
    as all_page_gesture_area_overlap_test;
import 'pages/all/all_page_form_sample/main_widget.dart'
    as all_page_form_sample;
import 'pages/all/all_page_horizontal_scroll_test/main_widget.dart'
    as all_page_horizontal_scroll_test;
import 'pages/pc/pc_page_flutter_resource_image_resize/main_widget.dart'
    as pc_page_flutter_resource_image_resize;

// (app)
import 'pages/app/app_page_init_splash/main_widget.dart'
    as app_page_init_splash;
import 'pages/app/app_page_server_sample/main_widget.dart'
    as app_page_server_sample;

// (mobile)
import 'pages/mobile/mobile_page_permission_sample_list/main_widget.dart'
    as mobile_page_permission_sample_list;

// [프로그램 라우터 설정 파일]
// main.dart 에서 라우팅 설정에 사용되는 GoRouter 를 정의합니다.
// 프로그램 내에서 사용할 모든 페이지는 여기에 등록 되어야 접근 및 사용이 가능합니다.

// "/" 경로에 할당된 페이지는 항상 해당 앱의 Home 페이지, 즉 처음 진입하여 서비스 어디든지 이어지는 센터 페이지가 되도록 주의합시다.
// "/" 경로는 잘못된 페이지 접근 등의 상황에 복귀하는 페이지가 될 것입니다.

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

  // /page-and-router-sample-list 경로 서브 라우트 리스트
  final List<RouteBase> subRouteListPageAndRouterSampleList = [];

  // /network-request-sample-list 경로 서브 라우트 리스트
  final List<RouteBase> subRouteListNetworkRequestSampleList = [];

  // /auth-sample 경로 서브 라우트 리스트
  final List<RouteBase> subRouteListAuthSample = [];

  // /auth-sample/login 경로 서브 라우트 리스트
  final List<RouteBase> subRouteListAuthSampleAuthLogin = [];

  // /etc-sample-list 경로 서브 라우트 리스트
  final List<RouteBase> subRouteListEtcSampleList = [];

  // (모든 환경)
  // !!!초기 진입 라우트 경로 설정!!!
  initialLocation = "/";

  // !!!사용할 라우터 리스트 추가!!!
  routeList.add(GoRoute(
      path: "/",
      name: all_page_home.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_home.MainWidget(goRouterState: s),
            transitionsBuilder: all_page_home.pageTransitionsBuilder);
      },
      routes: subRouteList));

  subRouteList.add(GoRoute(
      path: "page-and-router-sample-list",
      name: all_page_page_and_router_sample_list.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_page_and_router_sample_list.MainWidget(
                goRouterState: s),
            transitionsBuilder:
                all_page_page_and_router_sample_list.pageTransitionsBuilder);
      },
      routes: subRouteListPageAndRouterSampleList));

  subRouteListPageAndRouterSampleList.add(GoRoute(
      path: "stateful-and-lifecycle-test",
      name: all_page_stateful_and_lifecycle_test.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_stateful_and_lifecycle_test.MainWidget(
                goRouterState: s),
            transitionsBuilder:
                all_page_stateful_and_lifecycle_test.pageTransitionsBuilder);
      }));

  subRouteListPageAndRouterSampleList.add(GoRoute(
      path: "page-template",
      name: all_page_template.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_template.MainWidget(goRouterState: s),
            transitionsBuilder: all_page_template.pageTransitionsBuilder);
      }));

  subRouteListPageAndRouterSampleList.add(GoRoute(
      path: "input-and-output-push-test",
      name: all_page_input_and_output_push_test.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_input_and_output_push_test.MainWidget(
                goRouterState: s),
            transitionsBuilder:
                all_page_input_and_output_push_test.pageTransitionsBuilder);
      }));

  subRouteListPageAndRouterSampleList.add(GoRoute(
      path: "page-transition-animation-sample-list",
      name: all_page_page_transition_animation_sample_list.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_page_transition_animation_sample_list.MainWidget(
                goRouterState: s),
            transitionsBuilder: all_page_page_transition_animation_sample_list
                .pageTransitionsBuilder);
      }));

  subRouteListPageAndRouterSampleList.add(GoRoute(
      path: "grid-sample",
      name: all_page_grid_sample.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_grid_sample.MainWidget(goRouterState: s),
            transitionsBuilder: all_page_grid_sample.pageTransitionsBuilder);
      }));

  subRouteList.add(GoRoute(
      path: "dialog-sample-list",
      name: all_page_dialog_sample_list.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_dialog_sample_list.MainWidget(goRouterState: s),
            transitionsBuilder:
                all_page_dialog_sample_list.pageTransitionsBuilder);
      }));

  subRouteList.add(GoRoute(
      path: "dialog-animation-sample-list",
      name: all_page_dialog_animation_sample_list.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_dialog_animation_sample_list.MainWidget(
                goRouterState: s),
            transitionsBuilder:
                all_page_dialog_animation_sample_list.pageTransitionsBuilder);
      }));

  subRouteList.add(GoRoute(
      path: "network-request-sample-list",
      name: all_page_network_request_sample_list.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_network_request_sample_list.MainWidget(
                goRouterState: s),
            transitionsBuilder:
                all_page_network_request_sample_list.pageTransitionsBuilder);
      },
      routes: subRouteListNetworkRequestSampleList));

  subRouteListNetworkRequestSampleList.add(GoRoute(
      path: "get-request-sample",
      name: all_page_get_request_sample.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_get_request_sample.MainWidget(goRouterState: s),
            transitionsBuilder:
                all_page_get_request_sample.pageTransitionsBuilder);
      }));

  subRouteListNetworkRequestSampleList.add(GoRoute(
      path: "post-request-sample1",
      name: all_page_post_request_sample1.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_post_request_sample1.MainWidget(goRouterState: s),
            transitionsBuilder:
                all_page_post_request_sample1.pageTransitionsBuilder);
      }));

  subRouteListNetworkRequestSampleList.add(GoRoute(
      path: "post-request-sample2",
      name: all_page_post_request_sample2.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_post_request_sample2.MainWidget(goRouterState: s),
            transitionsBuilder:
                all_page_post_request_sample2.pageTransitionsBuilder);
      }));

  subRouteListNetworkRequestSampleList.add(GoRoute(
      path: "post-request-sample3",
      name: all_page_post_request_sample3.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_post_request_sample3.MainWidget(goRouterState: s),
            transitionsBuilder:
                all_page_post_request_sample3.pageTransitionsBuilder);
      }));

  subRouteListNetworkRequestSampleList.add(GoRoute(
      path: "post-request-sample4",
      name: all_page_post_request_sample4.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_post_request_sample4.MainWidget(goRouterState: s),
            transitionsBuilder:
                all_page_post_request_sample4.pageTransitionsBuilder);
      }));

  subRouteList.add(GoRoute(
      path: "auth-sample",
      name: all_page_auth_sample.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_auth_sample.MainWidget(goRouterState: s),
            transitionsBuilder: all_page_auth_sample.pageTransitionsBuilder);
      },
      routes: subRouteListAuthSample));

  subRouteListAuthSample.add(GoRoute(
      path: "authorization-test-sample-list",
      name: all_page_authorization_test_sample_list.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_authorization_test_sample_list.MainWidget(
                goRouterState: s),
            transitionsBuilder:
                all_page_authorization_test_sample_list.pageTransitionsBuilder);
      }));

  subRouteListAuthSample.add(GoRoute(
      path: "login",
      name: all_page_login.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_login.MainWidget(goRouterState: s),
            transitionsBuilder: all_page_login.pageTransitionsBuilder);
      },
      routes: subRouteListAuthSampleAuthLogin));

  subRouteListAuthSample.add(GoRoute(
      path: "member-info",
      name: all_page_member_info.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_member_info.MainWidget(goRouterState: s),
            transitionsBuilder: all_page_member_info.pageTransitionsBuilder);
      }));

  subRouteListAuthSample.add(GoRoute(
      path: "membership-withdrawal",
      name: all_page_membership_withdrawal.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_membership_withdrawal.MainWidget(goRouterState: s),
            transitionsBuilder:
                all_page_membership_withdrawal.pageTransitionsBuilder);
      }));

  subRouteListAuthSample.add(GoRoute(
      path: "change-password",
      name: all_page_change_password.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_change_password.MainWidget(goRouterState: s),
            transitionsBuilder:
                all_page_change_password.pageTransitionsBuilder);
      }));

  subRouteListAuthSampleAuthLogin.add(GoRoute(
      path: "join-the-membership-email-verification",
      name: all_page_join_the_membership_email_verification.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_join_the_membership_email_verification.MainWidget(
                goRouterState: s),
            transitionsBuilder: all_page_join_the_membership_email_verification
                .pageTransitionsBuilder);
      }));

  subRouteListAuthSampleAuthLogin.add(GoRoute(
      path: "find-password-with-email",
      name: all_page_find_password_with_email.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child:
                all_page_find_password_with_email.MainWidget(goRouterState: s),
            transitionsBuilder:
                all_page_find_password_with_email.pageTransitionsBuilder);
      }));

  subRouteListAuthSampleAuthLogin.add(GoRoute(
      path: "join-the-membership-edit-member-info",
      name: all_page_join_the_membership_edit_member_info.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_join_the_membership_edit_member_info.MainWidget(
                goRouterState: s),
            transitionsBuilder: all_page_join_the_membership_edit_member_info
                .pageTransitionsBuilder);
      }));

  subRouteList.add(GoRoute(
      path: "etc-sample-list",
      name: all_page_etc_sample_list.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_etc_sample_list.MainWidget(goRouterState: s),
            transitionsBuilder:
                all_page_etc_sample_list.pageTransitionsBuilder);
      },
      routes: subRouteListEtcSampleList));

  subRouteListEtcSampleList.add(GoRoute(
      path: "shared-preferences-sample",
      name: all_page_shared_preferences_sample.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child:
                all_page_shared_preferences_sample.MainWidget(goRouterState: s),
            transitionsBuilder:
                all_page_shared_preferences_sample.pageTransitionsBuilder);
      }));

  subRouteListEtcSampleList.add(GoRoute(
      path: "url-launcher-sample",
      name: all_page_url_launcher_sample.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_url_launcher_sample.MainWidget(goRouterState: s),
            transitionsBuilder:
                all_page_url_launcher_sample.pageTransitionsBuilder);
      }));

  subRouteListEtcSampleList.add(GoRoute(
      path: "global-variable-state-test-sample",
      name: all_page_global_variable_state_test_sample.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_global_variable_state_test_sample.MainWidget(
                goRouterState: s),
            transitionsBuilder: all_page_global_variable_state_test_sample
                .pageTransitionsBuilder);
      }));

  subRouteListEtcSampleList.add(GoRoute(
      path: "widget-change-animation-sample-list",
      name: all_page_widget_change_animation_sample_list.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_widget_change_animation_sample_list.MainWidget(
                goRouterState: s),
            transitionsBuilder: all_page_widget_change_animation_sample_list
                .pageTransitionsBuilder);
      }));

  subRouteListEtcSampleList.add(GoRoute(
      path: "crypt-sample",
      name: all_page_crypt_sample.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_crypt_sample.MainWidget(goRouterState: s),
            transitionsBuilder: all_page_crypt_sample.pageTransitionsBuilder);
      }));

  subRouteListEtcSampleList.add(GoRoute(
      path: "gif-sample",
      name: all_page_gif_sample.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_gif_sample.MainWidget(goRouterState: s),
            transitionsBuilder: all_page_gif_sample.pageTransitionsBuilder);
      }));

  subRouteListEtcSampleList.add(GoRoute(
      path: "image-selector-sample",
      name: all_page_image_selector_sample.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_image_selector_sample.MainWidget(goRouterState: s),
            transitionsBuilder:
                all_page_image_selector_sample.pageTransitionsBuilder);
      }));

  subRouteListEtcSampleList.add(GoRoute(
      path: "image-loading-sample",
      name: all_page_image_loading_sample.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_image_loading_sample.MainWidget(goRouterState: s),
            transitionsBuilder:
                all_page_image_loading_sample.pageTransitionsBuilder);
      }));

  subRouteListEtcSampleList.add(GoRoute(
      path: "context-menu-sample",
      name: all_page_context_menu_sample.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_context_menu_sample.MainWidget(goRouterState: s),
            transitionsBuilder:
                all_page_context_menu_sample.pageTransitionsBuilder);
      }));

  subRouteListEtcSampleList.add(GoRoute(
      path: "gesture-area-overlap-test",
      name: all_page_gesture_area_overlap_test.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child:
                all_page_gesture_area_overlap_test.MainWidget(goRouterState: s),
            transitionsBuilder:
                all_page_gesture_area_overlap_test.pageTransitionsBuilder);
      }));

  subRouteListEtcSampleList.add(GoRoute(
      path: "form-sample",
      name: all_page_form_sample.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_form_sample.MainWidget(goRouterState: s),
            transitionsBuilder: all_page_form_sample.pageTransitionsBuilder);
      }));

  subRouteListEtcSampleList.add(GoRoute(
      path: "horizontal-scroll-test",
      name: all_page_horizontal_scroll_test.pageName,
      pageBuilder: (c, s) {
        return CustomTransitionPage(
            key: s.pageKey,
            child: all_page_horizontal_scroll_test.MainWidget(goRouterState: s),
            transitionsBuilder:
                all_page_horizontal_scroll_test.pageTransitionsBuilder);
      }));

  // ---------------------------------------------------------------------------
  if (kIsWeb) {
    // (Web 환경)
    // !!!초기 진입 라우트 경로 설정!!!
    initialLocation = "/";

    // !!!사용할 라우터 리스트 추가!!!

    // -------------------------------------------------------------------------
  } else {
    // (App 환경)
    // !!!초기 진입 라우트 경로 설정!!!
    initialLocation = "/init-splash";

    // !!!사용할 라우터 리스트 추가!!!
    routeList.add(GoRoute(
        path: "/init-splash",
        name: app_page_init_splash.pageName,
        pageBuilder: (c, s) {
          return CustomTransitionPage(
              key: s.pageKey,
              child: app_page_init_splash.MainWidget(goRouterState: s),
              transitionsBuilder: app_page_init_splash.pageTransitionsBuilder);
        }));

    subRouteListEtcSampleList.add(GoRoute(
        path: "server-sample",
        name: app_page_server_sample.pageName,
        pageBuilder: (c, s) {
          return CustomTransitionPage(
              key: s.pageKey,
              child: app_page_server_sample.MainWidget(goRouterState: s),
              transitionsBuilder:
                  app_page_server_sample.pageTransitionsBuilder);
        }));

    // -------------------------------------------------------------------------
    if (Platform.isAndroid || Platform.isIOS) {
      // (Mobile 환경)
      // !!!초기 진입 라우트 경로 설정!!!
      // !!!사용할 라우터 리스트 추가!!!
      subRouteList.add(GoRoute(
          path: "mobile-page-permission-sample-list",
          name: mobile_page_permission_sample_list.pageName,
          pageBuilder: (c, s) {
            return CustomTransitionPage(
                key: s.pageKey,
                child: mobile_page_permission_sample_list.MainWidget(
                    goRouterState: s),
                transitionsBuilder:
                    mobile_page_permission_sample_list.pageTransitionsBuilder);
          }));

      // -----------------------------------------------------------------------

      if (Platform.isAndroid) {
        // (Android 환경)
        // !!!초기 진입 라우트 경로 설정!!!
        // !!!사용할 라우터 리스트 추가!!!

        // ---------------------------------------------------------------------
      } else if (Platform.isIOS) {
        // (Ios 환경)
        // !!!초기 진입 라우트 경로 설정!!!
        // !!!사용할 라우터 리스트 추가!!!

        // ---------------------------------------------------------------------
      }
    } else {
      // (PC 환경)
      // !!!초기 진입 라우트 경로 설정!!!
      // !!!사용할 라우터 리스트 추가!!!
      subRouteListEtcSampleList.add(GoRoute(
          path: "flutter-resource-image-resize",
          name: pc_page_flutter_resource_image_resize.pageName,
          pageBuilder: (c, s) {
            return CustomTransitionPage(
                key: s.pageKey,
                child: pc_page_flutter_resource_image_resize.MainWidget(
                    goRouterState: s),
                transitionsBuilder: pc_page_flutter_resource_image_resize
                    .pageTransitionsBuilder);
          }));

      // -----------------------------------------------------------------------
      if (Platform.isWindows) {
        // (Windows 환경)
        // !!!초기 진입 라우트 경로 설정!!!
        // !!!사용할 라우터 리스트 추가!!!

        // ---------------------------------------------------------------------
      } else if (Platform.isMacOS) {
        // (MacOS 환경)
        // !!!초기 진입 라우트 경로 설정!!!
        // !!!사용할 라우터 리스트 추가!!!

        // ---------------------------------------------------------------------
      } else if (Platform.isLinux) {
        // (Linux 환경)
        // !!!초기 진입 라우트 경로 설정!!!
        // !!!사용할 라우터 리스트 추가!!!

        // ---------------------------------------------------------------------
      }
    }
  }

  // 라우터 객체 생성
  return GoRouter(initialLocation: initialLocation, routes: routeList);
}
