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
  final String page;
  final String content;

  const SectionData({
    required this.title,
    required this.page,
    required this.content,
  });
  factory SectionData.fromJson(Map<String, dynamic> json, String content) {
    return SectionData(
      title: json['title'],
      page: json['page'],
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

const section1 = [
  {
    'title': 'فوائد الرضاعة الطبيعية للرضع',
    'page': page1_1,
  },
  {
    'title': 'فوائد الرضاعة الطبيعية للأم',
    'page': page1_2,
  },
  {
    'title': 'وقت الرضاع',
    'page': page1_3,
  },
];

const page1_1 = [
  {
    'text':
        'توفر الرضاعة الطبيعية فوائد صحيةً لا مثيل لها للطفل والأم؛ فحليب الثدي مصمم بشكل فريد لتلبية الإحتياجات الصحية للطفل في مرحلة النمو، وهو الغذاء المثالي للرضع؛ حيث إنه آمِن لهم، كما أنه يعزز جهاز المناعة لدى الرضع؛ مما يُسهِم في حمايته من العديد من أمراض الطفولة الشائعة، كما يوفر حليب الأم كلَّ الطاقة والمغذيات التي يحتاجها الرضيع في الأشهر الأولى من حياته، ويستمر في توفير ما يصل إلى نصف أو أكثر من احتياجات الطفل الغذائية بين عمر  6 أشهر و12 شهرًا، وثلث احتياجات الطاقة بين 12 و24 شهرًا. وتتضح أهمية الرضاعة الطبيعية للطفل فيما يلي:'
  },
  {
    'highlighted':
        'يحتوي حليب الثدي على الكمية المناسبة من الدهون والسكر والماء والبروتين والمعادن اللازمة لنمو الطفل وتطوره'
  },
  {
    'highlighted':
        'حليب الثدي أسهل في الهضم من الحليب الاصطناعي، كما أن الأطفال الذين يرضعون من الثدي يعانون من غازات أقل ومشاكل رضاعة وإمساك أقل.'
  },
  {
    'highlighted':
        'يحتوي حليب الثدي على أجسام مضادة تحمي الأطفال من أمراض معينة (مثل: التهابات الأذن، والإسهال، وأمراض الجهاز التنفسي، والحساسية(.'
  },
  {'highlighted': 'تقوي الرضاعة الطبيعية العلاقة بين الطفل الرضيع والأم.'},
  {
    'highlighted':
        'حليب الأم هو أكثر من غذاء "فقط"، فهو يوفر للطفل الرضيع مناعة وقائية، حيث لا يستطيع أي غذاء أطفال رضع اخر توفيرها.'
  },
  {
    'highlighted':
        'تقلل الرضاعة الطبيعية خطر الإصابة بالسمنة في الحياة في وقت لاحق وكذلك الأمراض المرتبطة بالسمنة مثل السكري وإرتفاع ضغط الدم.'
  },
  {'highlighted': 'تقليل مخاطر الإصابة بالربو.'},
  {'highlighted': 'تقليل مخاطر الإصابة بمتلازمة موت الرضيع المفاجئ.'},
  {'highlighted': 'تقليل مخاطر الإصابة بالتهاب الأمعاء والقولون للخدج.'},
  {
    'highlighted':
        'أظهرت الدراسات أن مشاكل المعدة والعيون والجهاز التنفسي شائعة أكثر بين الأطفال الذين يتغذون على ألبان صناعية.'
  },
];
const page1_2 = [
  {
    'image': 'assets/images/page1/2.jpg',
  },
  {
    'highlighted':
        'تُسهِّل الرضاعة الطبيعية فقدان الوزن الذي اكتُسِب أثناء الحمل.'
  },
  {'highlighted': 'تقليل مخاطر الإصابة بضغط دم مرتفع.'},
  {'highlighted': 'تقليل مخاطر الإصابة بالسكري من النوع الثاني.'},
  {'highlighted': 'تقليل مخاطر الإصابة بسرطان المبيض والثدي.'},
  {
    'highlighted':
        'تساعد الرضاعة الطبيعية على إفراز الأوكسيتوسين والذي يساعد على انقباض الرحم وعودته الى حجمه الطبيعي, وتقليل كمية الدم بعد الولادة.'
  },
  {'highlighted': 'توفر الرضاعة الطبيعية الكثير من التكاليف المادية للأسرة.'},
  {
    'highlighted':
        'تستطيع كل إمرأة معنية بذلك القيام بالرضاعة الطبيعية تقريبا . حتى في الحالات التي من الممكن أن تكون فيها الرضاعة الطبيعية جزئية فقط مع الاصطناعية ، هذا الوضع أفضل من عدم الرضاعة الطبيعية على الإطلاق. '
  },
  {
    'highlighted':
        'على الرغم من أن الرضاعة الطبيعية هي الطريقة الأكثر طبيعية لتغذية الطفل الرضيع، فهي تعتبر أيضا  عملية تعلم من قبل الأم والطفل. هناك بعض الأمهات اللواتي يواجهن صعوبة في بداية الطريق ، لذلك في حال فشل كل المحاولات من قبل الأم في القيام بالرضاعة الطبيعية فمن المهم الحصول على مساعدة من قبل المتخصصين وعدم الاستسلام للرضاعة الصناعية.'
  },
];

const page1_3 = [
  {
    'image': 'assets/images/page1/3.jpg',
  },
  {
    'text': 'يتم محاولة إرضاع الرضيع بمجرد أن يبدأ في إظهار علامات الجوع وتشمل:'
  },
  {'highlighted': 'استيقاظ الرضيع من النوم.'},
  {'highlighted': 'تحريك الرأس والفم للبحث عن ثدي الأم.'},
  {'highlighted': 'مص اليدين، أو الشفتين، أو اللسان أو ملابسه.'},
  {
    'highlighted':
        'البكاء الشديد، ويدل على شدة الجوع، ولا يوصَى بتأخير الرضاعة حتى بكاء الرضيع.'
  }
];
