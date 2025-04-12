import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/core/utils/screen_size.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Info',
          style: AppTheme().stylish1(20, AppTheme.white, isBold: true),
        ),
        backgroundColor: AppTheme.primaryColor,
        leading: IconButton(
          icon: const HeroIcon(
            HeroIcons.arrowLeftCircle,
            color: AppTheme.white,
            size: 40,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: context.width / 2,
                height: context.width / 2,
                child: Center(
                  child: Image.asset(
                    'assets/logo.png',
                    width: 300,
                    height: 300,
                  ),
                ),
              ),
              Text(
                'About Sunofa Map',
                textAlign: TextAlign.center,
                style: AppTheme()
                    .stylish1(20, AppTheme.primaryColor, isBold: true),
              ),
              Text(
                'Sunofa Map is much more than a simple location app: it’s a revolution in how we interact with our environment and stay connected to our loved ones. Designed to meet the modern needs of mobility and safety, Sunofa Map is an essential tool for anyone who wants to navigate the world with confidence and peace of mind.',
                style: AppTheme().stylish1(15, AppTheme.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: context.heightPercent(2),
              ),
              Text(
                'Facilitate Personal and Group Location',
                textAlign: TextAlign.center,
                style: AppTheme()
                    .stylish1(20, AppTheme.primaryColor, isBold: true),
              ),
              Text(
                "In an era where distance should never be an obstacle, Sunofa Map allows you to know where you are, where your loved ones are, and how to reach them, all in just a few clicks. Whether you're traveling in an unfamiliar city, trying to find a friend at a crowded event, or simply need to monitor your family’s movements safely, Sunofa Map is your trusted companion.",
                style: AppTheme().stylish1(15, AppTheme.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: context.heightPercent(2),
              ),
              Text(
                'Register and Manage Important Addresses',
                textAlign: TextAlign.center,
                style: AppTheme()
                    .stylish1(20, AppTheme.primaryColor, isBold: true),
              ),
              Text(
                "Sunofa Map goes beyond just real-time location tracking. The app also lets you save and manage addresses of important places, accompanied by images, videos, and even audio files for more precise and intuitive location tracking. Whether it’s the café where you had your first date, the beach house, or a loved one’s workplace, these addresses are always within reach. With Sunofa Map, never lose a precious address, and access your personal address book with ease.",
                style: AppTheme().stylish1(15, AppTheme.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: context.heightPercent(2),
              ),
              Text(
                'Data Protection and Privacy',
                textAlign: TextAlign.center,
                style: AppTheme()
                    .stylish1(20, AppTheme.primaryColor, isBold: true),
              ),
              Text(
                "We understand that security and privacy are major concerns when it comes to sharing location information. That’s why Sunofa Map is designed with advanced security protocols to ensure your data is protected at all times. You have full control over who can see your information and under what conditions. Every Sunofa Map user enjoys a secure location experience, where privacy is at the heart of all our features. You can protect your personal addresses with a unique PIN code. If a loved one requests one of your protected addresses, you will receive a notification informing you of this request. You can then decide whether to share the address by sending your PIN to the person, unlocking access.",
                style: AppTheme().stylish1(15, AppTheme.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: context.heightPercent(2),
              ),
              Text(
                'An Innovation Serving the Community',
                textAlign: TextAlign.center,
                style: AppTheme()
                    .stylish1(20, AppTheme.primaryColor, isBold: true),
              ),
              Text(
                "Sunofa Map was born out of the desire to make technology accessible and useful to everyone. We firmly believe that location tracking should not be a privilege but a right for every individual. Sunofa Map aims to democratize access to location tools by making them easy to use while integrating the most advanced security and sharing features. By using Sunofa Map, you join a global community that values connection, safety, and simplicity.",
                style: AppTheme().stylish1(15, AppTheme.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: context.heightPercent(2),
              ),
              Text(
                'An Intuitive and Engaging User Experience',
                textAlign: TextAlign.center,
                style: AppTheme()
                    .stylish1(20, AppTheme.primaryColor, isBold: true),
              ),
              Text(
                "Sunofa Map is designed with the user in mind. The app’s interface is intuitive, smooth, and enjoyable to use, even for those unfamiliar with modern technologies. We have made it a priority to provide a user experience that combines functionality with aesthetics, making every interaction with Sunofa Map as pleasant as it is efficient.\n\n Sunofa Map is not just an app; it’s a service that transforms how we interact with space and the people around us. By choosing Sunofa Map, you choose technology that respects your privacy, simplifies your daily life, and brings you closer to the people and places that matter most to you.\n\n Join us on this adventure and discover how Sunofa Map can redefine your location and sharing experience with complete security.",
                style: AppTheme().stylish1(15, AppTheme.black),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
