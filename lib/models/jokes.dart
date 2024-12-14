class Jokes {
  final String type;
  final String setup;
  final String punchline;
  final int id;

  Jokes({required this.type, required this.setup, required this.punchline, required this.id});

  factory Jokes.fromJson(Map<String, dynamic> json) {
    return Jokes(
      type: json['type'],
      setup: json['setup'],
      punchline: json['punchline'],
      id: json['id'],
    );
  }
}
