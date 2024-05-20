import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hackernews/src/home/domain/entity/failure.dart';
import 'package:hackernews/src/home/domain/entity/top_stories_model.dart';
import 'package:hackernews/src/home/domain/interface/i_top_news_repository.dart';

part 'topstories_cubit.freezed.dart';
part 'topstories_state.dart';

class TopstoriesCubit extends Cubit<TopstoriesState> {
  TopstoriesCubit(this._repo) : super(const TopstoriesState.initial());
  final ITopNewsRepository _repo;
  int _page = 0;
  final int _limit = 10;

  Future<void> fetchStories() async {
    final startIndex = _page * _limit;
    List<Story> topStories =
        await _repo.fetchTopStories(startIndex: startIndex, limit: _limit);
    List<Story> latestStories =
        await _repo.fetchLatestStories(startIndex: startIndex, limit: _limit);
    if (topStories.isNotEmpty) {
      emit(TopstoriesState.loaded(topStories, latestStories));
      _page++;
    } else {
      emit(
        TopstoriesState.error(
          Failure(statusCode: 520, error: 'Error Fetching Data'),
        ),
      );
    }
  }
}
