import 'package:flutter/material.dart';

class PaymentSubscriptionScreen extends StatefulWidget {
  const PaymentSubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<PaymentSubscriptionScreen> createState() =>
      _PaymentSubscriptionScreenState();
}

class _PaymentSubscriptionScreenState extends State<PaymentSubscriptionScreen> {
  String selectedPlan = 'monthly'; // monthly, quarterly, yearly
  String selectedPaymentMethod = 'upi'; // upi, card, wallet

  // Mock subscription data
  late Map<String, dynamic> subscriptionData;

  @override
  void initState() {
    super.initState();
    loadSubscriptionData();
  }

  void loadSubscriptionData() {
    subscriptionData = {
      'currentStatus': 'Free',
      'expiryDate': null,
      'plans': [
        {
          'id': 'monthly',
          'name': 'Monthly',
          'price': 99,
          'period': 'per month',
          'savings': null,
          'features': [
            'Unlimited practice questions',
            'Unlimited mock tests',
            'Detailed performance analytics',
            'Previous year papers',
            'Video solutions',
            'Priority support',
            'Ad-free experience',
          ],
        },
        {
          'id': 'quarterly',
          'name': 'Quarterly',
          'price': 249,
          'period': 'per 3 months',
          'savings': 'Save 15%',
          'isBestValue': true,
          'features': [
            'Unlimited practice questions',
            'Unlimited mock tests',
            'Detailed performance analytics',
            'Previous year papers',
            'Video solutions',
            'Priority support',
            'Ad-free experience',
          ],
        },
        {
          'id': 'yearly',
          'name': 'Yearly',
          'price': 799,
          'period': 'per year',
          'savings': 'Save 33%',
          'features': [
            'Unlimited practice questions',
            'Unlimited mock tests',
            'Detailed performance analytics',
            'Previous year papers',
            'Video solutions',
            'Priority support',
            'Ad-free experience',
            'Offline downloads (coming soon)',
          ],
        },
      ],
    };
  }

  String getPlanPrice(String planId) {
    final plan = subscriptionData['plans']
        .firstWhere((p) => p['id'] == planId, orElse: () => null);
    return plan != null ? plan['price'].toString() : '0';
  }

  String getPlanPeriod(String planId) {
    final plan = subscriptionData['plans']
        .firstWhere((p) => p['id'] == planId, orElse: () => null);
    return plan != null ? plan['period'] : '';
  }

  void proceedToPayment() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Payment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Plan: ${selectedPlan.toUpperCase()}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Amount: ₹${getPlanPrice(selectedPlan)}'),
            const SizedBox(height: 8),
            Text('Payment: ${selectedPaymentMethod.toUpperCase()}'),
            const SizedBox(height: 16),
            const Text(
              'Proceed with payment?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              processPayment();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text('Pay Now'),
          ),
        ],
      ),
    );
  }

  void processPayment() {
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
              'Processing ₹${getPlanPrice(selectedPlan)} payment...',
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
              'Payment Successful!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'You are now a Premium member.\nEnjoy unlimited access!',
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close success dialog
              Navigator.pop(context); // Go back to previous screen
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Plan'),
        backgroundColor: const Color(0xFF5B4EE8),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Current Status
            Container(
              color: const Color(0xFF5B4EE8),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  const Text(
                    'Current Plan',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subscriptionData['currentStatus'],
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subscriptionData['expiryDate'] != null
                        ? 'Expires on ${subscriptionData['expiryDate']}'
                        : 'Upgrade to unlock premium features',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Pricing Plans
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

                  // Monthly Plan
                  _buildPlanCard(
                    'monthly',
                    'Monthly',
                    '₹99',
                    'per month',
                    null,
                    false,
                    [
                      'Unlimited practice questions',
                      'Unlimited mock tests',
                      'Performance analytics',
                      'Previous year papers',
                      'Priority support',
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Quarterly Plan (Best Value)
                  _buildPlanCard(
                    'quarterly',
                    'Quarterly',
                    '₹249',
                    'per 3 months',
                    'Save 15%',
                    true,
                    [
                      'Unlimited practice questions',
                      'Unlimited mock tests',
                      'Performance analytics',
                      'Previous year papers',
                      'Video solutions',
                      'Priority support',
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Yearly Plan
                  _buildPlanCard(
                    'yearly',
                    'Yearly',
                    '₹799',
                    'per year',
                    'Save 33%',
                    false,
                    [
                      'All Quarterly features',
                      'Offline downloads',
                      'Advanced analytics',
                      'Doubt support',
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Payment Method Selection
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Payment Method',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildPaymentOption('upi', '📱 UPI', 'Google Pay, PhonePe, etc'),
                    const SizedBox(height: 10),
                    _buildPaymentOption(
                        'card', '💳 Credit/Debit Card', 'Visa, Mastercard, etc'),
                    const SizedBox(height: 10),
                    _buildPaymentOption('wallet', '👛 Digital Wallet',
                        'PayTM, Amazon Pay, etc'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Features Comparison
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Premium Features',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureItem('Unlimited Questions',
                        'Access all practice questions'),
                    const SizedBox(height: 10),
                    _buildFeatureItem('Unlimited Tests',
                        'Take as many mock tests as you want'),
                    const SizedBox(height: 10),
                    _buildFeatureItem('Video Solutions',
                        'Learn from detailed video explanations'),
                    const SizedBox(height: 10),
                    _buildFeatureItem('Performance Analytics',
                        'Track your progress in detail'),
                    const SizedBox(height: 10),
                    _buildFeatureItem(
                        'Priority Support', 'Get help when you need it'),
                    const SizedBox(height: 10),
                    _buildFeatureItem('Ad-Free Experience',
                        'Study without distractions'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Security & Guarantee
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green[300]!),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.verified_user, color: Colors.green),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '7-Day Money Back Guarantee',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[900]!,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Not satisfied? Get a full refund within 7 days.',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Subscribe Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: proceedToPayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5B4EE8),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Subscribe Now - ₹${getPlanPrice(selectedPlan)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Continue as Free User
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

  Widget _buildPlanCard(
    String planId,
    String name,
    String price,
    String period,
    String? savings,
    bool isBestValue,
    List<String> features,
  ) {
    final isSelected = selectedPlan == planId;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPlan = planId;
        });
      },
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
                      savings,
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

  Widget _buildPaymentOption(String id, String title, String subtitle) {
    final isSelected = selectedPaymentMethod == id;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = id;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF5B4EE8).withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF5B4EE8) : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            Container(
              width: 18,
              height: 18,
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
                        size: 10,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String title, String subtitle) {
    return Row(
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 18),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
