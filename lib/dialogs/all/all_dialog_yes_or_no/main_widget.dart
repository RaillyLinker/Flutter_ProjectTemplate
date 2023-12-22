// (external)
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';

// (inner_folder)
import 'main_business.dart' as main_business;

// (all)
import 'package:flutter_project_template/global_widgets/gw_sfw_wrapper.dart'
    as gw_sfw_wrapper;

// [위젯 뷰]

//------------------------------------------------------------------------------
// (입력 데이터)
class InputVo {
  // !!!위젯 입력값 선언!!!
  const InputVo(
      {required this.onDialogCreated,
      required this.dialogTitle,
      required this.dialogContent,
      required this.positiveBtnTitle,
      required this.negativeBtnTitle});

  // (다이얼로그가 생성된 시점에 한번 실행 되는 콜백)
  final VoidCallback onDialogCreated;

  // 다이얼로그 타이틀
  final String dialogTitle;

  // 다이얼로그 본문
  final String dialogContent;

  // 긍정 버튼 문구
  final String positiveBtnTitle;

  // 부정 버튼 문구
  final String negativeBtnTitle;
}

// (결과 데이터)
class OutputVo {
  // !!!위젯 출력값 선언!!!
  const OutputVo({required this.checkPositiveBtn});

  // 다이얼로그 결과 : 긍정 버튼을 눌렀으면 true, 부정 버튼을 누르면 false
  final bool checkPositiveBtn;
}

//------------------------------------------------------------------------------
class MainWidget extends StatefulWidget {
  const MainWidget({super.key, required this.inputVo});

  final InputVo inputVo;

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
          if (mainBusiness.needCallOnDialogCreated) {
            mainBusiness.needCallOnDialogCreated = false;
            widget.inputVo.onDialogCreated();
          }
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
    mainBusiness.inputVo = widget.inputVo;
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

    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: SizedBox(
          width: 280,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 55,
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 17, right: 17),
                  child: Center(
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      mainBusiness.inputVo.dialogTitle,
                      style: const TextStyle(
                          fontSize: 17,
                          fontFamily: "MaruBuri",
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Container(
                height: 120,
                color: Colors.white,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 17, right: 17),
                    child: SingleChildScrollView(
                      child: Text(
                        mainBusiness.inputVo.dialogContent,
                        style: const TextStyle(
                            fontFamily: "MaruBuri", color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Colors.grey,
                height: 0.1,
              ),
              Container(
                height: 55,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16))),
                child: Center(
                  child: Container(
                    constraints:
                        const BoxConstraints(minWidth: 100, maxWidth: 230),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: ElevatedButton(
                            onPressed: () {
                              mainBusiness.onNegativeBtnClicked();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            child: Text(
                              mainBusiness.inputVo.negativeBtnTitle,
                              style: const TextStyle(
                                  color: Colors.white, fontFamily: "MaruBuri"),
                            ),
                          ),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        Expanded(
                          flex: 5,
                          child: ElevatedButton(
                            onPressed: () {
                              mainBusiness.onPositiveBtnClicked();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            child: Text(
                              mainBusiness.inputVo.positiveBtnTitle,
                              style: const TextStyle(
                                  color: Colors.white, fontFamily: "MaruBuri"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
