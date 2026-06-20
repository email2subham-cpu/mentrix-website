import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'

const EXAM_TYPES = ['WBCHSE', 'NEET', 'JEE Mains', 'WBJEE']
const DIFFICULTIES = ['easy', 'medium', 'hard']

export default function Questions() {
  const [questions, setQuestions] = useState([])
  const [subjects, setSubjects] = useState([])
  const [chapters, setChapters] = useState([])
  const [topics, setTopics] = useState([])
  const [subtopics, setSubtopics] = useState([])
  const [loading, setLoading] = useState(true)
  const [message, setMessage] = useState('')
  const [filterExam, setFilterExam] = useState('All')

  const initialForm = {
    exam_type: 'WBCHSE',
    subject_name: '',
    chapter_name: '',
    topic_name: '',
    subtopic_id: '',
    question_english: '',
    question_bengali: '',
    option_a_english: '',
    option_a_bengali: '',
    option_b_english: '',
    option_b_bengali: '',
    option_c_english: '',
    option_c_bengali: '',
    option_d_english: '',
    option_d_bengali: '',
    correct_option: 'A',
    explanation_english: '',
    explanation_bengali: '',
    difficulty: 'medium',
  }

  const [form, setForm] = useState(initialForm)
  const [selectedSubjectId, setSelectedSubjectId] = useState('')
  const [selectedChapterId, setSelectedChapterId] = useState('')
  const [selectedTopicId, setSelectedTopicId] = useState('')
  const [filteredChapters, setFilteredChapters] = useState([])
  const [filteredTopics, setFilteredTopics] = useState([])
  const [filteredSubtopics, setFilteredSubtopics] = useState([])

  useEffect(() => {
    fetchAll()
  }, [])

  useEffect(() => {
    if (selectedSubjectId) {
      setFilteredChapters(chapters.filter((c) => c.subject_id === selectedSubjectId))
    } else {
      setFilteredChapters([])
    }
    setSelectedChapterId('')
  }, [selectedSubjectId, chapters])

  useEffect(() => {
    if (selectedChapterId) {
      setFilteredTopics(topics.filter((t) => t.chapter_id === selectedChapterId))
    } else {
      setFilteredTopics([])
    }
    setSelectedTopicId('')
  }, [selectedChapterId, topics])

  useEffect(() => {
    if (selectedTopicId) {
      setFilteredSubtopics(subtopics.filter((s) => s.topic_id === selectedTopicId))
    } else {
      setFilteredSubtopics([])
    }
  }, [selectedTopicId, subtopics])

  async function fetchAll() {
    setLoading(true)
    const [q, s, c, t, st] = await Promise.all([
      supabase.from('practice_questions').select('*').order('created_at', { ascending: false }),
      supabase.from('subjects').select('*').order('exam_type'),
      supabase.from('chapters').select('*'),
      supabase.from('topics').select('*'),
      supabase.from('subtopics').select('*'),
    ])
    setQuestions(q.data || [])
    setSubjects(s.data || [])
    setChapters(c.data || [])
    setTopics(t.data || [])
    setSubtopics(st.data || [])
    setLoading(false)
  }

  async function handleSubmit(e) {
    e.preventDefault()

    const subjectObj = subjects.find((s) => s.id === selectedSubjectId)
    const chapterObj = chapters.find((c) => c.id === selectedChapterId)
    const topicObj = topics.find((t) => t.id === selectedTopicId)

    const payload = {
      ...form,
      subject_name: subjectObj?.name || form.subject_name,
      chapter_name: chapterObj?.name || '',
      topic_name: topicObj?.name || '',
      subtopic_id: form.subtopic_id || null,
    }

    const { error } = await supabase.from('practice_questions').insert([payload])

    if (error) {
      setMessage(`❌ Error: ${error.message}`)
    } else {
      setMessage('✅ Question added successfully!')
      setForm(initialForm)
      setSelectedSubjectId('')
      setSelectedChapterId('')
      setSelectedTopicId('')
      fetchAll()
    }
    setTimeout(() => setMessage(''), 3000)
  }

  async function deleteQuestion(id) {
    if (!window.confirm('Are you sure you want to delete this question?')) return
    const { error } = await supabase.from('practice_questions').delete().eq('id', id)
    if (error) {
      setMessage(`❌ Error: ${error.message}`)
    } else {
      setMessage('✅ Question deleted!')
      fetchAll()
    }
    setTimeout(() => setMessage(''), 3000)
  }

  const filteredQuestions =
    filterExam === 'All' ? questions : questions.filter((q) => q.exam_type === filterExam)

  if (loading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin text-4xl">⏳</div>
      </div>
    )
  }

  return (
    <div>
      <div className="mb-8">
        <h1 className="text-3xl font-bold text-gray-800">Practice Questions</h1>
        <p className="text-gray-500 mt-1">Manage your practice question bank</p>
      </div>

      {message && (
        <div
          className={`mb-4 p-4 rounded-lg ${
            message.includes('❌') ? 'bg-red-50 text-red-700' : 'bg-green-50 text-green-700'
          }`}
        >
          {message}
        </div>
      )}

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* ADD QUESTION FORM */}
        <div className="bg-white rounded-xl shadow-sm p-6 h-fit">
          <h2 className="text-xl font-bold text-gray-800 mb-4">Add Practice Question</h2>
          <form onSubmit={handleSubmit} className="space-y-4">
            {/* Exam Type */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Exam Type</label>
              <select
                value={form.exam_type}
                onChange={(e) => setForm({ ...form, exam_type: e.target.value })}
                className="w-full border border-gray-300 rounded-lg px-3 py-2"
                required
              >
                {EXAM_TYPES.map((exam) => (
                  <option key={exam} value={exam}>{exam}</option>
                ))}
              </select>
            </div>

            {/* Subject */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Subject</label>
              <select
                value={selectedSubjectId}
                onChange={(e) => setSelectedSubjectId(e.target.value)}
                className="w-full border border-gray-300 rounded-lg px-3 py-2"
                required
              >
                <option value="">Select Subject</option>
                {subjects
                  .filter((s) => s.exam_type === form.exam_type)
                  .map((s) => (
                    <option key={s.id} value={s.id}>{s.name}</option>
                  ))}
              </select>
            </div>

            {/* Chapter */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Chapter</label>
              <select
                value={selectedChapterId}
                onChange={(e) => setSelectedChapterId(e.target.value)}
                className="w-full border border-gray-300 rounded-lg px-3 py-2"
              >
                <option value="">Select Chapter</option>
                {filteredChapters.map((c) => (
                  <option key={c.id} value={c.id}>{c.name}</option>
                ))}
              </select>
            </div>

            {/* Topic */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Topic</label>
              <select
                value={selectedTopicId}
                onChange={(e) => setSelectedTopicId(e.target.value)}
                className="w-full border border-gray-300 rounded-lg px-3 py-2"
              >
                <option value="">Select Topic</option>
                {filteredTopics.map((t) => (
                  <option key={t.id} value={t.id}>{t.name}</option>
                ))}
              </select>
            </div>

            {/* Subtopic */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Subtopic</label>
              <select
                value={form.subtopic_id}
                onChange={(e) => setForm({ ...form, subtopic_id: e.target.value })}
                className="w-full border border-gray-300 rounded-lg px-3 py-2"
              >
                <option value="">Select Subtopic</option>
                {filteredSubtopics.map((s) => (
                  <option key={s.id} value={s.id}>{s.name}</option>
                ))}
              </select>
            </div>

            {/* Difficulty */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Difficulty</label>
              <select
                value={form.difficulty}
                onChange={(e) => setForm({ ...form, difficulty: e.target.value })}
                className="w-full border border-gray-300 rounded-lg px-3 py-2"
              >
                {DIFFICULTIES.map((d) => (
                  <option key={d} value={d} className="capitalize">{d}</option>
                ))}
              </select>
            </div>

            <hr className="my-4" />

            {/* Question */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Question (English)</label>
              <textarea
                value={form.question_english}
                onChange={(e) => setForm({ ...form, question_english: e.target.value })}
                className="w-full border border-gray-300 rounded-lg px-3 py-2"
                rows="2"
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Question (Bengali)</label>
              <textarea
                value={form.question_bengali}
                onChange={(e) => setForm({ ...form, question_bengali: e.target.value })}
                className="w-full border border-gray-300 rounded-lg px-3 py-2"
                rows="2"
              />
            </div>

            {/* Options */}
            {['a', 'b', 'c', 'd'].map((opt) => (
              <div key={opt} className="grid grid-cols-2 gap-2">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Option {opt.toUpperCase()} (English)
                  </label>
                  <input
                    type="text"
                    value={form[`option_${opt}_english`]}
                    onChange={(e) => setForm({ ...form, [`option_${opt}_english`]: e.target.value })}
                    className="w-full border border-gray-300 rounded-lg px-3 py-2"
                    required
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Option {opt.toUpperCase()} (Bengali)
                  </label>
                  <input
                    type="text"
                    value={form[`option_${opt}_bengali`]}
                    onChange={(e) => setForm({ ...form, [`option_${opt}_bengali`]: e.target.value })}
                    className="w-full border border-gray-300 rounded-lg px-3 py-2"
                  />
                </div>
              </div>
            ))}

            {/* Correct Option */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Correct Option</label>
              <select
                value={form.correct_option}
                onChange={(e) => setForm({ ...form, correct_option: e.target.value })}
                className="w-full border border-gray-300 rounded-lg px-3 py-2"
                required
              >
                <option value="A">A</option>
                <option value="B">B</option>
                <option value="C">C</option>
                <option value="D">D</option>
              </select>
            </div>

            {/* Explanation */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Explanation (English)</label>
              <textarea
                value={form.explanation_english}
                onChange={(e) => setForm({ ...form, explanation_english: e.target.value })}
                className="w-full border border-gray-300 rounded-lg px-3 py-2"
                rows="2"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Explanation (Bengali)</label>
              <textarea
                value={form.explanation_bengali}
                onChange={(e) => setForm({ ...form, explanation_bengali: e.target.value })}
                className="w-full border border-gray-300 rounded-lg px-3 py-2"
                rows="2"
              />
            </div>

            <button
              type="submit"
              className="w-full bg-green-600 text-white py-3 rounded-lg font-medium hover:bg-green-700"
            >
              ➕ Add Question
            </button>
          </form>
        </div>

        {/* QUESTIONS LIST */}
        <div className="bg-white rounded-xl shadow-sm p-6 h-fit">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-xl font-bold text-gray-800">
              Questions ({filteredQuestions.length})
            </h2>
            <select
              value={filterExam}
              onChange={(e) => setFilterExam(e.target.value)}
              className="border border-gray-300 rounded-lg px-3 py-1 text-sm"
            >
              <option value="All">All Exams</option>
              {EXAM_TYPES.map((exam) => (
                <option key={exam} value={exam}>{exam}</option>
              ))}
            </select>
          </div>
          <div className="space-y-3 max-h-[800px] overflow-y-auto">
            {filteredQuestions.map((q) => (
              <div key={q.id} className="p-4 bg-gray-50 rounded-lg">
                <div className="flex items-start justify-between mb-2">
                  <div className="flex gap-2">
                    <span className="text-xs bg-purple-100 text-purple-700 px-2 py-1 rounded-full">
                      {q.exam_type}
                    </span>
                    <span className="text-xs bg-blue-100 text-blue-700 px-2 py-1 rounded-full">
                      {q.subject_name}
                    </span>
                    <span className="text-xs bg-orange-100 text-orange-700 px-2 py-1 rounded-full capitalize">
                      {q.difficulty}
                    </span>
                  </div>
                  <button
                    onClick={() => deleteQuestion(q.id)}
                    className="text-red-500 hover:text-red-700 text-sm"
                  >
                    🗑️
                  </button>
                </div>
                <p className="text-sm font-medium text-gray-800">{q.question_english}</p>
                <p className="text-xs text-gray-500 mt-1">
                  Correct: {q.correct_option} | {q.chapter_name || 'No chapter'}
                </p>
              </div>
            ))}
            {filteredQuestions.length === 0 && (
              <p className="text-gray-400 text-center py-8">No questions yet. Add your first one!</p>
            )}
          </div>
        </div>
      </div>
    </div>
  )
