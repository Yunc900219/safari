import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:safari_v1/button_component.dart';
import 'package:safari_v1/safari_controller.dart';
import 'package:safari_v1/web_icon_component.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'ThemeColorHelper.dart';

class SafariPage extends StatefulWidget {
  const SafariPage({super.key});

  @override
  State<SafariPage> createState() => _SafariPageState();
}

class _SafariPageState extends State<SafariPage> {
  final FocusNode _focusNode = FocusNode();
  final RxBool _isFocus = false.obs;
  final SafariController safariController = Get.put(SafariController());

  @override
  void initState() {
    _focusNode.addListener(() {
      _isFocus.value = _focusNode.hasFocus;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColorHelper().webBG,
        actions: [
          Obx(
            () => _isFocus.value
                ? CloseButton(focusNode: _focusNode)
                : SizedBox.shrink(),
          ),
        ],
      ),
      backgroundColor: ThemeColorHelper().webBG,
      body: GestureDetector(
        onTap: () {
          _focusNode.unfocus();
        },
        child: Column(
          children: [
            Obx(
              () => safariController.isOpenWebView.value
                  ? Flexible(
                      child: WebViewWidget(
                        controller: safariController.controller,
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.h),
                      child: FavoritesWidget(),
                    ),
            ),
            Obx(
              () => !safariController.isOpenWebView.value
                  ? Spacer()
                  : SizedBox.shrink(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SearchBar(focusNode: _focusNode, isFocus: _isFocus),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  SearchBar({super.key, required this.focusNode, required this.isFocus});

  TextEditingController textEditingController = TextEditingController();
  final SafariController safariController = Get.find();

  final FocusNode focusNode;
  final RxBool isFocus;

  Widget barButton(IconData name, void Function() function) {
    return GestureDetector(
      onTap: function,
      child: Icon(name, size: 24, color: Colors.blue[300]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      color: ThemeColorHelper().webBarBG,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Container(
                height: 42.h,
                decoration: BoxDecoration(
                  color: ThemeColorHelper().textFieldBG,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Center(
                    child: Obx(
                      () => TextFormField(
                        controller: textEditingController,
                        focusNode: focusNode,
                        decoration: InputDecoration(
                          icon: !isFocus.value
                              ? Icon(
                                  Icons.search,
                                  color: ThemeColorHelper().textFieldHint,
                                )
                              : SizedBox.shrink(),
                          suffixIcon: SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.mic,
                                  color: ThemeColorHelper().textFieldHint,
                                ),
                                SizedBox(width: 15.w),
                                if (isFocus.value)
                                  TapIconButtonComponent(
                                    icon: Icon(
                                      Icons.close_rounded,
                                      size: 12,
                                      color: ThemeColorHelper().textFieldBG,
                                    ),
                                    tapFunction: () {
                                      textEditingController.clear();
                                    },
                                    backgroundColor:
                                        ThemeColorHelper().textFieldHint,
                                    size: 16,
                                  ),
                              ],
                            ),
                          ),
                          suffixIconConstraints: BoxConstraints(
                            minHeight: 30.h,
                          ),
                          border: InputBorder.none,
                          hintText: 'Search or enter website',

                          hintStyle: TextStyle(
                            fontSize: 16.sp,
                            color: ThemeColorHelper().textFieldHint,
                          ),
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 11.h,
                          ), // 調整內部間距
                        ),
                        textAlign:
                            isFocus.value ? TextAlign.start : TextAlign.center,
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                        onFieldSubmitted: (value) {
                          try {
                            safariController.loadRequest(value.trim());
                            safariController.isOpenWebView.value = true;
                          } catch (e) {
                            print('e: $e');
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 26.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  barButton(Icons.arrow_back_ios_new_rounded, () {
                    safariController.controller.goBack();
                  }),
                  barButton(Icons.arrow_forward_ios_rounded, () {
                    safariController.controller.goForward();
                  }),
                  barButton(Icons.ios_share_rounded, () {}),
                  barButton(Icons.menu_book_rounded, () {}),
                  barButton(Icons.content_copy_rounded, () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoritesWidget extends StatelessWidget {
  const FavoritesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset('assets/icons/user.svg', color: Colors.white),
            SizedBox(width: 8.w),
            Text(
              'Favorites',
              style: TextStyle(
                fontFamily: 'CustomFont',
                fontSize: 22.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textHeightBehavior: TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            WebIconComponent(
              icon: Padding(
                padding: EdgeInsets.all(10),
                child: SvgPicture.asset(
                  'assets/icons/apple.svg',
                  color: Colors.grey[600],
                  height: 50.h,
                ),
              ),
              backgroundColor: Colors.white,
              text: 'Apple',
            ),
            WebIconComponent(
              icon: Padding(
                padding: EdgeInsets.all(10),
                child: SvgPicture.asset(
                  'assets/icons/apple.svg',
                  color: Colors.grey[400],
                  height: 50.h,
                ),
              ),
              backgroundColor: Colors.grey[600],
              text: 'iColud',
            ),
            WebIconComponent(
              icon: Padding(
                padding: EdgeInsets.all(10),
                child: SvgPicture.asset(
                  'assets/icons/google.svg',
                  height: 50.h,
                ),
              ),
              backgroundColor: Colors.white,
              text: 'Google',
            ),
            WebIconComponent(
              icon: Padding(
                padding: EdgeInsets.all(10),
                child: SvgPicture.asset(
                  'assets/icons/x.svg',
                  color: Colors.white,
                  height: 40.h,
                ),
              ),
              backgroundColor: Colors.black,
              text: 'Twitter',
            ),
          ],
        ),
      ],
    );
  }
}

class CloseButton extends StatelessWidget {
  CloseButton({super.key, required this.focusNode});

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.h),
      child: TapIconButtonComponent(
        icon: Icon(
          Icons.close_rounded,
          size: 22,
          color: ThemeColorHelper().closeButton,
        ),
        tapFunction: () {
          focusNode.unfocus();
        },
        size: 28,
      ),
    );
  }
}
