import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  String _selectedLanguage = 'English';
  double _textScale = 1.0;
  bool _autoPlayVideos = true;
  bool _downloadOverWifi = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          _buildAppearanceSection(),
          const Divider(),
          _buildNotificationsSection(),
          const Divider(),
          _buildLanguageSection(),
          const Divider(),
          _buildAccessibilitySection(),
          const Divider(),
          _buildDataSection(),
          const Divider(),
          _buildAboutSection(),
        ],
      ),
    );
  }

  Widget _buildAppearanceSection() {
    return _buildSection(
      title: 'Appearance',
      icon: Icons.palette_outlined,
      children: [
        SwitchListTile(
          title: const Text('Dark Mode'),
          subtitle: const Text('Use dark theme'),
          value: _isDarkMode,
          onChanged: (value) {
            setState(() {
              _isDarkMode = value;
            });
            // TODO: Update theme
          },
        ),
        ListTile(
          title: const Text('Theme Color'),
          trailing: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
          onTap: () {
            // TODO: Show color picker
          },
        ),
      ],
    );
  }

  Widget _buildNotificationsSection() {
    return _buildSection(
      title: 'Notifications',
      icon: Icons.notifications_outlined,
      children: [
        SwitchListTile(
          title: const Text('Email Notifications'),
          subtitle: const Text('Receive course updates via email'),
          value: _emailNotifications,
          onChanged: (value) {
            setState(() {
              _emailNotifications = value;
            });
            // TODO: Update notification settings
          },
        ),
        SwitchListTile(
          title: const Text('Push Notifications'),
          subtitle: const Text('Receive instant notifications'),
          value: _pushNotifications,
          onChanged: (value) {
            setState(() {
              _pushNotifications = value;
            });
            // TODO: Update notification settings
          },
        ),
      ],
    );
  }

  Widget _buildLanguageSection() {
    return _buildSection(
      title: 'Language',
      icon: Icons.language_outlined,
      children: [
        ListTile(
          title: const Text('App Language'),
          subtitle: Text(_selectedLanguage),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            _showLanguagePicker();
          },
        ),
      ],
    );
  }

  Widget _buildAccessibilitySection() {
    return _buildSection(
      title: 'Accessibility',
      icon: Icons.accessibility_new_outlined,
      children: [
        ListTile(
          title: const Text('Text Size'),
          subtitle: Text('${(_textScale * 100).round()}%'),
          trailing: SizedBox(
            width: 200,
            child: Slider(
              value: _textScale,
              min: 0.8,
              max: 1.4,
              divisions: 6,
              label: '${(_textScale * 100).round()}%',
              onChanged: (value) {
                setState(() {
                  _textScale = value;
                });
                // TODO: Update text scale
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDataSection() {
    return _buildSection(
      title: 'Data & Storage',
      icon: Icons.storage_outlined,
      children: [
        SwitchListTile(
          title: const Text('Auto-play Videos'),
          subtitle: const Text('Play videos automatically'),
          value: _autoPlayVideos,
          onChanged: (value) {
            setState(() {
              _autoPlayVideos = value;
            });
            // TODO: Update video settings
          },
        ),
        SwitchListTile(
          title: const Text('Download over Wi-Fi only'),
          subtitle: const Text('Save mobile data'),
          value: _downloadOverWifi,
          onChanged: (value) {
            setState(() {
              _downloadOverWifi = value;
            });
            // TODO: Update download settings
          },
        ),
        ListTile(
          title: const Text('Clear Cache'),
          subtitle: const Text('Free up space'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            _showClearCacheDialog();
          },
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return _buildSection(
      title: 'About',
      icon: Icons.info_outline,
      children: [
        const ListTile(
          title: Text('Version'),
          subtitle: Text('1.0.0'),
        ),
        ListTile(
          title: const Text('Terms of Service'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            // TODO: Show terms of service
          },
        ),
        ListTile(
          title: const Text('Privacy Policy'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            // TODO: Show privacy policy
          },
        ),
        ListTile(
          title: const Text('Open Source Licenses'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            // TODO: Show licenses
          },
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ],
          ),
        ),
        ...children,
      ],
    );
  }

  void _showLanguagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          children: [
            ListTile(
              title: const Text('English'),
              trailing: _selectedLanguage == 'English'
                  ? const Icon(Icons.check)
                  : null,
              onTap: () {
                setState(() {
                  _selectedLanguage = 'English';
                });
                Navigator.pop(context);
                // TODO: Update language
              },
            ),
            ListTile(
              title: const Text('Spanish'),
              trailing: _selectedLanguage == 'Spanish'
                  ? const Icon(Icons.check)
                  : null,
              onTap: () {
                setState(() {
                  _selectedLanguage = 'Spanish';
                });
                Navigator.pop(context);
                // TODO: Update language
              },
            ),
            ListTile(
              title: const Text('French'),
              trailing: _selectedLanguage == 'French'
                  ? const Icon(Icons.check)
                  : null,
              onTap: () {
                setState(() {
                  _selectedLanguage = 'French';
                });
                Navigator.pop(context);
                // TODO: Update language
              },
            ),
          ],
        );
      },
    );
  }

  void _showClearCacheDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Clear Cache'),
          content: const Text(
            'This will free up space by removing cached data. Your downloaded content will not be affected.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                // TODO: Clear cache
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cache cleared')),
                );
              },
              child: const Text('Clear'),
            ),
          ],
        );
      },
    );
  }
}
