import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

enum ContentType { text, highlighted, bold, image }

Future<List<TabData>> loadTabs() async {
  // Load the JSON file
  final String jsonString =
      await rootBundle.loadString('assets/data/tabs.json');

  // Decode the JSON string into a dynamic structure
  final List<dynamic> jsonResponse = json.decode(jsonString);

  // Map the dynamic list to a list of TabData objects
  return jsonResponse.map((data) => TabData.fromJson(data)).toList();
}

class TabData {
  final String title;
  final String iconPath;
  final String? imagePath;
  final String content;
  final String? directPage;

  const TabData({
    required this.title,
    required this.iconPath,
    required this.imagePath,
    required this.content,
    required this.directPage,
  });

  factory TabData.fromJson(Map<String, dynamic> json) {
    return TabData(
      title: json['title'],
      iconPath: json['iconPath'],
      imagePath: json['imagePath'],
      content: json['content'],
      directPage: json['directPage'],
    );
  }

  Future<List<SectionData>> loadSections() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/$content/sections.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse
        .map((data) => SectionData.fromJson(data, content))
        .toList();
  }

  Future<PageData> loadDirectPage() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/$content/pages.json');
    final Map<String, dynamic> jsonResponse = json.decode(jsonString);
    final List<dynamic> page = jsonResponse['pages'][directPage];
    final List<Map<String, dynamic>> pageList =
        page.map((item) => item as Map<String, dynamic>).toList();

    return PageData.fromJson(pageList, title);
  }
}

class SectionData {
  final String title;
  final String? page;
  final List<SectionData>? subSections;
  final String content;
  final String? imagePath;

  const SectionData({
    required this.title,
    required this.page,
    required this.subSections,
    required this.content,
    required this.imagePath,
  });

  factory SectionData.fromJson(Map<String, dynamic> json, String content) {
    return SectionData(
      title: json['title'],
      page: json['page'],
      imagePath: json['imagePath'],
      subSections: json['sub'] != null
          ? (json['sub'] as List<dynamic>)
              .map((data) => SectionData.fromJson(data, content))
              .toList()
          : null,
      content: content,
    );
  }

  Future<PageData> loadPage() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/$content/pages.json');
    final Map<String, dynamic> jsonResponse = json.decode(jsonString);
    final List<dynamic> page = jsonResponse['pages'][this.page];
    final List<Map<String, dynamic>> pageList =
        page.map((item) => item as Map<String, dynamic>).toList();

    return PageData.fromJson(pageList, title);
  }
}

class PageData {
  final String title;
  final List<PageContent> content;

  const PageData({
    required this.title,
    required this.content,
  });

  factory PageData.fromJson(List<Map<String, dynamic>> json, String title) {
    final List<PageContent> content =
        json.map((data) => PageContent.fromJson(data)).toList();
    return PageData(
      title: title,
      content: content,
    );
  }
}

class PageContent {
  final ContentType type;
  final String content;

  const PageContent({
    required this.type,
    required this.content,
  });

  factory PageContent.fromJson(Map<String, dynamic> json) {
    ContentType feildType = ContentType.text;
    switch (json.keys.first) {
      case 'highlighted':
        feildType = ContentType.highlighted;
        break;
      case 'bold':
        feildType = ContentType.bold;
        break;
      case 'image':
        feildType = ContentType.image;
        break;
      default:
        feildType = ContentType.text;
    }
    return PageContent(
      type: feildType,
      content: json.values.first,
    );
  }
}
