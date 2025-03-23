// import 'package:flutter/material.dart';
// import 'package:sunofa_map/common/api/api.dart';
// import 'package:sunofa_map/common/widgets/arrow_back.dart';
// import 'package:sunofa_map/core/utils/constant.dart';

// class ViewImage extends StatefulWidget {
//   const ViewImage({
//     super.key,
//     required this.image,
//   });
//   final String image;

//   @override
//   State<ViewImage> createState() => _ViewImageState();
// }

// class _ViewImageState extends State<ViewImage> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             color: mblack,
//             width: size.width,
//             height: size.height,
//             child: Center(
//               child: SizedBox(
//                 // width: size.width,
//                 // height: size.height / 2,
//                 child: Hero(
//                   tag: widget.image,
//                   child: Image.network(
//                     widget.image,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const Positioned(
//             top: 50,
//             left: 20,
//             child: BackArrow(color: mwhite),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:sunofa_map/common/widgets/arrow_back.dart';
import 'package:sunofa_map/core/utils/constant.dart';

class ViewImage extends StatefulWidget {
  const ViewImage({
    super.key,
    required this.image,
  });
  final String image;

  @override
  State<ViewImage> createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // Background Container
          Container(
            color: mblack,
            width: size.width,
            height: size.height,
            child: Center(
              child: InteractiveViewer(
                panEnabled: true, // Enable panning
                boundaryMargin: const EdgeInsets.all(double.infinity), // Allow panning beyond image bounds
                minScale: 1.0, // Minimum zoom scale
                maxScale: 4.0, // Maximum zoom scale
                child: Hero(
                  tag: widget.image,
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          // Back Arrow
          const Positioned(
            top: 50,
            left: 20,
            child: BackArrow(color: mwhite),
          ),
        ],
      ),
    );
  }
}