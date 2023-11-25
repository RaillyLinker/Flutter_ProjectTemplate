// (external)
import 'package:flutter/material.dart';

// (inner Folder)
import 'widget_business.dart' as widget_business;
import 'inner_widgets/iw_stateful_sample_number/widget_view.dart'
    as iw_stateful_sample_number_view;
import '../../../global_widgets/gw_stateful_test/widget_view.dart'
    as gw_stateful_test_view;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

//------------------------------------------------------------------------------
// (페이지 호출시 필요한 입력값 데이터 형태)
// !!!페이지 입력 데이터 정의!!!
class InputVo {}

// (이전 페이지로 전달할 결과 데이터 형태)
// !!!페이지 반환 데이터 정의!!!
class OutputVo {}

// -----------------------------------------------------------------------------
class WidgetView extends StatefulWidget {
  const WidgetView(
      {super.key,
      required widget_business.WidgetBusiness business,
      required this.inputVo})
      : _business = business;

  // [콜백 함수]
  @override
  // ignore: no_logic_in_create_state
  widget_business.WidgetBusiness createState() => _business;

  // [public 변수]
  // (페이지 입력 데이터)
  final InputVo inputVo;

  // [private 변수]
  // (위젯 비즈니스)
  final widget_business.WidgetBusiness _business;

  // [public 함수]

  // [private 함수]

  // [뷰 위젯]
  // !!!뷰 위젯 반환 콜백 작성 하기!!!
  Widget viewWidgetBuild({required BuildContext context}) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          height: 280,
          width: 300,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "글로벌 위젯 상태 변수",
                  style: TextStyle(color: Colors.black, fontFamily: "MaruBuri"),
                ),
                const SizedBox(
                  height: 10,
                ),
                gw_stateful_test_view.WidgetView(
                    business: _business.statefulTestBusiness),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "로컬 위젯 상태 변수",
                  style: TextStyle(color: Colors.black, fontFamily: "MaruBuri"),
                ),
                const SizedBox(
                  height: 10,
                ),
                iw_stateful_sample_number_view.WidgetView(
                  business: _business.statefulSampleNumberBusiness,
                ),
                ElevatedButton(
                    onPressed: () {
                      _business.pushToAnotherPage();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      "페이지 이동",
                      style: TextStyle(
                          color: Colors.white, fontFamily: "MaruBuri"),
                    )),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
