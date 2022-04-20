import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> {
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  final TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          border: Border.all(color: const Color(0x1C000000), width: 1)),
      child: TextField(
        controller: editingController,
        focusNode: focusNode,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          focusColor: Colors.black,
          hintStyle: const TextStyle(
              color: Color(0x59000000), fontWeight: FontWeight.normal),
          border: InputBorder.none,
          icon: const Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(Icons.search, color: Color(0x54000000)),
          ),
          suffixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "command.svg",
                height: 20,
                width: 20,
              ),
            ],
          ),
          hintText: "Search by icon variable name...",
        ),
      ),
    );
  }
}
