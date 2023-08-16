import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:url_launcher/url_launcher.dart';

class Episode extends StatelessWidget {
  final AsyncSnapshot<List<WebtoonEpisodeModel>> snapshot;
  final String webtoonId;
  const Episode({
    super.key,
    required this.snapshot,
    required this.webtoonId,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        var episode = snapshot.data![index];
        onButtonTop() async {
          final url = Uri.parse(
              "https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episode.id}");
          await launchUrl(url);
        }

        return GestureDetector(
          onTap: onButtonTop,
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 1,
                color: Colors.green,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    episode.title,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemCount: snapshot.data!.length,
    );
  }
}
