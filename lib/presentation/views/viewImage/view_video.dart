// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:sunofa_map/common/widgets/arrow_back.dart';
// import 'package:sunofa_map/core/utils/constant.dart';
// import 'package:sunofa_map/common/api/api.dart';

// class ViewVideo extends StatefulWidget {
//   const ViewVideo({super.key, required this.video});

//   final String video;

//   @override
//   State<ViewVideo> createState() => _ViewVideoState();
// }

// class _ViewVideoState extends State<ViewVideo> {
//   late VideoPlayerController _controller;
//   bool _isPlaying = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network("${APIURL.fileUrl}/${widget.video}")
//       ..initialize().then((_) {
//         setState(() {});
//         _controller.play();
//         _isPlaying = true;
//       });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _togglePlayPause() {
//     setState(() {
//       if (_controller.value.isPlaying) {
//         _controller.pause();
//         _isPlaying = false;
//       } else {
//         _controller.play();
//         _isPlaying = true;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: mblack,
//       body: Stack(
//         children: [
//           Container(
//             height: size.height,
//             width: double.infinity,
//             child: _controller.value.isInitialized
//                 ? AspectRatio(
//                     aspectRatio: _controller.value.aspectRatio,
//                     child: GestureDetector(
//                       onTap: _togglePlayPause,
//                       child: VideoPlayer(_controller),
//                     ),
//                   )
//                 : const Center(child: CircularProgressIndicator()),
//           ),
//           const Positioned(
//             top: 50,
//             left: 20,
//             child: BackArrow(color: mwhite),
//           ),
//           Positioned(
//             bottom: 50,
//             left: size.width / 2 - 30,
//             child: GestureDetector(
//               onTap: _togglePlayPause,
//               child: Icon(
//                 _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
//                 color: Colors.white,
//                 size: 60,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:sunofa_map/common/widgets/loading_circle.dart';
import 'package:video_player/video_player.dart';
import 'package:sunofa_map/common/widgets/arrow_back.dart';
import 'package:sunofa_map/core/utils/constant.dart';
import 'package:sunofa_map/common/api/api.dart';

class ViewVideo extends StatefulWidget {
  const ViewVideo({super.key, required this.video});

  final String video;

  @override
  State<ViewVideo> createState() => _ViewVideoState();
}

class _ViewVideoState extends State<ViewVideo> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
        Uri.parse("${APIURL.fileUrl}/${widget.video}"))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _isPlaying = true;
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: mblack,
      body: Stack(
        children: [
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: GestureDetector(
                      onTap: _togglePlayPause,
                      child: VideoPlayer(_controller),
                    ),
                  )
                : const LoadingCircle(),
          ),
          const Positioned(
            top: 80,
            left: 20,
            child: BackArrow(color: mwhite),
          ),
          Positioned(
            bottom: 80,
            left: size.width / 2 - 30,
            child: GestureDetector(
              onTap: _togglePlayPause,
              child: Icon(
                _isPlaying
                    ? Icons.pause_circle_filled
                    : Icons.play_circle_filled,
                color: Colors.white,
                size: 60,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
