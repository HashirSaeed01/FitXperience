class Exercise {
  final String bodyPart;
  final String equipment;
  final String gifUrl;
  final String id;
  final String name;
  final String target;
  final List<String> secondaryMuscles;
  final List<String> instructions;

  Exercise({
    required this.bodyPart,
    required this.equipment,
    required this.gifUrl,
    required this.id,
    required this.name,
    required this.target,
    required this.secondaryMuscles,
    required this.instructions,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      bodyPart: json['bodyPart'] as String,
      equipment: json['equipment'] as String,
      gifUrl: json['gifUrl'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
      target: json['target'] as String,
      secondaryMuscles: (json['secondaryMuscles'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );
  }
}
