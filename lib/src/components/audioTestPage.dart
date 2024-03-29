// ignore_for_file: file_names

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:quran/src/components/notifiers/play_button_notifier.dart';
import 'package:quran/src/components/notifiers/progress_notifier.dart';
import 'package:quran/src/components/notifiers/repeat_button_notifier.dart';
import 'package:quran/src/components/page_manager.dart';

// use GetIt or Provider rather than a global variable in a real project
PageManager _pageManager;

class AudioTestPage extends StatefulWidget {
  const AudioTestPage({Key key}) : super(key: key);

  @override
  _AudioTestPageState createState() => _AudioTestPageState();
}

class _AudioTestPageState extends State<AudioTestPage> {
  @override
  void initState() {
    super.initState();
    _pageManager = PageManager();
  }

  @override
  void dispose() {
    _pageManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              currentSongTitle(context),
              playlist(context),
              audioProgressBar(context),
              audioControlButtons(context),
            ],
          ),
        ),
      ),
    );
  }
}

// class CurrentSongTitle extends StatelessWidget {
//   const CurrentSongTitle({Key key}) : super(key: key);
@override
Widget currentSongTitle(BuildContext context) {
  return ValueListenableBuilder<String>(
    // valueListenable: _pageManager.currentSongTitleNotifier,
    builder: (_, title, __) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(title, style: TextStyle(fontSize: 40)),
      );
    },
  );
}
// }

// class Playlist extends StatelessWidget {
//   const Playlist({Key key}) : super(key: key);
@override
Widget playlist(BuildContext context) {
  return Expanded(
    child: ValueListenableBuilder<List<String>>(
      valueListenable: _pageManager.playlistNotifier,
      builder: (context, playlistTitles, _) {
        return ListView.builder(
          itemCount: playlistTitles.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${playlistTitles[index]}'),
            );
          },
        );
      },
    ),
  );
}
// }

// class AddRemoveSongButtons extends StatelessWidget {
//   const AddRemoveSongButtons({Key key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 20.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           FloatingActionButton(
//             onPressed: _pageManager.addReciter,
//             child: Icon(Icons.add),
//           ),
//           FloatingActionButton(
//             onPressed: _pageManager.removeReciter,
//             child: Icon(Icons.remove),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class AudioProgressBar extends StatelessWidget {
//   const AudioProgressBar({Key key}) : super(key: key);
@override
Widget audioProgressBar(BuildContext context) {
  return ValueListenableBuilder<ProgressBarState>(
    valueListenable: _pageManager.progressNotifier,
    builder: (_, value, __) {
      return ProgressBar(
        progress: value.current,
        buffered: value.buffered,
        total: value.total,
        onSeek: _pageManager.seek,
      );
    },
  );
}
// }

// class AudioControlButtons extends StatelessWidget {
//   const AudioControlButtons({Key key}) : super(key: key);
//   @override
Widget audioControlButtons(BuildContext context) {
  // ignore: sized_box_for_whitespace
  return Container(
    height: 60,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        repeatButton(context),
        previousSongButton(context),
        playButton(context),
        nextSongButton(context),
        shuffleButton(context),
      ],
    ),
  );
}
// }

// class RepeatButton extends StatelessWidget {
//   const RepeatButton({Key key}) : super(key: key);
@override
Widget repeatButton(BuildContext context) {
  return ValueListenableBuilder<RepeatState>(
    valueListenable: _pageManager.repeatButtonNotifier,
    builder: (context, value, child) {
      Icon icon;
      switch (value) {
        case RepeatState.off:
          icon = Icon(Icons.repeat, color: Colors.grey);
          break;
        case RepeatState.repeatSong:
          icon = Icon(Icons.repeat_one);
          break;
        case RepeatState.repeatPlaylist:
          icon = Icon(Icons.repeat);
          break;
      }
      return IconButton(
        icon: icon,
        onPressed: _pageManager.onRepeatButtonPressed,
      );
    },
  );
}
// }

// class PreviousSongButton extends StatelessWidget {
//   const PreviousSongButton({Key key}) : super(key: key);
//   @override
Widget previousSongButton(BuildContext context) {
  return ValueListenableBuilder<bool>(
    valueListenable: _pageManager.isFirstSongNotifier,
    builder: (_, isFirst, __) {
      return IconButton(
        icon: Icon(Icons.skip_previous),
        onPressed: (isFirst) ? null : _pageManager.onPreviousSongButtonPressed,
      );
    },
  );
}
// }

// class PlayButton extends StatelessWidget {
//   const PlayButton({Key key}) : super(key: key);
//   @override
Widget playButton(BuildContext context) {
  return ValueListenableBuilder<ButtonState>(
    valueListenable: _pageManager.playButtonNotifier,
    // ignore: missing_return
    builder: (_, value, __) {
      switch (value) {
        case ButtonState.loading:
          return Container(
            margin: EdgeInsets.all(8.0),
            width: 32.0,
            height: 32.0,
            child: CircularProgressIndicator(),
          );
        case ButtonState.paused:
          return IconButton(
            icon: Icon(Icons.play_arrow),
            iconSize: 32.0,
            onPressed: _pageManager.play,
          );
        case ButtonState.playing:
          return IconButton(
            icon: Icon(Icons.pause),
            iconSize: 32.0,
            onPressed: _pageManager.pause,
          );
      }
    },
  );
}

Widget nextSongButton(BuildContext context) {
  return ValueListenableBuilder<bool>(
    valueListenable: _pageManager.isLastSongNotifier,
    builder: (_, isLast, __) {
      return IconButton(
        icon: Icon(Icons.skip_next),
        onPressed: (isLast) ? null : _pageManager.onNextSongButtonPressed,
      );
    },
  );
}

Widget shuffleButton(BuildContext context) {
  return ValueListenableBuilder<bool>(
    valueListenable: _pageManager.isShuffleModeEnabledNotifier,
    builder: (context, isEnabled, child) {
      return IconButton(
        icon: (isEnabled)
            ? Icon(Icons.shuffle)
            : Icon(Icons.shuffle, color: Colors.grey),
        onPressed: _pageManager.onShuffleButtonPressed,
      );
    },
  );
}
