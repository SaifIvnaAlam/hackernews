import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hackernews/src/home/domain/entity/top_stories_model.dart';

class NewsList extends StatelessWidget {
  final List<Story> stories;

  const NewsList({required this.stories, super.key});

  @override
  Widget build(BuildContext context) {
    for (var element in stories) {
      log(element.toString());
    }
    return ListView.builder(
      itemCount: stories.length,
      itemBuilder: (BuildContext context, int index) {
        var story = stories[index];
        var formattedTime =
            DateTime.fromMillisecondsSinceEpoch(story.time * 1000);

        return Card(
          margin: const EdgeInsets.all(10),
          child: ListTile(
            onTap: () {
              log(story.url);
            },
            leading: Text("Score: ${story.score.toString()}"),
            title: Text(story.title),
            subtitle: Text('Author: ${story.by}\n @ $formattedTime'),
            contentPadding: const EdgeInsets.all(20),
            trailing: Chip(label: Text(story.type)),
          ),
        );
      },
    );
  }
}
