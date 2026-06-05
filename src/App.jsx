import React, { useState } from 'react';

export default function App() {
  const [email, setEmail] = useState('');

  const exams = [
    { name: 'WBCHSE', icon: '📋', desc: 'West Bengal Board', color: 'from-blue-500' },
    { name: 'NEET', icon: '🏥', desc: 'Medical Entrance', color: 'from-green-500' },
    { name: 'JEE Mains', icon: '🔬', desc: 'Engineering Entrance', color: 'from-orange-500' },
    { name: 'WBJEE', icon: '🎯', desc: 'Engineering Exam', color: 'from-purple-500' },
  ];

  const features = [
    { 
      icon: '📚', 
      title: 'Question Practice', 
      desc: 'Solve 1000+ MCQs organized by chapters and topics' 
    },
    { 
      icon: '📝', 
      title: 'Mock Tests', 
      desc: 'Full-length exams with instant results & analysis' 
    },
    { 
      icon: '⚡', 
      title: 'Smart Learning', 
      desc: 'Track progress, identify weak topics, learn smarter' 
    },
    { 
      icon: '🌍', 
      title: 'Multiple Exams', 
      desc: 'Prepare for WBCHSE, NEET, JEE, WBJEE in one app' 
    },
    { 
      icon: '📊', 
      title: 'Detailed Analytics', 
      desc: 'Performance reports, rankings, and study insights' 
    },
    { 
      icon: '🎓', 
      title: 'Expert Content', 
      desc: 'Curated by top educators and subject experts' 
    },
  ];

  const plans = [
    {
      name: 'Free',
      price: '₹0',
      desc: 'Perfect for trying out',
      features: ['2 Free subtopics per exam', '2 Free mock tests', 'Limited question practice', 'Basic analytics'],
      cta: 'Get Started',
      highlight: false,
    },
    {
      name: 'Premium',
      price: '₹299',
      period: '/month',
      desc: 'Best for serious students',
      features: ['All questions & tests', 'Unlimited practice', 'Detailed analytics', 'Personalized learning path', 'Ad-free experience'],
      cta: 'Start Free Trial',
      highlight: true,
    },
  ];

  const faqs = [
    { q: 'Is Mentrix free to use?', a: 'Yes! Start free with 2 subtopics and 2 tests per exam. Upgrade to Premium for unlimited access.' },
    { q: 'Can I prepare for multiple exams?', a: 'Absolutely! Our platform supports WBCHSE, NEET, JEE Mains, and WBJEE with subject-specific content.' },
    { q: 'How accurate are the mock tests?', a: 'Our tests are designed by expert educators and closely follow official exam patterns and difficulty levels.' },
    { q: 'Can I track my progress?', a: 'Yes! Get detailed analytics on your performance, weak topics, and personalized recommendations.' },
    { q: 'Is there an offline mode?', a: 'Coming soon! Download questions and tests to study offline.' },
  ];

  return (
    <div className="w-full bg-white">
      {/* Navigation */}
      <nav className="fixed top-0 w-full bg-white shadow-sm z-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4 flex justify-between items-center">
          <div className="text-2xl font-bold text-blue-600">
            <span className="text-blue-600">M</span><span className="text-gray-800">entrix</span>
          </div>
          <div className="hidden md:flex gap-8">
            <a href="#features" className="text-gray-700 hover:text-blue-600">Features</a>
            <a href="#exams" className="text-gray-700 hover:text-blue-600">Exams</a>
            <a href="#pricing" className="text-gray-700 hover:text-blue-600">Pricing</a>
            <a href="#faq" className="text-gray-700 hover:text-blue-600">FAQ</a>
          </div>
          <button className="bg-blue-600 text-white px-6 py-2 rounded-lg hover:bg-blue-700 font-semibold">
            Download App
          </button>
        </div>
      </nav>

      {/* Hero Section */}
      <section className="pt-32 pb-20 bg-gradient-to-br from-blue-50 to-indigo-100 px-4">
        <div className="max-w-7xl mx-auto text-center">
          <h1 className="text-5xl md:text-6xl font-bold text-gray-900 mb-6">
            Master Your Exams with <span className="text-blue-600">Mentrix</span>
          </h1>
          <p className="text-xl text-gray-700 mb-8 max-w-2xl mx-auto">
            Practice 1000+ MCQs, take mock tests, and ace WBCHSE, NEET, JEE & WBJEE with AI-powered insights
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center mb-12">
            <input 
              type="email" 
              placeholder="Enter your email" 
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="px-6 py-3 rounded-lg border-2 border-gray-300 focus:border-blue-600 outline-none w-full sm:w-80"
            />
            <button className="bg-blue-600 text-white px-8 py-3 rounded-lg hover:bg-blue-700 font-bold whitespace-nowrap">
              Get Started Free
            </button>
          </div>
          <div className="text-sm text-gray-600">✅ No credit card required • ✅ Free forever plan available</div>
        </div>
      </section>

      {/* Exams Section */}
      <section id="exams" className="py-20 px-4 bg-white">
        <div className="max-w-7xl mx-auto">
          <h2 className="text-4xl font-bold text-center mb-4 text-gray-900">Exams We Cover</h2>
          <p className="text-center text-gray-600 mb-12 text-lg">Prepare for all major competitive and board exams</p>
          <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
            {exams.map((exam, i) => (
              <div key={i} className={`bg-gradient-to-br ${exam.color} to-gray-900 rounded-xl p-8 text-white text-center hover:shadow-lg transition`}>
                <div className="text-5xl mb-4">{exam.icon}</div>
                <h3 className="text-2xl font-bold mb-2">{exam.name}</h3>
                <p className="text-sm opacity-90">{exam.desc}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section id="features" className="py-20 px-4 bg-gray-50">
        <div className="max-w-7xl mx-auto">
          <h2 className="text-4xl font-bold text-center mb-4 text-gray-900">Why Choose Mentrix?</h2>
          <p className="text-center text-gray-600 mb-12 text-lg">Everything you need to succeed in your exams</p>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            {features.map((f, i) => (
              <div key={i} className="bg-white p-8 rounded-xl shadow-md hover:shadow-xl transition">
                <div className="text-4xl mb-4">{f.icon}</div>
                <h3 className="text-xl font-bold mb-2 text-gray-900">{f.title}</h3>
                <p className="text-gray-600">{f.desc}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Pricing Section */}
      <section id="pricing" className="py-20 px-4 bg-white">
        <div className="max-w-7xl mx-auto">
          <h2 className="text-4xl font-bold text-center mb-4 text-gray-900">Simple, Transparent Pricing</h2>
          <p className="text-center text-gray-600 mb-12 text-lg">Start free, upgrade anytime</p>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-8 max-w-4xl mx-auto">
            {plans.map((plan, i) => (
              <div 
                key={i} 
                className={`rounded-xl p-8 ${plan.highlight ? 'bg-blue-600 text-white shadow-xl scale-105' : 'bg-gray-50 border-2 border-gray-200'}`}
              >
                <h3 className="text-2xl font-bold mb-2">{plan.name}</h3>
                <p className={`mb-4 text-sm ${plan.highlight ? 'text-blue-100' : 'text-gray-600'}`}>{plan.desc}</p>
                <div className="mb-6">
                  <span className="text-4xl font-bold">{plan.price}</span>
                  {plan.period && <span className={plan.highlight ? 'text-blue-100' : 'text-gray-600'}>{plan.period}</span>}
                </div>
                <ul className="space-y-3 mb-8">
                  {plan.features.map((feat, j) => (
                    <li key={j} className="flex items-center gap-3">
                      <span className="text-lg">✓</span>
                      <span>{feat}</span>
                    </li>
                  ))}
                </ul>
                <button className={`w-full py-3 rounded-lg font-bold ${plan.highlight ? 'bg-white text-blue-600 hover:bg-gray-100' : 'bg-blue-600 text-white hover:bg-blue-700'}`}>
                  {plan.cta}
                </button>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* FAQ Section */}
      <section id="faq" className="py-20 px-4 bg-gray-50">
        <div className="max-w-3xl mx-auto">
          <h2 className="text-4xl font-bold text-center mb-12 text-gray-900">Frequently Asked Questions</h2>
          <div className="space-y-4">
            {faqs.map((faq, i) => (
              <details key={i} className="bg-white p-6 rounded-lg shadow-md cursor-pointer group">
                <summary className="font-bold text-lg text-gray-900 group-open:text-blue-600 flex justify-between items-center">
                  {faq.q}
                  <span className="text-2xl group-open:rotate-180 transition">›</span>
                </summary>
                <p className="text-gray-600 mt-4 ml-4">{faq.a}</p>
              </details>
            ))}
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="py-20 px-4 bg-gradient-to-r from-blue-600 to-indigo-600 text-white text-center">
        <h2 className="text-4xl font-bold mb-6">Ready to Ace Your Exams?</h2>
        <p className="text-xl mb-8 opacity-90">Join thousands of students preparing with Mentrix</p>
        <button className="bg-white text-blue-600 px-8 py-3 rounded-lg font-bold hover:bg-gray-100">
          Download Now - It's Free
        </button>
      </section>

      {/* Footer */}
      <footer className="bg-gray-900 text-white py-12 px-4">
        <div className="max-w-7xl mx-auto">
          <div className="grid grid-cols-1 md:grid-cols-4 gap-8 mb-8">
            <div>
              <h3 className="text-2xl font-bold text-blue-400 mb-4">Mentrix</h3>
              <p className="text-gray-400">Master your exams with smart learning</p>
            </div>
            <div>
              <h4 className="font-bold mb-4">Product</h4>
              <ul className="space-y-2 text-gray-400">
                <li><a href="#" className="hover:text-white">Features</a></li>
                <li><a href="#" className="hover:text-white">Pricing</a></li>
                <li><a href="#" className="hover:text-white">Download</a></li>
              </ul>
            </div>
            <div>
              <h4 className="font-bold mb-4">Company</h4>
              <ul className="space-y-2 text-gray-400">
                <li><a href="#" className="hover:text-white">About</a></li>
                <li><a href="#" className="hover:text-white">Blog</a></li>
                <li><a href="#" className="hover:text-white">Contact</a></li>
              </ul>
            </div>
            <div>
              <h4 className="font-bold mb-4">Legal</h4>
              <ul className="space-y-2 text-gray-400">
                <li><a href="#" className="hover:text-white">Privacy</a></li>
                <li><a href="#" className="hover:text-white">Terms</a></li>
              </ul>
            </div>
          </div>
          <div className="border-t border-gray-700 pt-8 text-center text-gray-400">
            <p>&copy; 2025 Mentrix. All rights reserved.</p>
          </div>
        </div>
      </footer>
    </div>
  );
}
