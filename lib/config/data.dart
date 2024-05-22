import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

enum ContentType { text, highlighted, image }

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
  final String imagePath;
  final String content;

  const TabData({
    required this.title,
    required this.iconPath,
    required this.imagePath,
    required this.content,
  });

  factory TabData.fromJson(Map<String, dynamic> json) {
    return TabData(
      title: json['title'],
      iconPath: json['iconPath'],
      imagePath: json['imagePath'],
      content: json['content'],
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
}

class SectionData {
  final String title;
  final String? page;
  final List<SectionData>? subSections;
  final String content;

  const SectionData({
    required this.title,
    required this.page,
    required this.subSections,
    required this.content,
  });

  factory SectionData.fromJson(Map<String, dynamic> json, String content) {
    return SectionData(
      title: json['title'],
      page: json['page'],
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
    return PageContent(
      type: json.keys.first == 'highlighted'
          ? ContentType.highlighted
          : json.keys.first == 'image'
              ? ContentType.image
              : ContentType.text,
      content: json.values.first,
    );
  }
}
