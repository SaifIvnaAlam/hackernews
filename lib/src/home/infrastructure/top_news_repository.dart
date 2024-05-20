import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:hackernews/src/home/domain/entity/top_stories_model.dart';
import 'package:hackernews/src/home/domain/interface/i_top_news_repository.dart';

class TopNewsRepository implements ITopNewsRepository {
  @override
  Future<List<Story>> fetchTopStories(
      {int startIndex = 0, int limit = 20}) async {
    final url = Uri.parse(
        'https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> topStories = jsonDecode(response.body);
        log('Top stories: $topStories');

        List<dynamic> paginatedStories =
            topStories.skip(startIndex).take(limit).toList();
        log('Paginated stories: $paginatedStories');

        List<Future<Story?>> storyFutures =
            paginatedStories.map((storyId) async {
          log('Fetching story id: $storyId');
          final storyUrl = Uri.parse(
              'https://hacker-news.firebaseio.com/v0/item/$storyId.json?print=pretty');
          final storyResponse = await http.get(storyUrl);

          if (storyResponse.statusCode == 200) {
            dynamic storyDetails = jsonDecode(storyResponse.body);
            return Story.fromJson(storyDetails);
          } else {
            log('Failed to fetch story with id: $storyId');
            return null;
          }
        }).toList();

        List<Story?> stories = await Future.wait(storyFutures);

        stories = stories.where((story) => story != null).toList();

        log('Fetched ${stories.length} stories');
        return stories.cast<Story>();
      } else {
        throw Exception('Failed to load top stories');
      }
    } catch (e) {
      log('Error: $e');
      return [];
    }
  }

  @override
  Future<List<Story>> fetchLatestStories(
      {int startIndex = 0, int limit = 20}) async {
    final url = Uri.parse(
        'https://hacker-news.firebaseio.com/v0/newstories.json?print=pretty');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> latestStories = jsonDecode(response.body);
        log('latestStories stories: $latestStories');

        List<dynamic> paginatedStories =
            latestStories.skip(startIndex).take(limit).toList();
        log('Paginated latestStories stories: $paginatedStories');

        List<Future<Story?>> storyFutures =
            paginatedStories.map((storyId) async {
          log('latestStories story id: $storyId');
          final storyUrl = Uri.parse(
              'https://hacker-news.firebaseio.com/v0/item/$storyId.json?print=pretty');
          final storyResponse = await http.get(storyUrl);

          if (storyResponse.statusCode == 200) {
            dynamic storyDetails = jsonDecode(storyResponse.body);
            return Story.fromJson(storyDetails);
          } else {
            log('Failed to fetch latestStories with id: $storyId');
            return null;
          }
        }).toList();

        List<Story?> stories = await Future.wait(storyFutures);

        stories = stories.where((story) => story != null).toList();

        log('Fetched latestStories ${stories.length} stories');
        return stories.cast<Story>();
      } else {
        throw Exception('Failed to load latestStories stories');
      }
    } catch (e) {
      log('Error: $e');
      return [];
    }
  }
}
