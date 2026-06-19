import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'

export default function Dashboard() {
  const [stats, setStats] = useState({
    subjects: 0,
    practiceQuestions: 0,
    testSeries: 0,
    testSeriesQuestions: 0,
    banners: 0,
    students: 0,
  })
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    fetchStats()
  }, [])

  async function fetchStats() {
    try {
      const [
        subjects,
        practiceQuestions,
        testSeries,
        testSeriesQuestions,
        banners,
        students,
      ] = await Promise.all([
        supabase.from('subjects').select('*', { count: 'exact', head: true }),
        supabase.from('practice_questions').select('*', { count: 'exact', head: true }),
        supabase.from('test_series').select('*', { count: 'exact', head: true }),
        supabase.from('test_series_questions').select('*', { count: 'exact', head: true }),
        supabase.from('banners').select('*', { count: 'exact', head: true }),
        supabase.from('students').select('*', { count: 'exact', head: true }),
      ])

      setStats({
        subjects: subjects.count || 0,
        practiceQuestions: practiceQuestions.count || 0,
        testSeries: testSeries.count || 0,
        testSeriesQuestions: testSeriesQuestions.count || 0,
        banners: banners.count || 0,
        students: students.count || 0,
      })
    } catch (error) {
      console.error('Error fetching stats:', error)
    } finally {
      setLoading(false)
    }
  }

  const statCards = [
    { label: 'Subjects', value: stats.subjects, icon: '📚', color: 'bg-blue-500' },
    { label: 'Practice Questions', value: stats.practiceQuestions, icon: '❓', color: 'bg-green-500' },
    { label: 'Test Series', value: stats.testSeries, icon: '📝', color: 'bg-purple-500' },
    { label: 'Test Questions', value: stats.testSeriesQuestions, icon: '✏️', color: 'bg-orange-500' },
    { label: 'Banners', value: stats.banners, icon: '🖼️', color: 'bg-pink-500' },
    { label: 'Students', value: stats.students, icon: '👥', color: 'bg-indigo-500' },
  ]

  if (loading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="text-center">
          <div className="animate-spin text-4xl mb-4">⏳</div>
          <p className="text-gray-500">Loading dashboard...</p>
        </div>
      </div>
    )
  }

  return (
    <div>
      {/* Header */}
      <div className="mb-8">
        <h1 className="text-3xl font-bold text-gray-800">Dashboard</h1>
        <p className="text-gray-500 mt-1">Welcome to Mentrix CMS</p>
      </div>

      {/* Stats Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-8">
        {statCards.map((card) => (
          <div
            key={card.label}
            className="bg-white rounded-xl shadow-sm p-6 flex items-center gap-4"
          >
            <div className={`${card.color} w-14 h-14 rounded-xl flex items-center justify-center text-2xl`}>
              {card.icon}
            </div>
            <div>
              <p className="text-gray-500 text-sm">{card.label}</p>
              <p className="text-3xl font-bold text-gray-800">{card.value}</p>
            </div>
          </div>
        ))}
      </div>

      {/* Quick Actions */}
      <div className="bg-white rounded-xl shadow-sm p-6">
        <h2 className="text-xl font-bold text-gray-800 mb-4">Quick Actions</h2>
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
          <a
            href="/questions"
            className="bg-green-50 border border-green-200 rounded-lg p-4 text-center hover:bg-green-100 transition-all"
          >
            <div className="text-2xl mb-2">➕</div>
            <p className="text-sm font-medium text-green-700">Add Question</p>
          </a>
          <a
            href="/test-series"
            className="bg-purple-50 border border-purple-200 rounded-lg p-4 text-center hover:bg-purple-100 transition-all"
          >
            <div className="text-2xl mb-2">📝</div>
            <p className="text-sm font-medium text-purple-700">Create Test</p>
          </a>
          <a
            href="/banners"
            className="bg-pink-50 border border-pink-200 rounded-lg p-4 text-center hover:bg-pink-100 transition-all"
          >
            <div className="text-2xl mb-2">🖼️</div>
            <p className="text-sm font-medium text-pink-700">Add Banner</p>
          </a>
          <a
            href="/subjects"
            className="bg-blue-50 border border-blue-200 rounded-lg p-4 text-center hover:bg-blue-100 transition-all"
          >
            <div className="text-2xl mb-2">📚</div>
            <p className="text-sm font-medium text-blue-700">Add Subject</p>
          </a>
        </div>
      </div>
    </div>
  )
}
