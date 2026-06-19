import { Link, useLocation } from 'react-router-dom'

const menuItems = [
  { path: '/', icon: '📊', label: 'Dashboard' },
  { path: '/subjects', icon: '📚', label: 'Subjects' },
  { path: '/questions', icon: '❓', label: 'Practice Questions' },
  { path: '/test-series', icon: '📝', label: 'Test Series' },
  { path: '/banners', icon: '🖼️', label: 'Banners' },
]

export default function Sidebar() {
  const location = useLocation()

  return (
    <div className="w-64 min-h-screen bg-gray-900 text-white flex flex-col">
      {/* Logo */}
      <div className="p-6 border-b border-gray-700">
        <h1 className="text-2xl font-bold text-purple-400">📱 Mentrix</h1>
        <p className="text-gray-400 text-sm mt-1">CMS Dashboard</p>
      </div>

      {/* Menu Items */}
      <nav className="flex-1 p-4">
        {menuItems.map((item) => {
          const isActive = location.pathname === item.path
          return (
            <Link
              key={item.path}
              to={item.path}
              className={`flex items-center gap-3 px-4 py-3 rounded-lg mb-2 transition-all ${
                isActive
                  ? 'bg-purple-600 text-white'
                  : 'text-gray-400 hover:bg-gray-800 hover:text-white'
              }`}
            >
              <span className="text-xl">{item.icon}</span>
              <span className="font-medium">{item.label}</span>
            </Link>
          )
        })}
      </nav>

      {/* Footer */}
      <div className="p-4 border-t border-gray-700">
        <p className="text-gray-500 text-xs text-center">
          Mentrix CMS v2.0
        </p>
      </div>
    </div>
  )
}
