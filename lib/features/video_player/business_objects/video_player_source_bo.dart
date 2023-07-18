import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_player_source_bo.freezed.dart';

@freezed
class VideoPlayerSourceBO with _$VideoPlayerSourceBO {
  const factory VideoPlayerSourceBO.network(String dataSource) =
      VideoPlayerSourceBONetwork;

  const factory VideoPlayerSourceBO.file(File file) = VideoPlayerSourceBOFile;

  const factory VideoPlayerSourceBO.asset(String dataSource) =
      VideoPlayerSourceBOAsset;

  const factory VideoPlayerSourceBO.contentUri(Uri contentUri) =
      VideoPlayerSourceBOContentUri;
}
