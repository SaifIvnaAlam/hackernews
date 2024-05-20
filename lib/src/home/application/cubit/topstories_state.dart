part of 'topstories_cubit.dart';

@freezed
class TopstoriesState with _$TopstoriesState {
  const factory TopstoriesState.initial() = _Initial;
  const factory TopstoriesState.loading() = _Loading;
  const factory TopstoriesState.loaded(
      List<Story> topStories, List<Story> latestStories) = _Loaded;
  const factory TopstoriesState.error(Failure error) = _Error;
}
