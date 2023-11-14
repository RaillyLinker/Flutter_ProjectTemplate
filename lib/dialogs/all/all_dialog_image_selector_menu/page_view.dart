// (external)
import 'package:flutter/material.dart';

// (page)
import 'page_business.dart' as page_business;
import 'page_entrance.dart' as page_entrance;

// [페이지 화면 위젯 작성 파일]
// 페이지 화면 구현을 담당합니다.
// 로직 처리는 pageBusiness 객체에 위임하세요.

//------------------------------------------------------------------------------
// (페이지 UI 위젯)
// !!!세부 화면 정의!!!
class PageView extends StatelessWidget {
  const PageView(this._pageBusiness, {super.key});

  // 페이지 비즈니스 객체
  final page_business.PageBusiness _pageBusiness;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: SingleChildScrollView(
            child: SizedBox(
                width: 280,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                    height: 55,
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16))),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 17, right: 17),
                      child: Center(
                        child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          "이미지 선택",
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: "MaruBuri",
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16))),
                      child: Center(
                          child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 17, right: 17),
                              child: SingleChildScrollView(
                                  child: Column(children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    _pageBusiness.onResultSelected(
                                        page_entrance.ImageSourceType.gallery);
                                  },
                                  child: const ListTile(
                                    mouseCursor: SystemMouseCursors.click,
                                    leading: Icon(Icons.photo),
                                    title: Text('앨범에서 선택'),
                                  ),
                                ),
                                _pageBusiness.pageInputVo.cameraAvailable
                                    ? GestureDetector(
                                        onTap: () {
                                          _pageBusiness.onResultSelected(
                                              page_entrance
                                                  .ImageSourceType.camera);
                                        },
                                        child: const ListTile(
                                          mouseCursor: SystemMouseCursors.click,
                                          leading: Icon(Icons.camera_alt),
                                          title: Text('사진 찍기'),
                                        ),
                                      )
                                    : const SizedBox(),
                                GestureDetector(
                                    onTap: () {
                                      _pageBusiness.onResultSelected(
                                          page_entrance
                                              .ImageSourceType.defaultImage);
                                    },
                                    child: const ListTile(
                                        mouseCursor: SystemMouseCursors.click,
                                        leading: Icon(Icons.account_box),
                                        title: Text('선택 취소')))
                              ])))))
                ]))));
  }
}
