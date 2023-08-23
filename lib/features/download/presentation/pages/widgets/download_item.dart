import 'dart:io';

import 'package:flutter/material.dart';
import 'package:netflix/core/extensions/color_extensions.dart';
import 'package:netflix/core/extensions/responsive_size_extensions.dart';
import 'package:netflix/core/manager/color/colors_manager.dart';

import '../../../../../core/components/vertical_spacer.dart';
import '../../../../video_player/presentation/video_player_file_screen.dart';
import '../../../data/model/movie_download_model.dart';

class DownloadItem extends StatelessWidget {
  const DownloadItem({
    super.key,
    required this.data,
    required this.onClickDelete,
  });

  final MovieDownloadModel data;

  final void Function()? onClickDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VideoPlayerFileScreen(
              videoPath: data.streamUrl,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: double.infinity,
        height: context.height * 0.15,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.file(
                    File(data.image),
                    height: double.infinity,
                    width: context.width * 0.35,
                    fit: BoxFit.cover,
                  ),
                  const Icon(
                    Icons.play_circle,
                    color: AppColorsManager.white,
                    size: 35,
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                            ),
                            child: Text(
                              data.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const VerticalSpacer(5),
                        Text(
                          "${data.time}m",
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const VerticalSpacer(10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            data.movieSize,
                            style: TextStyle(
                              fontSize: 12.5,
                              color: context.accentColor,
                            ),
                          ),
                        ),
                        const VerticalSpacer(10),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: onClickDelete,
                    icon: Icon(
                      Icons.delete_outline_outlined,
                      color: context.accentColor,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
