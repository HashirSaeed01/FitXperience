class Food {
  final int id;
  final String title;
  final String image;
  final String? imageType;
  final int? servings;
  final int? readyInMinutes;
  final String? license;
  final String? sourceName;
  final String? sourceUrl;
  final String? spoonacularSourceUrl;
  final int? healthScore;
  final String? summary;
  final bool? veryHealthy;
  final String? fat;
  final int? calories;

  Food(
      {required this.healthScore,
      required this.id,
      required this.title,
      required this.image,
      required this.imageType,
      required this.servings,
      required this.readyInMinutes,
      required this.license,
      required this.sourceName,
      required this.sourceUrl,
      required this.spoonacularSourceUrl,
      required this.summary,
      required this.veryHealthy,
      required this.fat,
      required this.calories});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
        id: json['id'],
        title: json['title'],
        image: json['image'],
        imageType: json['imageType'],
        servings: json['servings'],
        readyInMinutes: json['readyInMinutes'],
        license: json['license'],
        sourceName: json['sourceName'],
        sourceUrl: json['sourceUrl'],
        spoonacularSourceUrl: json['spoonacularSourceUrl'],
        healthScore: json['healthScore'],
        summary: json['summary'],
        veryHealthy: json['veryHealthy'],
        fat: json['fat'],
        calories: json['calories']);
  }
}
