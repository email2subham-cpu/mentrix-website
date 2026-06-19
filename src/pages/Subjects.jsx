 import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'

const EXAM_TYPES = ['WBCHSE', 'NEET', 'JEE Mains', 'WBJEE']

export default function Subjects() {
  const [subjects, setSubjects] = useState([])
  const [chapters, setChapters] = useState([])
  const [topics, setTopics] = useState([])
  const [subtopics, setSubtopics] = useState([])
  const [loading, setLoading] = useState(true)
  const [activeTab, setActiveTab] = useState('subjects')

  // Form states
  const [subjectForm, setSubjectForm] = useState({
    name: '', name_bengali: '', exam_type: 'WBCHSE', icon: ''
  })
  const [chapterForm, setChapterForm] = useState({
    subject_id: '', name: '', name_bengali: ''
  })
  const [topicForm, setTopicForm] = useState({
    chapter_id: '', name: '', name_bengali: ''
  })
  const [subtopicForm, setSubtopicForm] = useState({
    topic_id: '', name: '', name_bengali: '', is_premium: false
  })

  const [message, setMessage] = useState('')

  useEffect(() => {
    fetchAll()
  }, [])

  async function fetchAll() {
    setLoading(true)
    const [s, c, t, st] = await Promise.all([
      supabase.from('subjects').select('*').order('exam_type'),
      supabase.from('chapters').select('*, subjects(name, exam_type)').order('name'),
      supabase.from('topics').select('*, chapters(name)').order('name'),
      supabase.from('subtopics').select('*, topics(name)').order('name'),
    ])
    setSubjects(s.data || [])
    setChapters(c.data || [])
    setTopics(t.data || [])
    setSubtopics(st.data || [])
    setLoading(false)
  }

  async function addSubject(e) {
    e.preventDefault()
    const { error } = await supabase.from('subjects').insert([subjectForm])
    if (error) {
      setMessage(`❌ Error: ${error.message}`)
    } else {
      setMessage('✅ Subject added successfully!')
      setSubjectForm({ name: '', name_bengali: '', exam_type: 'WBCHSE', icon: '' })
      fetchAll()
    }
    setTimeout(() => setMessage(''), 3000)
  }

  async function addChapter(e) {
    e.preventDefault()
    const { error } = await supabase.from('chapters').insert([chapterForm])
    if (error) {
      setMessage(`❌ Error: ${error.message}`)
    } else {
      setMessage('✅ Chapter added successfully!')
      setChapterForm({ subject_id: '', name: '', name_bengali: '' })
      fetchAll()
    }
    setTimeout(() => setMessage(''), 3000)
  }

  async function addTopic(e) {
    e.preventDefault()
    const { error } = await supabase.from('topics').insert([topicForm])
    if (error) {
      setMessage(`❌ Error: ${error.message}`)
    } else {
      setMessage('✅ Topic added successfully!')
      setTopicForm({ chapter_id: '', name: '', name_bengali: '' })
      fetchAll()
    }
    setTimeout(() => setMessage(''), 3000)
  }

  async function addSubtopic(e) {
    e.preventDefault()
    const { error } = await supabase.from('subtopics').insert([subtopicForm])
    if (error) {
      setMessage(`❌ Error: ${error.message}`)
    } else {
      setMessage('✅ Subtopic added successfully!')
      setSubtopicForm({ topic_id: '', name: '', name_bengali: '', is_premium: false })
      fetchAll()
    }
    setTimeout(() => setMessage(''), 3000)
  }

  async function deleteItem(table, id) {
    if (!window.confirm('Are you sure you want to delete this?')) return
    const { error } = await supabase.from(table).delete().eq('id', id)
    if (error) {
      setMessage(`❌ Error: ${error.message}`)
    } else {
      setMessage('✅ Deleted successfully!')
      fetchAll()
    }
    setTimeout(() => setMessage(''), 3000)
  }

  if (loading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin text-4xl">⏳</div>
      </div>
    )
  }

  return (
    <div>
      {/* Header */}
      <div className="mb-8">
        <h1 className="text-3xl font-bold text-gray-800">Subject Management</h1>
        <p className="text-gray-500 mt-1">Manage subjects, chapters, topics and subtopics</p>
      </div>

      {/* Message */}
      {message && (
        <div className={`mb-4 p-4 rounded-lg ${message.includes('❌') ? 'bg-red-50 text-red-700' : 'bg-green-50 text-green-700'}`}>
          {message}
        </div>
      )}

      {/* Tabs */}
      <div className="flex gap-2 mb-6">
        {['subjects', 'chapters', 'topics', 'subtopics'].map((tab) => (
          <button
            key={tab}
            onClick={() => setActiveTab(tab)}
            className={`px-4 py-2 rounded-lg font-medium capitalize transition-all ${
              activeTab === tab
                ? 'bg-purple-600 text-white'
                : 'bg-white text-gray-600 hover:bg-gray-50'
            }`}
          >
            {tab}
          </button>
        ))}
      </div>

      {/* SUBJECTS TAB */}
      {activeTab === 'subjects' && (
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          {/* Add Subject Form */}
          <div className="bg-white rounded-xl shadow-sm p-6">
            <h2 className="text-xl font-bold text-gray-800 mb-4">Add Subject</h2>
            <form onSubmit={addSubject} className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Exam Type</label>
                <select
                  value={subjectForm.exam_type}
                  onChange={(e) => setSubjectForm({ ...subjectForm, exam_type: e.target.value })}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2"
                  required
                >
                  {EXAM_TYPES.map((exam) => (
                    <option key={exam} value={exam}>{exam}</option>
                  ))}
                </select>
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Subject Name (English)</label>
                <input
                  type="text"
                  value={subjectForm.name}
                  onChange={(e) => setSubjectForm({ ...subjectForm, name: e.target.value })}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2"
                  placeholder="e.g. Physics"
                  required
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Subject Name (Bengali)</label>
                <input
                  type="text"
                  value={subjectForm.name_bengali}
                  onChange={(e) => setSubjectForm({ ...subjectForm, name_bengali: e.target.value })}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2"
                  placeholder="e.g. পদার্থবিজ্ঞান"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Icon (Emoji)</label>
                <input
                  type="text"
                  value={subjectForm.icon}
                  onChange={(e) => setSubjectForm({ ...subjectForm, icon: e.target.value })}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2"
                  placeholder="e.g. ⚡"
                />
              </div>
              <button
                type="submit"
                className="w-full bg-purple-600 text-white py-2 rounded-lg font-medium hover:bg-purple-700"
              >
                Add Subject
              </button>
            </form>
          </div>

          {/* Subjects List */}
          <div className="bg-white rounded-xl shadow-sm p-6">
            <h2 className="text-xl font-bold text-gray-800 mb-4">Subjects ({subjects.length})</h2>
            <div className="space-y-2 max-h-96 overflow-y-auto">
              {subjects.map((subject) => (
                <div key={subject.id} className="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
                  <div>
                    <span className="mr-2">{subject.icon}</span>
                    <span className="font-medium">{subject.name}</span>
                    <span className="ml-2 text-xs bg-purple-100 text-purple-700 px-2 py-1 rounded-full">
                      {subject.exam_type}
                    </span>
                  </div>
                  <button
                    onClick={() => deleteItem('subjects', subject.id)}
                    className="text-red-500 hover:text-red-700 text-sm"
                  >
                    🗑️
                  </button>
                </div>
              ))}
            </div>
          </div>
        </div>
      )}

      {/* CHAPTERS TAB */}
      {activeTab === 'chapters' && (
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <div className="bg-white rounded-xl shadow-sm p-6">
            <h2 className="text-xl font-bold text-gray-800 mb-4">Add Chapter</h2>
            <form onSubmit={addChapter} className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Subject</label>
                <select
                  value={chapterForm.subject_id}
                  onChange={(e) => setChapterForm({ ...chapterForm, subject_id: e.target.value })}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2"
                  required
                >
                  <option value="">Select Subject</option>
                  {subjects.map((s) => (
                    <option key={s.id} value={s.id}>{s.exam_type} - {s.name}</option>
                  ))}
                </select>
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Chapter Name (English)</label>
                <input
                  type="text"
                  value={chapterForm.name}
                  onChange={(e) => setChapterForm({ ...chapterForm, name: e.target.value })}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2"
                  placeholder="e.g. Mechanics"
                  required
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Chapter Name (Bengali)</label>
                <input
                  type="text"
                  value={chapterForm.name_bengali}
                  onChange={(e) => setChapterForm({ ...chapterForm, name_bengali: e.target.value })}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2"
                  placeholder="e.g. বলবিদ্যা"
                />
              </div>
              <button
                type="submit"
                className="w-full bg-purple-600 text-white py-2 rounded-lg font-medium hover:bg-purple-700"
              >
                Add Chapter
              </button>
            </form>
          </div>

          <div className="bg-white rounded-xl shadow-sm p-6">
            <h2 className="text-xl font-bold text-gray-800 mb-4">Chapters ({chapters.length})</h2>
            <div className="space-y-2 max-h-96 overflow-y-auto">
              {chapters.map((chapter) => (
                <div key={chapter.id} className="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
                  <div>
                    <span className="font-medium">{chapter.name}</span>
                    <span className="ml-2 text-xs text-gray-500">
                      {chapter.subjects?.exam_type} - {chapter.subjects?.name}
                    </span>
                  </div>
                  <button
                    onClick={() => deleteItem('chapters', chapter.id)}
                    className="text-red-500 hover:text-red-700 text-sm"
                  >
                    🗑️
                  </button>
                </div>
              ))}
            </div>
          </div>
        </div>
      )}

      {/* TOPICS TAB */}
      {activeTab === 'topics' && (
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <div className="bg-white rounded-xl shadow-sm p-6">
            <h2 className="text-xl font-bold text-gray-800 mb-4">Add Topic</h2>
            <form onSubmit={addTopic} className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Chapter</label>
                <select
                  value={topicForm.chapter_id}
                  onChange={(e) => setTopicForm({ ...topicForm, chapter_id: e.target.value })}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2"
                  required
                >
                  <option value="">Select Chapter</option>
                  {chapters.map((c) => (
                    <option key={c.id} value={c.id}>
                      {c.subjects?.exam_type} - {c.subjects?.name} - {c.name}
                    </option>
                  ))}
                </select>
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Topic Name (English)</label>
                <input
                  type="text"
                  value={topicForm.name}
                  onChange={(e) => setTopicForm({ ...topicForm, name: e.target.value })}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2"
                  placeholder="e.g. Newton's Laws"
                  required
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Topic Name (Bengali)</label>
                <input
                  type="text"
                  value={topicForm.name_bengali}
                  onChange={(e) => setTopicForm({ ...topicForm, name_bengali: e.target.value })}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2"
                  placeholder="e.g. নিউটনের সূত"
                />
              </div>
              <button
                type="submit"
                className="w-full bg-purple-600 text-white py-2 rounded-lg font-medium hover:bg-purple-700"
              >
                Add Topic
              </button>
            </form>
          </div>

          <div className="bg-white rounded-xl shadow-sm p-6">
            <h2 className="text-xl font-bold text-gray-800 mb-4">Topics ({topics.length})</h2>
            <div className="space-y-2 max-h-96 overflow-y-auto">
              {topics.map((topic) => (
                <div key={topic.id} className="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
                  <div>
                    <span className="font-medium">{topic.name}</span>
                    <span className="ml-2 text-xs text-gray-500">
                      {topic.chapters?.name}
                    </span>
                  </div>
                  <button
                    onClick={() => deleteItem('topics', topic.id)}
                    className="text-red-500 hover:text-red-700 text-sm"
                  >
                    🗑️
                  </button>
                </div>
              ))}
            </div>
          </div>
        </div>
      )}

      {/* SUBTOPICS TAB */}
      {activeTab === 'subtopics' && (
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <div className="bg-white rounded-xl shadow-sm p-6">
            <h2 className="text-xl font-bold text-gray-800 mb-4">Add Subtopic</h2>
            <form onSubmit={addSubtopic} className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Topic</label>
                <select
                  value={subtopicForm.topic_id}
                  onChange={(e) => setSubtopicForm({ ...subtopicForm, topic_id: e.target.value })}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2"
                  required
                >
                  <option value="">Select Topic</option>
                  {topics.map((t) => (
                    <option key={t.id} value={t.id}>
                      {t.chapters?.name} - {t.name}
                    </option>
                  ))}
                </select>
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Subtopic Name (English)</label>
                <input
                  type="text"
                  value={subtopicForm.name}
                  onChange={(e) => setSubtopicForm({ ...subtopicForm, name: e.target.value })}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2"
                  placeholder="e.g. First Law of Motion"
                  required
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Subtopic Name (Bengali)</label>
                <input
                  type="text"
                  value={subtopicForm.name_bengali}
                  onChange={(e) => setSubtopicForm({ ...subtopicForm, name_bengali: e.target.value })}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2"
                  placeholder="e.g. গতির প্রথম সূত্র"
                />
              </div>
              <div className="flex items-center gap-2">
                <input
                  type="checkbox"
                  id="is_premium"
                  checked={subtopicForm.is_premium}
                  onChange={(e) => setSubtopicForm({ ...subtopicForm, is_premium: e.target.checked })}
                  className="w-4 h-4"
                />
                <label htmlFor="is_premium" className="text-sm font-medium text-gray-700">
                  Premium Content 👑
                </label>
              </div>
              <button
                type="submit"
                className="w-full bg-purple-600 text-white py-2 rounded-lg font-medium hover:bg-purple-700"
              >
                Add Subtopic
              </button>
            </form>
          </div>

          <div className="bg-white rounded-xl shadow-sm p-6">
            <h2 className="text-xl font-bold text-gray-800 mb-4">Subtopics ({subtopics.length})</h2>
            <div className="space-y-2 max-h-96 overflow-y-auto">
              {subtopics.map((subtopic) => (
                <div key={subtopic.id} className="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
                  <div>
                    <span className="font-medium">{subtopic.name}</span>
                    {subtopic.is_premium && (
                      <span className="ml-2 text-xs bg-amber-100 text-amber-700 px-2 py-1 rounded-full">
                        👑 Premium
                      </span>
                    )}
                    <span className="ml-2 text-xs text-gray-500">
                      {subtopic.topics?.name}
                    </span>
                  </div>
                  <button
                    onClick={() => deleteItem('subtopics', subtopic.id)}
                    className="text-red-500 hover:text-red-700 text-sm"
                  >
                    🗑️
                  </button>
                </div>
              ))}
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
