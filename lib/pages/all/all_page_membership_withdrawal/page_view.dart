// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)
import '../../../global_widgets/gw_page_out_frames.dart' as gw_page_out_frames;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;

// [페이지 화면 위젯 작성 파일]
// 페이지 화면 구현을 담당합니다.
// 로직 처리는 pageBusiness 객체에 위임하세요.

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

    return gw_page_out_frames.PageOutFrame(
      "회원 탈퇴",
      SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 320,
                margin: const EdgeInsets.only(top: 40),
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 2, bottom: 2),
                decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        // POINT
                        color: Colors.black,
                        width: 2.0,
                      ),
                      right: BorderSide(
                        // POINT
                        color: Colors.black,
                        width: 2.0,
                      ),
                      bottom: BorderSide(
                        // POINT
                        color: Colors.black,
                        width: 2.0,
                      ),
                      top: BorderSide(
                        // POINT
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: const SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "주의",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontFamily: "MaruBuri",
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '이곳에 회원 탈퇴 주의사항을 쓰세요.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Nisl tincidunt eget nullam non. Quis hendrerit dolor magna eget est lorem ipsum dolor sit. Volutpat odio facilisis mauris sit amet massa. Commodo odio aenean sed adipiscing diam donec adipiscing tristique. Mi eget mauris pharetra et. Non tellus orci ac auctor augue. Elit at imperdiet dui accumsan sit. Ornare arcu dui vivamus arcu felis. Egestas integer eget aliquet nibh praesent. In hac habitasse platea dictumst quisque sagittis purus. Pulvinar elementum integer enim neque volutpat ac. Senectus et netus et malesuada. Nunc pulvinar sapien et ligula ullamcorper malesuada proin. Neque convallis a cras semper auctor. Libero id faucibus nisl tincidunt eget. Leo a diam sollicitudin tempor id. A lacus vestibulum sed arcu non odio euismod lacinia. In tellus integer feugiat scelerisque. Feugiat in fermentum posuere urna nec tincidunt praesent. Porttitor rhoncus dolor purus non enim praesent elementum facilisis. Nisi scelerisque eu ultrices vitae auctor eu augue ut lectus. Ipsum faucibus vitae aliquet nec ullamcorper sit amet risus. Et malesuada fames ac turpis egestas sed. Sit amet nisl suscipit adipiscing bibendum est ultricies. Arcu ac tortor dignissim convallis aenean et tortor at. Pretium viverra suspendisse potenti nullam ac tortor vitae purus. Eros donec ac odio tempor orci dapibus ultrices. Elementum nibh tellus molestie nunc. Et magnis dis parturient montes nascetur. Est placerat in egestas erat imperdiet. Consequat interdum varius sit amet mattis vulputate enim.Sit amet nulla facilisi morbi tempus. Nulla facilisi cras fermentum odio eu. Etiam erat velit scelerisque in dictum non consectetur a erat. Enim nulla aliquet porttitor lacus luctus accumsan tortor posuere. Ut sem nulla pharetra diam. Fames ac turpis egestas maecenas. Bibendum neque egestas congue quisque egestas diam. Laoreet id donec ultrices tincidunt arcu non sodales neque. Eget felis eget nunc lobortis mattis aliquam faucibus purus. Faucibus interdum posuere lorem ipsum dolor sit.',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: "MaruBuri"),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                  width: 300,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20, top: 5),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        pageBusiness.toggleAgreeButton();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "동의합니다",
                            style: TextStyle(fontFamily: "MaruBuri"),
                          ),
                          BlocBuilder<page_business.BlocAgreeCheckBox, bool>(
                              builder: (c, s) {
                            return Checkbox(
                                activeColor: Colors.blue,
                                checkColor: Colors.white,
                                value:
                                    pageBusiness.pageViewModel.withdrawalAgree,
                                onChanged: (value) {
                                  pageBusiness.toggleAgreeButton();
                                });
                          }),
                        ],
                      ),
                    ),
                  )),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  pageBusiness.accountWithdrawalAsync();
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                child: const Text(
                  '회원 탈퇴',
                  style: TextStyle(fontFamily: "MaruBuri"),
                ),
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}
