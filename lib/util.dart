import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FlutterMaterialIconsHelper {
  List<FlutterMaterialIcon>? _cachedIcons;

  Future<List<FlutterMaterialIcon>> getIconsWithFilter(String keyword) async {
    keyword = keyword.toLowerCase().replaceAll(" ", "");

    var icons = await _fetchIcons();

    if(keyword.isEmpty) {
      return icons;
    }

    return icons
        .where(
          (icon) =>
              icon.name.toLowerCase().contains(keyword) ||
              icon.variableName.toLowerCase().contains(keyword),
        )
        .toList();
  }

  Future<List<FlutterMaterialIcon>> _fetchIcons() async {
    if (_cachedIcons != null) {
      return _cachedIcons!;
    }

    var url = Uri.parse(
        "https://raw.githubusercontent.com/flutter/flutter/master/packages/flutter/lib/src/material/icons.dart");
    var response = await http.get(url);

    var lines =
        response.body.split("\n").where((line) => line.isNotEmpty).toList();

    List<FlutterMaterialIcon> fetchedIcons = [];

    for (int i = 0; i < lines.length; i++) {
      var line = lines[i];
      //ignore all other syntax
      if (!line.startsWith("  static const IconData ")) continue;

      //i-1 because every icon has a doc entry above it
      //example doc comment: <i class="material-icons-round md-36">360</i> &#x2014; material icon named "360" (round).
      var iconName =
          lines[i - 1].split("material icon named ")[1].replaceAll("\"", "");
      iconName = iconName.substring(0, iconName.length - 1);

      //cut off unimportant dart syntax
      line = line.split("IconData ")[1];

      var name = line.split(" ")[0];
      var iconDataRaw = line.split("= ")[1];
      iconDataRaw = iconDataRaw.substring(9, iconDataRaw.length - 2);

      fetchedIcons.add(
        FlutterMaterialIcon(
          name: iconName,
          variableName: name,
          data: IconData(
            int.parse(iconDataRaw.split(", ")[0]),
            //only process first value of string "0xe019, fontFamily: 'MaterialIcons');"
            fontFamily: "MaterialIcons",
          ),
        ),
      );
    }

    _cachedIcons = fetchedIcons;
    return fetchedIcons;
  }
}

class FlutterMaterialIcon {
  final String name;
  final String variableName;
  final IconData data;

  FlutterMaterialIcon(
      {required this.name, required this.variableName, required this.data});
}
