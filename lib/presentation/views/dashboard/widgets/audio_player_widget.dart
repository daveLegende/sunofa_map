import 'package:flutter/material.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String label;
  const AudioPlayerWidget({super.key, required this.label});

  @override
  // ignore: library_private_types_in_public_api
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  double _sliderValue = 0.0; // Pour gérer la valeur du slider

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTheme().stylish1(15, AppTheme.black),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.mic, color: Colors.black54),
              SizedBox(width: MediaQuery.of(context).size.width * 0.01),
              IconButton(
                icon: const Icon(Icons.play_arrow, color: Colors.black54),
                onPressed: () {
                  // Action de lecture
                },
              ),
              const Text("0:00 / 0:00", style: TextStyle(color: Colors.black54)),
              Expanded(
                child: Slider(
                  activeColor: AppTheme.primaryColor,
                  inactiveColor: Colors.grey,
                  value: _sliderValue,
                  onChanged: (value) {
                    setState(() {
                      _sliderValue = value;
                    });
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.volume_up, color: Colors.black54),
                onPressed: () {
                  // Action pour ajuster le volume
                },
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.black54),
                onPressed: () {
                  // Action du menu
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  print('${widget.label} supprimé');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
