import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackernews/src/home/application/cubit/topstories_cubit.dart';
import 'package:hackernews/src/home/presentation/components/news_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TopstoriesCubit>().fetchStories();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hacker News'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Top Stories'),
              Tab(text: 'Latest Stories'),
            ],
          ),
        ),
        body: BlocBuilder<TopstoriesCubit, TopstoriesState>(
          builder: (context, state) {
            return state.map(
              initial: (value) =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              loading: (value) =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              loaded: (value) {
                return TabBarView(
                  children: [
                    NewsList(stories: value.topStories),
                    NewsList(stories: value.latestStories),
                  ],
                );
              },
              error: (value) => Center(
                child: Column(
                  children: [
                    Text("${value.error.statusCode}"),
                    Text(value.error.error),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
