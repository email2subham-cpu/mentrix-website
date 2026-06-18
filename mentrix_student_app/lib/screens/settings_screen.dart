import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/language_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [const Color(0xFF1A1A2E), const Color(0xFF0D0D1F)]
                      : [const Color(0xFF5B4EE8).withOpacity(0.1), const Color(0xFF00D9FF).withOpacity(0.1)],
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF5B4EE8).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text('⚙️', style: TextStyle(fontSize: 24)),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Settings',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Customize your experience',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Appearance Section
            _buildSectionHeader(context, 'Appearance'),
            const SizedBox(height: 12),

            // Dark Mode Toggle
            _buildToggleCard(
              context,
              icon: '🌙',
              title: 'Dark Mode',
              subtitle: 'Switch between light and dark theme',
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.setDarkMode(value);
              },
              color: Colors.indigo,
            ),

            const SizedBox(height: 20),

            // Language Section
            _buildSectionHeader(context, 'Language'),
            const SizedBox(height: 12),

            // Language Toggle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1A1A2E)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.blue.withOpacity(0.3),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text('🌐', style: TextStyle(fontSize: 20)),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Question Language',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Switch questions between languages',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              languageProvider.setLanguage('English');
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: languageProvider.isEnglish
                                    ? const Color(0xFF5B4EE8)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: languageProvider.isEnglish
                                      ? const Color(0xFF5B4EE8)
                                      : Colors.grey.withOpacity(0.3),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '🇬🇧 English',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: languageProvider.isEnglish
                                        ? Colors.white
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              languageProvider.setLanguage('Bengali');
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: languageProvider.isBengali
                                    ? const Color(0xFF5B4EE8)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: languageProvider.isBengali
                                      ? const Color(0xFF5B4EE8)
                                      : Colors.grey.withOpacity(0.3),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '🇧🇩 বাংলা',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: languageProvider.isBengali
                                        ? Colors.white
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Notifications Section
            _buildSectionHeader(context, 'Notifications'),
            const SizedBox(height: 12),

            _buildToggleCard(
              context,
              icon: '🔔',
              title: 'Push Notifications',
              subtitle: 'Get test reminders and updates',
              value: notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  notificationsEnabled = value;
                });
              },
              color: Colors.orange,
            ),

            const SizedBox(height: 20),

            // Account Section
            _buildSectionHeader(context, 'Account'),
            const SizedBox(height: 12),

            _buildMenuCard(
              context,
              icon: '💳',
              title: 'Update Subscription',
              subtitle: 'Manage your premium membership',
              color: Colors.purple,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Update Subscription'),
                    content: const Text('Subscription management coming soon!'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            // Support Section
            _buildSectionHeader(context, 'Support'),
            const SizedBox(height: 12),

            _buildMenuCard(
              context,
              icon: '❓',
              title: 'Help & FAQs',
              subtitle: 'Get answers to common questions',
              color: Colors.blue,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Help & FAQs'),
                    content: const SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FAQItem(
                            question: 'How do I reset my password?',
                            answer: 'Go to login page and click "Forgot Password"',
                          ),
                          FAQItem(
                            question: 'How do I get credits?',
                            answer: 'Solve questions, take tests, or refer friends',
                          ),
                          FAQItem(
                            question: 'Can I download content?',
                            answer: 'Offline download coming soon for premium users',
                          ),
                          FAQItem(
                            question: 'How do I contact support?',
                            answer: 'Email: support@mentrix.com',
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            _buildMenuCard(
              context,
              icon: '🔒',
              title: 'Privacy Policy',
              subtitle: 'Read our privacy practices',
              color: Colors.green,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Privacy Policy'),
                    content: SingleChildScrollView(
                      child: Text(
                        'Privacy Policy for Mentrix\n\n'
                        '1. Data Collection\n'
                        'We collect personal information like email, name, and progress data.\n\n'
                        '2. Data Usage\n'
                        'Your data is used to personalize your learning experience.\n\n'
                        '3. Data Protection\n'
                        'We use industry-standard encryption to protect your data.\n\n'
                        '4. Third-party Sharing\n'
                        'We do not sell your personal data to third parties.\n\n'
                        '5. User Rights\n'
                        'You can request to view, modify, or delete your data anytime.\n\n'
                        'For full details, visit: www.mentrix.com/privacy',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            _buildMenuCard(
              context,
              icon: '📜',
              title: 'Terms & Conditions',
              subtitle: 'Review our terms of service',
              color: Colors.teal,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Terms & Conditions'),
                    content: SingleChildScrollView(
                      child: Text(
                        'Terms & Conditions for Mentrix\n\n'
                        '1. Service Usage\n'
                        'You agree to use Mentrix for educational purposes only.\n\n'
                        '2. User Conduct\n'
                        'You agree not to share answers or misuse the platform.\n\n'
                        '3. Intellectual Property\n'
                        'All content on Mentrix is owned by Mentrix or its partners.\n\n'
                        '4. Account Termination\n'
                        'We reserve the right to terminate accounts that violate terms.\n\n'
                        'For full terms, visit: www.mentrix.com/terms',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            _buildMenuCard(
              context,
              icon: 'ℹ️',
              title: 'About Mentrix',
              subtitle: 'Version 1.0.0',
              color: Colors.indigo,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('About Mentrix'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('📱', style: TextStyle(fontSize: 48)),
                        const SizedBox(height: 12),
                        const Text(
                          'Mentrix',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text('Version 1.0.0'),
                        const SizedBox(height: 12),
                        Text(
                          'Master Your Exams - Practice MCQs, Take Tests & Track Progress',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '© 2024 Mentrix. All rights reserved.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Logged out successfully!'),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text('Logout'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.red),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: Colors.red, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: const Color(0xFF5B4EE8),
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildToggleCard(
    BuildContext context, {
    required String icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required Color color,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1A1A2E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(icon, style: const TextStyle(fontSize: 20)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              activeColor: const Color(0xFF5B4EE8),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required String icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1A1A2E) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(icon, style: const TextStyle(fontSize: 20)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: color.withOpacity(0.7),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const FAQItem({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Q: $question',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'A: $answer',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
