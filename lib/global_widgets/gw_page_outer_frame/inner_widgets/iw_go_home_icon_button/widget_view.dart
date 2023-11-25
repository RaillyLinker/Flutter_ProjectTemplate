// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'widget_business.dart' as widget_business;

// (all)
import '../../../../pages/all/all_page_home/page_entrance.dart'
    as all_page_home;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
class InputVo {
  const InputVo();
// !!!위젯 입력값 선언!!!
}

class WidgetView extends StatelessWidget {
  WidgetView({super.key, required this.business, required InputVo inputVo}) {
    business.inputVo = inputVo;
  }

  // [콜백 함수]
  // (위젯을 화면에 draw 할 때의 콜백)
  @override
  Widget build(BuildContext context) {
    return viewWidgetBuild(context: context);
  }

  // [public 변수]
  // (위젯 비즈니스)
  final widget_business.WidgetBusiness business;

  // [뷰 위젯]
  Widget viewWidgetBuild({required BuildContext context}) {
    return StatefulView(
      key: business.statefulGk,
      business: business,
    );
  }
}

class StatefulView extends StatefulWidget {
  const StatefulView({required super.key, required this.business});

  // [콜백 함수]
  @override
  StatefulBusiness createState() => StatefulBusiness();

  // [public 변수]
  // (위젯 비즈니스)
  final widget_business.WidgetBusiness business;
}

class StatefulBusiness extends State<StatefulView> {
  StatefulBusiness();

  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    widget.business.context = context;
    return WidgetUi.viewWidgetBuild(
        context: context, business: widget.business);
  }

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }
}

class WidgetUi {
  // [뷰 위젯]
  static Widget viewWidgetBuild(
      {required BuildContext context,
      required widget_business.WidgetBusiness business}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return ClipOval(
      child: MouseRegion(
        // 커서 변경 및 호버링 상태 변경
        cursor: SystemMouseCursors.click,
        onEnter: (details) {
          business.isHovering = true;
          business.refreshUi();
        },
        onExit: (details) {
          business.isHovering = false;
          business.refreshUi();
        },
        child: Tooltip(
          message: "홈으로",
          child: GestureDetector(
            // 클릭시 제스쳐 콜백
            onTap: () {
              context.goNamed(all_page_home.pageName);
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 보여줄 위젯
                SizedBox(
                  width: 35,
                  height: 35,
                  child: Image(
                    image:
                        const AssetImage("lib/assets/images/app_logo_img.png"),
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
                // 호버링시 가릴 위젯(보여줄 위젯과 동일한 사이즈를 준비)
                Opacity(
                  opacity: business.isHovering ? 1.0 : 0.0,
                  // 0.0: 완전 투명, 1.0: 완전 불투명
                  child: Container(
                      width: 35,
                      height: 35,
                      color: Colors.blue.withOpacity(0.5),
                      child: const Icon(Icons.home)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
