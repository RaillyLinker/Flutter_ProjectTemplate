// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'sf_widget_state.dart' as sf_widget_state;

// (all)
import '../../../../pages/all/all_page_home/page_entrance.dart'
    as all_page_home;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
class InputVo {
// !!!위젯 입력값 선언!!!
  const InputVo();
}

class SfWidget extends StatefulWidget {
  const SfWidget({required this.globalKey, required this.inputVo})
      : super(key: globalKey);

  // [콜백 함수]
  @override
  sf_widget_state.SfWidgetState createState() =>
      sf_widget_state.SfWidgetState();

  // [public 변수]
  final InputVo inputVo;
  final GlobalKey<sf_widget_state.SfWidgetState> globalKey;

  // [화면 작성]
  Widget widgetUiBuild(
      {required BuildContext context,
      required sf_widget_state.SfWidgetState currentState}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return ClipOval(
      child: MouseRegion(
        // 커서 변경 및 호버링 상태 변경
        cursor: SystemMouseCursors.click,
        onEnter: (details) {
          currentState.isHovering = true;
          currentState.refreshUi();
        },
        onExit: (details) {
          currentState.isHovering = false;
          currentState.refreshUi();
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
                  opacity: currentState.isHovering ? 1.0 : 0.0,
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
