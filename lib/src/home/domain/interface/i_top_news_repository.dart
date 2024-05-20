import 'package:hackernews/src/home/domain/entity/top_stories_model.dart';

abstract class ITopNewsRepository {
  Future<List<Story>> fetchTopStories({int startIndex = 0, int limit = 20});

  Future<List<Story>> fetchLatestStories({int startIndex = 0, int limit = 20});
}
