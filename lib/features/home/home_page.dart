import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pssn/features/audio_player/screens/audio_player_page.dart';
import 'package:pssn/features/digital_id/screens/digital_id_page.dart';
import 'package:pssn/features/journey/screens/journey_page.dart';
import 'package:pssn/features/location/screens/location_page.dart';
import 'package:pssn/features/notification/ui/screens/notification_list_screen.dart';
import 'package:pssn/features/sign_in/screens/sign_in_page.dart';
import 'package:pssn/features/sign_up/screens/sign_up_page.dart';
import 'package:pssn/features/verification/screens/verification_page.dart';
import 'package:pssn/features/video_player/screens/video_player_page.dart';
import 'package:pssn/features/visit_requests/screens/visit_requests_page.dart';

class HomePage extends StatelessWidget {
  const HomePage();

  static const path = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notification_important),
            onPressed: () {
              GoRouter.of(context).go('$path/${NotificationsListScreen.path}');
            },
          )
        ],
      ),
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  GoRouter.of(context)
                      .go('${HomePage.path}/${DigitalIdPage.path}');
                },
                child: const Text('To Digital ID'),
              ),
              ElevatedButton(
                onPressed: () => GoRouter.of(context)
                    .go('${HomePage.path}/${VisitRequestsPage.path}'),
                child: const Text('Visit Requests'),
              ),
              ElevatedButton(
                onPressed: () {
                  GoRouter.of(context)
                      .go('${HomePage.path}/${JourneyPage.path}');
                },
                child: const Text('Journey Management'),
              ),
              ElevatedButton(
                onPressed: () {
                  GoRouter.of(context)
                      .go('${HomePage.path}/${VideoPlayerPage.path}');
                },
                child: const Text('Video player'),
              ),
              ElevatedButton(
                onPressed: () {
                  GoRouter.of(context)
                      .go('${HomePage.path}/${AudioPlayerPage.path}');
                },
                child: const Text('Audio player'),
              ),
              ElevatedButton(
                onPressed: () {
                  GoRouter.of(context)
                      .go('${HomePage.path}/${LocationPage.path}');
                },
                child: const Text('Location'),
              ),
              ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).go(
                    Uri(
                      path:
                          '${SignInPage.path}/${SignUpPage.path}/${VerificationPage.path}',
                      queryParameters: <String, dynamic>{
                        'navigation': path
                      },
                    ).toString(),
                  );
                },
                child: const Text("Verification"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
