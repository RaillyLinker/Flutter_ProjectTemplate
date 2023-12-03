// (external)
import 'package:flutter/material.dart';

// (inner Folder)
import 'sf_widget_state.dart' as sf_widget_state;
import 'inner_widgets/iw_hover_list_tile/sf_widget.dart' as iw_hover_list_tile;
import 'inner_widgets/iw_hover_list_tile/sf_widget_state.dart'
    as iw_hover_list_tile_state;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
// (입력 데이터)
class InputVo {
  // !!!위젯 입력값 선언!!!
  const InputVo({required this.itemList});

  final List<SampleItem> itemList;
}

class SampleItem {
  SampleItem(
      {required this.itemTitle,
      required this.itemDescription,
      required this.onItemClicked});

  // 샘플 타이틀
  final String itemTitle;

  // 샘플 설명
  final String itemDescription;

  final void Function() onItemClicked;

  final GlobalKey<iw_hover_list_tile_state.SfWidgetState>
      iwHoverListTileStateGk = GlobalKey();
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

    return ListView.builder(
      itemCount: currentState.itemList.length,
      itemBuilder: (context, index) {
        var sampleItem = currentState.itemList[index];

        return Column(
          children: [
            iw_hover_list_tile.SfWidget(
                globalKey: sampleItem.iwHoverListTileStateGk,
                inputVo: iw_hover_list_tile.InputVo(
                    onItemClicked: sampleItem.onItemClicked,
                    listTileChild: ListTile(
                      mouseCursor: SystemMouseCursors.click,
                      title: Text(
                        sampleItem.itemTitle,
                        style: const TextStyle(fontFamily: "MaruBuri"),
                      ),
                      subtitle: Text(
                        sampleItem.itemDescription,
                        style: const TextStyle(fontFamily: "MaruBuri"),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                    ))),
            const Divider(
              color: Colors.grey,
              height: 0.1,
            ),
          ],
        );
      },
    );
  }
}
