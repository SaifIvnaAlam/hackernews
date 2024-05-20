import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackernews/src/home/presentation/home_page.dart';
import 'package:hackernews/src/home/application/cubit/topstories_cubit.dart';
import 'package:hackernews/src/home/infrastructure/top_news_repository.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TopstoriesCubit>(
          create: (context) => TopstoriesCubit(TopNewsRepository()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: const HomePage(),
      ),
    );
  }
}
