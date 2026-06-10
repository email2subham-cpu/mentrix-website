import 'package:flutter/material.dart';

class PremiumLockScreen extends StatefulWidget {
  final String lockReason; // 'subtopic_limit', 'test_limit', 'test_series', etc.
  final String examType;

  const PremiumLockScreen({
    Key? key,
    required this.lockReason,
    required this.examType,
  }) : super(key: key);

  @override
  State<PremiumLockScreen> createState() => _PremiumLockScreenState();
}

class _PremiumLockScreenState extends State<PremiumLockScreen> {
  String selectedPlan = 'monthly'; // 'monthly', 'quarterly', 'yearly'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with close button
            Container(
              color: const Color(0xFF5B4EE8),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Upgrade to Premium',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),

            // Lock reason message
            Container(
              color: Colors.amber[50],
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.lock, color: Colors.amber, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _getLockMessage(),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.amber[900],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Crown icon
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text(
                '👑',
                style: const TextStyle(fontSize: 64),
              ),
            ),

            // Main message
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Text(
                    'Go Premium Today!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Unlock unlimited access to all questions, tests, and features',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Features comparison
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Header row
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(11),
                          topRight: Radius.circular(11),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Text(
                              'Features',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                'Free',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                'Premium',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Feature rows
                    ..._buildFeatureRows(),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Pricing plans
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Choose Your Plan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Monthly plan
                  PricingPlanCard(
                    name: 'Monthly',
                    price: '₹99',
                    period: 'per month',
                    savings: null,
                    isSelected: selectedPlan == 'monthly',
                    onTap: () {
                      setState(() {
                        selectedPlan = 'monthly';
                      });
                    },
                  ),
                  const SizedBox(height: 12),

                  // Quarterly plan (best value)
                  PricingPlanCard(
                    name: 'Quarterly',
                    price: '₹249',
                    period: 'per 3 months',
                    savings: 'Save 15%',
                    isSelected: selectedPlan == 'quarterly',
                    isBestValue: true,
                    onTap: () {
                      setState(() {
                        selectedPlan = 'quarterly';
                      });
                    },
                  ),
                  const SizedBox(height: 12),

                  // Yearly plan (best value)
                  PricingPlanCard(
                    name: 'Yearly',
                    price: '₹799',
                    period: 'per year',
                    savings: 'Save 33%',
                    isSelected: selectedPlan == 'yearly',
                    isBestValue: false,
                    onTap: () {
                      setState(() {
                        selectedPlan = 'yearly';
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Benefits
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Premium Benefits:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[900],
                      ),
                    ),
                    const SizedBox(height: 12),
                    ..._buildBenefits(),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Upgrade button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    showUpgradeConfirmationDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5B4EE8),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Upgrade Now',
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

            // Continue free button
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
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Continue Free Version',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5B4EE8),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Trust badge
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.verified_user, size: 16, color: Colors.green),
                  const SizedBox(width: 4),
                  Text(
                    'Secure Payment | 7-Day Money Back Guarantee',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFeatureRows() {
    final features = [
      {'name': 'Practice Questions', 'free': '2/subject', 'premium': 'Unlimited'},
      {'name': 'Mock Tests', 'free': '2/exam', 'premium': 'Unlimited'},
      {'name': 'Test Series', 'free': 'Basic', 'premium': 'All'},
      {'name': 'Performance Analytics', 'free': 'Limited', 'premium': 'Detailed'},
      {'name': 'Previous Year Papers', 'free': 'No', 'premium': 'Yes'},
      {'name': 'Video Solutions', 'free': 'No', 'premium': 'Yes'},
      {'name': 'Doubt Support', 'free': 'No', 'premium': 'Yes'},
      {'name': 'Ad-Free Experience', 'free': 'No', 'premium': 'Yes'},
    ];

    return features.map((feature) {
      return Column(
        children: [
          Divider(height: 1, color: Colors.grey[300]),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Text(
                    feature['name']!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      feature['free']!,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }).toList();
  }

  List<Widget> _buildBenefits() {
    final benefits = [
      'Unlimited access to all practice questions',
      'Unlimited mock tests across all exams',
      'Detailed performance analytics & insights',
      'Previous year question papers',
      'Video solutions for all questions',
      'Priority doubt support',
      'Ad-free experience',
      'Offline download (coming soon)',
    ];

    return benefits
        .map((benefit) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      benefit,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            ))
        .toList();
  }

  String _getLockMessage() {
    switch (widget.lockReason) {
      case 'subtopic_limit':
        return 'You have used your free subtopic limit. Upgrade to access more!';
      case 'test_limit':
        return 'You have used your free test limit. Upgrade for unlimited tests!';
      case 'test_series':
        return 'This test series is only available for Premium users.';
      case 'previous_year':
        return 'Previous year papers are only for Premium members.';
      default:
        return 'This feature is only available for Premium users.';
    }
  }

  void showUpgradeConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Upgrade Confirmation'),
        content: Text(
          'You are about to upgrade to Premium on the $_selectedPlanName plan.\n\nYou will have unlimited access to all features!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Process payment
              Navigator.pop(context);
              showPaymentProcessing();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5B4EE8),
            ),
            child: const Text('Proceed to Payment'),
          ),
        ],
      ),
    );
  }

  String get _selectedPlanName {
    switch (selectedPlan) {
      case 'monthly':
        return 'Monthly (₹99)';
      case 'quarterly':
        return 'Quarterly (₹249)';
      case 'yearly':
        return 'Yearly (₹799)';
      default:
        return 'Monthly';
    }
  }

  void showPaymentProcessing() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Processing Payment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              'Upgrading to $_selectedPlanName...',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );

    // Simulate payment processing
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Close processing dialog
      showPaymentSuccess();
    });
  }

  void showPaymentSuccess() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Success!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '✅',
              style: TextStyle(fontSize: 48),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'You are now Premium!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Enjoy unlimited access to all features.',
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close success dialog
              Navigator.pop(context); // Close premium screen
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text('Great!'),
          ),
        ],
      ),
    );
  }
}

class PricingPlanCard extends StatelessWidget {
  final String name;
  final String price;
  final String period;
  final String? savings;
  final bool isSelected;
  final bool isBestValue;
  final VoidCallback onTap;

  const PricingPlanCard({
    Key? key,
    required this.name,
    required this.price,
    required this.period,
    this.savings,
    required this.isSelected,
    this.isBestValue = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF5B4EE8).withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF5B4EE8) : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF5B4EE8)
                              : Colors.grey[400]!,
                          width: 2,
                        ),
                        color: isSelected
                            ? const Color(0xFF5B4EE8)
                            : Colors.transparent,
                      ),
                      child: isSelected
                          ? const Center(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 12,
                              ),
                            )
                          : null,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5B4EE8),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      period,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                if (savings != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      savings!,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                  ),
                ],
              ],
            ),
            if (isBestValue)
              Positioned(
                top: -10,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Best Value',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
