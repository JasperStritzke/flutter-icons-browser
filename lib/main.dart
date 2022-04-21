import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttericonsbrowser/iconsview.dart';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:fluttericonsbrowser/searchbar.dart';

const repositoryUrl = "https://github.com/JasperStritzke/flutter-icons-browser";

void main() => runApp(const FlutterIconsBrowser());

class FlutterIconsBrowser extends StatelessWidget {
  const FlutterIconsBrowser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: const MediaQueryData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  static const int _margin = 30;

  double calculateWidth(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return width > 1000 ? 900 : width - _margin * 2;
  }

  final GlobalKey<SearchBarState> searchBar = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 60),
            width: calculateWidth(context),
            child: const IconsView(),
          )
        ],
      ),
      floatingActionButton: const GitHubButton(),
    );
  }
}

class GitHubButton extends StatelessWidget {
  const GitHubButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: MaterialButton(
        color: Colors.white,
        elevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () => openURL(repositoryUrl),
        child: SvgPicture.asset(
          "github.svg",
          color: const Color(0xD9000000),
        ),
      ),
    );
  }
}

void openURL(String url) {
  html.window.open(url, "_blank");
}
