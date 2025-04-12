import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Image en plein écran avec zoom
          Positioned.fill(
            child: InteractiveViewer(
              panEnabled: true,
              boundaryMargin: EdgeInsets.zero,
              minScale: 1.0,
              maxScale: 4.0,
              child: Center(
                child: Hero(
                  tag: widget.image,
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.contain, // Modifié de 'contain' à 'cover'
                    width: double.infinity,
                    height: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ),
          // Bouton retour
          Positioned(
            top: MediaQuery.of(context).padding.top + 20,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
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
//           // Background Container
//           Container(
//             color: mblack,
//             width: size.width,
//             height: size.height,
//             child: Center(
//               child: InteractiveViewer(
//                 panEnabled: true, // Enable panning
//                 boundaryMargin: const EdgeInsets.all(double.infinity), // Allow panning beyond image bounds
//                 minScale: 1.0, // Minimum zoom scale
//                 maxScale: 4.0, // Maximum zoom scale
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
//           // Back Arrow
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