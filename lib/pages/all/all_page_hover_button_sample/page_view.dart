// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)
import '../../../global_widgets/gw_page_out_frames.dart' as gw_page_out_frames;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../global_widgets/gw_custom_widgets.dart' as gw_custom_widgets;

// [페이지 화면 위젯 작성 파일]
// 페이지 화면 구현을 담당합니다. (Widget 과 Business 간의 결합을 담당)
// 로직 처리는 pageBusiness 객체에 위임하세요.

//------------------------------------------------------------------------------
// (페이지 UI 위젯)
// !!!세부 화면 정의!!
class PageView extends StatelessWidget {
  const PageView({super.key});

  @override
  Widget build(BuildContext context) {
    // pageBusiness 객체
    page_business.PageBusiness pageBusiness =
        BlocProvider.of<gc_template_classes.BlocPageInfo>(context)
            .state
            .pageBusiness;

    return gw_page_out_frames.PageOutFrame(
        "호버 버튼 샘플",
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Center(
                child: ClipOval(
                    child: Container(
                  color: Colors.blue,
                  width: 150,
                  height: 150,
                  child: gw_custom_widgets.HoverButton(
                    onTap: () {
                      pageBusiness.onHoverButton1Click();
                    },
                    hoveringColor: Colors.blue[100],
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 120,
                    ),
                  ),
                )),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  color: Colors.blue,
                  width: 150,
                  height: 150,
                  child: gw_custom_widgets.HoverButton(
                    hoveringColor: Colors.blue[100],
                    onTap: () {
                      pageBusiness.onHoverButton2Click();
                    },
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 120,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  color: Colors.blue,
                  width: 150,
                  height: 150,
                  child: gw_custom_widgets.HoverButton(
                    hoveringColor: Colors.blue[100],
                    onTap: () {
                      pageBusiness.onHoverButton3Click();
                    },
                    child: Image(
                      image: const AssetImage(
                          "lib/assets/images/init_splash_logo.png"),
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
              ),
              const SizedBox(
                height: 30,
              ),
              ListView.builder(
                itemCount: 5,
                shrinkWrap: true, // 리스트뷰 크기 고정
                primary: false, // 리스트뷰 내부는 스크롤 금지
                itemBuilder: (context, index) {
                  return gw_custom_widgets.HoverButton(
                      hoveringColor: Colors.blue[100],
                      onTap: () {
                        pageBusiness.onHoverButton4Click();
                      },
                      child: Column(
                        children: [
                          ListTile(
                            mouseCursor: SystemMouseCursors.click,
                            title: Text(
                              "item$index",
                              style: const TextStyle(fontFamily: "MaruBuri"),
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                            height: 0.1,
                          ),
                        ],
                      ));
                },
              )
            ],
          ),
        ));
  }
}
