import 'package:flutter/material.dart';
import 'payment_subscription_screen.dart';

class PremiumLockScreen extends StatelessWidget {
  final String lockReason;
  final String examType;

  const PremiumLockScreen({
    super.key,
    required this.lockReason,
    required this.examType,
  });

  String get lockTitle {
    switch (lockReason) {
      case 'subtopic_limit':
        return 'Subtopic Locked';
      case 'test_limit':
        return 'Test Locked';
      default:
        return 'Premium Content';
    }
  }

  String get lockMessage {
    switch (lockReason) {
      case 'subtopic_limit':
        return 'You\'ve used your 2 free subtopics. Upgrade to Premium to unlock unlimited practice questions!';
      case 'test_limit':
        return 'You\'ve used your 2 free tests. Upgrade to Premium to unlock unlimited mock tests!';
      default:
        return 'This content is available for Premium members only. Upgrade now to unlock!';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(lockTitle),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF5B4EE8), Color(0xFF7C6EFF)],
                ),
              ),
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  // Lock Icon with glow
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: const Center(
                      child: Text('👑', style: TextStyle(fontSize: 50)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Upgrade to Premium',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    lockMessage,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Benefits Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1A1A2E) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF5B4EE8).withOpacity(0.3),
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
                    Text(
                      '✨ Premium Benefits',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildBenefit(context, '∞', 'Unlimited Practice Questions',
                        'Access all questions across all subjects', Colors.blue),
                    const SizedBox(height: 12),
                    _buildBenefit(context, '📝', 'Unlimited Mock Tests',
                        'Take as many tests as you want', Colors.green),
                    const SizedBox(height: 12),
                    _buildBenefit(context, '📊', 'Detailed Analytics',
                        'Track your progress in detail', Colors.orange),
                    const SizedBox(height: 12),
                    _buildBenefit(context, '🎥', 'Video Solutions',
                        'Learn from detailed video explanations', Colors.purple),
                    const SizedBox(height: 12),
                    _buildBenefit(context, '🏆', 'Leaderboard Access',
                        'Compete with students across India', Colors.amber),
                    const SizedBox(height: 12),
                    _buildBenefit(context, '🚫', 'Ad-Free Experience',
                        'Study without any distractions', Colors.red),
                  ],
                ),
              ),
            ),

            // Pricing Plans
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Simple Pricing',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Monthly
                  _buildPricingCard(
                    context,
                    name: 'Monthly',
                    price: '₹99',
                    period: 'per month',
                    savings: null,
                    color: Colors.blue,
                    isDark: isDark,
                    isBestValue: false,
                  ),
                  const SizedBox(height: 12),

                  // Quarterly
                  _buildPricingCard(
                    context,
                    name: 'Quarterly',
                    price: '₹249',
                    period: 'per 3 months',
                    savings: 'Save 16%',
                    color: Colors.purple,
                    isDark: isDark,
                    isBestValue: true,
                  ),
                  const SizedBox(height: 12),

                  // Yearly
                  _buildPricingCard(
                    context,
                    name: 'Yearly',
                    price: '₹799',
                    period: 'per year',
                    savings: 'Save 33%',
                    color: Colors.green,
                    isDark: isDark,
                    isBestValue: false,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Guarantee
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.green.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.verified_user,
                      color: Colors.green,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '7-Day Money Back Guarantee',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            'Not satisfied? Get a full refund within 7 days.',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Upgrade Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const PaymentSubscriptionScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5B4EE8),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Upgrade to Premium 👑',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Continue Free
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(
                      color: Color(0xFF5B4EE8),
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Continue as Free User',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5B4EE8),
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

  Widget _buildBenefit(
    BuildContext context,
    String icon,
    String title,
    String subtitle,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              icon,
              style: TextStyle(
                fontSize: icon == '∞' ? 20 : 18,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
        Icon(Icons.check_circle, color: color, size: 20),
      ],
    );
  }

  Widget _buildPricingCard(
    BuildContext context, {
    required String name,
    required String price,
    required String period,
    required String? savings,
    required Color color,
    required bool isDark,
    required bool isBestValue,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: color.withOpacity(0.4),
              width: isBestValue ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    period,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  if (savings != null) ...[
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        savings,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              Text(
                price,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
        if (isBestValue)
          Positioned(
            top: -10,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                '⭐ Best Value',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
