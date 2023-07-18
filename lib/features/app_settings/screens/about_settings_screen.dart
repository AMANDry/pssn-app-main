import 'package:flutter/material.dart';

class AboutSettingsPage extends StatefulWidget {
  const AboutSettingsPage();

  static const path = 'settings-about';

  @override
  State<StatefulWidget> createState() => _AboutSettingsPageState();
}

class _AboutSettingsPageState extends State<AboutSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('About'),
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Terms & conditions'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.privacy_tip_outlined),
            title: Text('Privacy Policy'),
          ),
          Divider(),
        ],
      ),
    );
  }
}
