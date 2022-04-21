import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericonsbrowser/searchbar.dart';
import 'package:fluttericonsbrowser/util.dart';

class IconsView extends StatefulWidget {
  const IconsView({Key? key}) : super(key: key);

  @override
  State<IconsView> createState() => _IconsViewState();
}

class _IconsViewState extends State<IconsView> {
  final FlutterMaterialIconsHelper iconsHelper = FlutterMaterialIconsHelper();

  String filter = "";

  int calculateCrossAxisCount(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    if (width > 1000) {
      return 5;
    }

    if (width > 500) {
      return 4;
    }

    if (width > 300) {
      return 3;
    }

    return 2;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SearchBar(onChange: (v) {
          setState(() {
            filter = v;
          });
        }),
        Expanded(
            child: FutureBuilder(
          future: iconsHelper.getIconsWithFilter(filter),
          builder:
              (context, AsyncSnapshot<List<FlutterMaterialIcon>> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const CupertinoActivityIndicator();
            }

            if (snapshot.data!.isEmpty) {
              return const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text(
                  "No icon was found!",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.only(top: 50, left: 5, right: 5),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: calculateCrossAxisCount(context),
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) =>
                  IconTile(icon: snapshot.data![index]),
            );
          },
        ))
      ],
    );
  }
}

class IconTile extends StatelessWidget {
  final FlutterMaterialIcon icon;

  const IconTile({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: "Icons.${icon.variableName}"))
            .then((_) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
                  Text("${icon.variableName} was copied to your clipboard")));
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 30, bottom: 30),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(color: Color(0x0d000000), blurRadius: 9)
              ],
              border: Border.all(color: const Color(0x1A000000))),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon.data,
                color: const Color(0x99000000),
                size: 50,
              ),
              const SizedBox(height: 15),
              Text(
                icon.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: const Color(0xBF000000),
                    fontSize: icon.variableName.length > 15 ? 14 : 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
