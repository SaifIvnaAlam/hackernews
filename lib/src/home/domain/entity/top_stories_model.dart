class Story {
  final int id;
  final String by;
  final int descendants;
  final int score;
  final int time;
  final String title;
  final String type;
  final String url;

  Story({
    required this.id,
    required this.by,
    required this.descendants,
    required this.score,
    required this.time,
    required this.title,
    required this.type,
    required this.url,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'],
      by: json['by'] ?? 'Unknown',
      descendants: json['descendants'] ?? 0,
      score: json['score'] ?? 0,
      time: json['time'],
      title: json['title'] ?? 'No title',
      type: json['type'] ?? 'story',
      url: json['url'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Story{id: $id, by: $by, descendants: $descendants, score: $score, time: $time, title: $title, type: $type, url: $url}';
  }
}
