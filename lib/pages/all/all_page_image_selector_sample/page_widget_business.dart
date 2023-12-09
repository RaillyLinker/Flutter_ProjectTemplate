// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

// (inner Folder)
import 'page_widget.dart' as page_widget;

// (all)
import '../../../global_widgets/gw_page_outer_frame/sl_widget_business.dart'
    as gw_page_outer_frame_business;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../dialogs/all/all_dialog_image_selector_menu/dialog_widget.dart'
    as all_dialog_image_selector_menu;
import '../../../dialogs/all/all_dialog_image_selector_menu/dialog_widget_business.dart'
    as all_dialog_image_selector_menu_business;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 담당
// PageBusiness 인스턴스는 해당 페이지가 소멸하기 전까지 활용됩니다.
class PageWidgetBusiness {
  // [콜백 함수]
  // (전체 위젯 initState)
  void initState() {
    // !!!initState 로직 작성!!!
  }

  // (전체 위젯 dispose)
  void dispose() {
    // !!!initState 로직 작성!!!
  }

  // (전체 위젯의 FocusDetector 콜백들)
  Future<void> onFocusGained() async {
    // !!!onFocusGained 로직 작성!!!
  }

  Future<void> onFocusLost() async {
    // !!!onFocusLost 로직 작성!!!
  }

  Future<void> onVisibilityGained() async {
    // !!!onFocusLost 로직 작성!!!
  }

  Future<void> onVisibilityLost() async {
    // !!!onVisibilityLost 로직 작성!!!
  }

  Future<void> onForegroundGained() async {
    // !!!onForegroundGained 로직 작성!!!
  }

  Future<void> onForegroundLost() async {
    // !!!onForegroundLost 로직 작성!!!
  }

  void onCheckPageInputVo({required GoRouterState goRouterState}) {
    // !!!pageInputVo 체크!!!
    // ex :
    // if (!goRouterState.uri.queryParameters
    //     .containsKey("inputValueString")) {
    //   // 필수 파라미터가 없는 경우에 대한 처리
    // }

    // !!!PageInputVo 입력!!!
    inputVo = const page_widget.InputVo();
  }

  // [public 변수]
  // BLoC 객체 샘플 :
  // final gc_template_classes.RefreshableBloc refreshableBloc = gc_template_classes.RefreshableBloc();

  late BuildContext context;

  // (위젯 입력값)
  late page_widget.InputVo inputVo;

  // (페이지 pop 가능 여부 변수)
  bool canPop = true;

  // (pageOutFrameBusiness)
  final gw_page_outer_frame_business.SlWidgetBusiness pageOutFrameBusiness =
      gw_page_outer_frame_business.SlWidgetBusiness();

  // 이미지 선택자
  ImagePicker imagePicker = ImagePicker();

  // 선택된 이미지
  Uint8List? selectedImage;

  // 선택 이미지 리스트 최대 개수
  int imageFileListMaxCount = 20;

  // 선택된 이미지 리스트
  List<Uint8List> imageFiles = [];

  final gc_template_classes.RefreshableBloc blocProfileImage =
      gc_template_classes.RefreshableBloc();

  final gc_template_classes.RefreshableBloc blocImageList =
      gc_template_classes.RefreshableBloc();

  // [private 변수]

  // [public 함수]
  // (Widget 화면 갱신) - WidgetUi.viewWidgetBuild 의 return 값을 다시 불러 옵니다.
  late VoidCallback refreshUi;

  // (프로필 이미지 클릭)
  Future<void> onProfileImageTap() async {
    final all_dialog_image_selector_menu_business.PageWidgetBusiness
        allDialogImageSelectorMenuBusiness =
        all_dialog_image_selector_menu_business.PageWidgetBusiness();

    if (!context.mounted) return;
    var pageOutputVo = await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => all_dialog_image_selector_menu.DialogWidget(
              business: allDialogImageSelectorMenuBusiness,
              inputVo: all_dialog_image_selector_menu.InputVo(
                  cameraAvailable:
                      // 카메라는 모바일 환경에서만
                      !kIsWeb && (Platform.isAndroid || Platform.isIOS)),
              onDialogCreated: () {},
            ));

    if (pageOutputVo != null) {
      switch (pageOutputVo.imageSourceType) {
        case all_dialog_image_selector_menu.ImageSourceType.gallery:
          {
            // 갤러리에서 선택하기
            try {
              final XFile? pickedFile = await imagePicker.pickImage(
                  source: ImageSource.gallery,
                  maxHeight: 1280,
                  maxWidth: 1280,
                  imageQuality: 70);
              if (pickedFile != null) {
                // JPG or PNG
                var image = XFile(pickedFile.path);
                var bytes = await image.readAsBytes();
                selectedImage = bytes;
                blocProfileImage.refreshUi();
              }
            } catch (_) {}
          }
          break;
        case all_dialog_image_selector_menu.ImageSourceType.camera:
          {
            // 사진 찍기
            try {
              final XFile? pickedFile = await imagePicker.pickImage(
                  source: ImageSource.camera,
                  maxHeight: 1280,
                  maxWidth: 1280,
                  imageQuality: 70);
              if (pickedFile != null) {
                // JPG or PNG
                var image = XFile(pickedFile.path);
                var bytes = await image.readAsBytes();
                selectedImage = bytes;
                blocProfileImage.refreshUi();
              }
            } catch (_) {}
          }
          break;
        case all_dialog_image_selector_menu.ImageSourceType.defaultImage:
          {
            // 기본 프로필 이미지 적용
            selectedImage = null;
            blocProfileImage.refreshUi();
          }
          break;
        default:
          {
            // 알 수 없는 코드일 때
            throw Exception("unKnown Error Code");
          }
      }
    }
  }

  // (이미지 추가 버튼 클릭)
  Future<void> pressAddPictureBtn() async {
    //최대 3장까지 입력
    if (imageFiles.length >= imageFileListMaxCount) {
      showToast("최대 ${imageFileListMaxCount}장까지만 입력 가능합니다",
          context: context, animation: StyledToastAnimation.scale);
      return;
    }

    final all_dialog_image_selector_menu_business.PageWidgetBusiness
        allDialogImageSelectorMenuBusiness =
        all_dialog_image_selector_menu_business.PageWidgetBusiness();

    if (!context.mounted) return;
    var pageOutputVo = await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => all_dialog_image_selector_menu.DialogWidget(
              business: allDialogImageSelectorMenuBusiness,
              inputVo: all_dialog_image_selector_menu.InputVo(
                  cameraAvailable:
                      // 카메라는 모바일 환경에서만
                      !kIsWeb && (Platform.isAndroid || Platform.isIOS)),
              onDialogCreated: () {},
            ));

    // todo : 추가시 로딩 다이얼로그
    if (pageOutputVo != null) {
      switch (pageOutputVo.imageSourceType) {
        case all_dialog_image_selector_menu.ImageSourceType.gallery:
          {
            // 갤러리에서 선택하기
            try {
              final List<XFile> pickedFiles = await imagePicker.pickMultiImage(
                  maxHeight: 1280, maxWidth: 1280, imageQuality: 70);
              if (pickedFiles.isNotEmpty) {
                for (var i = 0; i < pickedFiles.length; i++) {
                  if (imageFiles.length >= imageFileListMaxCount) {
                    break;
                  }

                  var pickedFile = pickedFiles[i];
                  var image = XFile(pickedFile.path);
                  var bytes = await image.readAsBytes();
                  imageFiles.add(bytes);
                }

                blocImageList.refreshUi();
              }
            } catch (_) {}
          }
          break;
        case all_dialog_image_selector_menu.ImageSourceType.camera:
          {
            // 사진 찍기
            try {
              final XFile? pickedFile = await imagePicker.pickImage(
                  source: ImageSource.camera,
                  maxHeight: 1280,
                  maxWidth: 1280,
                  imageQuality: 70);
              if (pickedFile != null) {
                // JPG or PNG
                var image = XFile(pickedFile.path);
                var bytes = await image.readAsBytes();
                imageFiles.add(bytes);

                blocImageList.refreshUi();
              }
            } catch (_) {}
          }
          break;
        case all_dialog_image_selector_menu.ImageSourceType.defaultImage:
          {
            // 기본 프로필 이미지 적용
            selectedImage = null;
            blocImageList.refreshUi();
          }
          break;
        default:
          {
            // 알 수 없는 코드일 때
            throw Exception("unKnown Error Code");
          }
      }
    }
  }

  void pressDeletePicture(int pictureListItemIdx) {
    imageFiles.removeAt(pictureListItemIdx);
    blocImageList.refreshUi();
  }

// [private 함수]
}
