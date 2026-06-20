import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'

const EXAM_TYPES = ['WBCHSE', 'NEET', 'JEE Mains', 'WBJEE']
const DIFFICULTIES = ['easy', 'medium', 'hard']

// Official question counts per exam/subject
const QUESTION_COUNTS = {
  'WBCHSE': {
    'Physics': 35, 'Chemistry': 35, 'Biology': 35,
    'History': 35, 'Geography': 35,
    'Mathematics': 40, 'Bengali': 40, 'English': 40,
  },
  'NEET': { 'Physics': 45, 'Chemistry': 45, 'Biology': 90 },
  'JEE Mains': { 'Physics': 25, 'Chemistry': 25, 'Mathematics': 25 },
  'WBJEE': { 'Physics': 40, 'Chemistry': 40, 'Mathematics': 75 },
}

const DURATION = {
  'WBCHSE': 75, 'NEET': 180, 'JEE Mains': 180, 'WBJEE': 120,
}

export default function TestSeries() {
  const [testSeries, setTestSeries] = useState([])
  const [subjects, setSubjects] = useState([])
  const [selectedTest, setSelectedTest] = useState(null)
  const [testQuestions, setTestQuestions] = useState([])
  const [loading, setLoading] = useState(true)
  const [message, setMessage] = useState('')
  const [view, setView] = useState('list') // list, create, manage

  const [testForm, setTestForm] = useState({
    exam_type: 'WBCHSE',
    subject_name: '',
    name: '',
    name_bengali: '',
    total_questions: 35,
    duration_minutes: 75,
    is_premium: false,
  })

  const questionInitial = {
    question_english: '',
    question_bengali: '',
    option_a_english: '', option_a_bengali: '',
    option_b_english: '', option_b_bengali: '',
    option_c_english: '', option_c_bengali: '',
    option_d_english: '', option_d_bengali: '',
    correct_option: 'A',
    explanation_english: '',
    explanation_bengali: '',
    difficulty: 'medium',
  }
  const [questionForm, setQuestionForm] = useState(questionInitial)

  useEffect(() => {
    fetchAll()
  }, [])

  useEffect(() => {
    // Auto-set question count and duration based on exam+subject
    if (testForm.exam_type && testForm.subject_name) {
      const count = QUESTION_COUNTS[testForm.exam_type]?.[testForm.subject_name] || 35
      const duration = DURATION[testForm.exam_type] || 75
      setTestForm((prev) => ({ ...prev, total_questions: count, duration_minutes: duration }))
    }
  }, [testForm.exam_type, testForm.subject_name])

  async function fetchAll() {
    setLoading(true)
    const [ts, s] = await Promise.all([
      supabase.from('test_series').select('*').order('created_at', { ascending: false }),
      supabase.from('subjects').select('*').order('exam_type'),
    ])
    setTestSeries(ts.data || [])
    setSubjects(s.data || [])
    setLoading(false)
  }

  async function fetchTestQuestions(testId) {
    const { data } = await supabase
      .from('test_series_questions')
      .select('*')
      .eq('test_series_id', testId)
      .order('order_index')
    setTestQuestions(data || [])
  }

  async function createTestSeries(e) {
    e.preventDefault()
    const { error } = await supabase.from('test_series').insert([testForm])
    if (error) {
      setMessage(`❌ Error: ${error.message}`)
    } else {
      setMessage('✅ Test series created! Now add questions to it.')
      setTestForm({
        exam_type: 'WBCHSE', subject_name: '', name: '', name_bengali: '',
        total_questions: 35, duration_minutes: 75, is_premium: false,
      })
      fetchAll()
      setView('list')
    }
    setTimeout(() => setMessage(''), 3000)
  }

  async function addQuestionToTest(e) {
    e.preventDefault()
    const payload = {
      ...questionForm,
      test_series_id: selectedTest.id,
      order_index: testQuestions.length,
    }
    const { error } = await supabase.from('test_series_questions').insert([payload])
    if (error) {
      setMessage(`❌ Error: ${error.message}`)
    } else {
      setMessage(`✅ Question added! (${testQuestions.length + 1}/${selectedTest.total_questions})`)
      setQuestionForm(questionInitial)
      fetchTestQuestions(selectedTest.id)
    }
    setTimeout(() => setMessage(''), 3000)
  }

  async function deleteTestSeries(id) {
    if (!window.confirm('Delete this test series and all its questions?')) return
    const { error } = await supabase.from('test_series').delete().eq('id', id)
    if (error) {
      setMessage(`❌ Error: ${error.message}`)
    } else {
      setMessage('✅ Test series deleted!')
      fetchAll()
    }
    setTimeout(() => setMessage(''), 3000)
  }

  async function deleteTestQuestion(id) {
    if (!window.confirm('Delete this question?')) return
    const { error } = await supabase.from('test_series_questions').delete().eq('id', id)
    if (!error) {
      fetchTestQuestions(selectedTest.id)
    }
  }

  function openManageView(test) {
    setSelectedTest(test)
    fetchTestQuestions(test.id)
    setView('manage')
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
      <div className="mb-8 flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-800">Test Series</h1>
          <p className="text-gray-500 mt-1">Create and manage mock tests (separate question pool)</p>
        </div>
        {view !== 'list' && (
          <button
            onClick={() => setView('list')}
            className="px-4 py-2 bg-gray-200 rounded-lg hover:bg-gray-300"
          >
            ← Back to List
          </button>
        )}
        {view === 'list' && (
          <button
            onClick={() => setView('create')}
            className="px-4 py-2 bg-purple-600 text-white rounded-lg hover:bg-purple-700"
          >
            ➕ Create Test Series
          </button>
        )}
      </div>

      {message && (
        <div className={`mb-4 p-4 rounded-lg ${message.includes('❌') ? 'bg-red-50 text-red-700' : 'bg-green-50 text-green-700'}`}>
          {message}
        </div>
      )}

      {/* LIST VIEW */}
      {view === 'list' && (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {testSeries.map((test) => (
            <div key={test.id} className="bg-white rounded-xl shadow-sm p-6">
              <div className="flex items-start justify-between mb-3">
                <span className="text-xs bg-purple-100 text-purple-700 px-2 py-1 rounded-full">
                  {test.exam_type}
                </span>
                {test.is_premium && (
                  <span className="text-xs bg-amber-100 text-amber-700 px-2 py-1 rounded-full">
                    👑 Premium
                  </span>
                )}
              </div>
              <h3 className="font-bold text-gray-800 mb-1">{test.name}</h3>
              <p className="text-sm text-gray-500 mb-3">{test.subject_name}</p>
              <div className="flex gap-4 text-xs text-gray-500 mb-4">
                <span>📝 {test.total_questions} Questions</span>
                <span>⏱️ {test.duration_minutes} mins</span>
              </div>
              <div className="flex gap-2">
                <button
                  onClick={() => openManageView(test)}
                  className="flex-1 bg-blue-50 text-blue-700 py-2 rounded-lg text-sm font-medium hover:bg-blue-100"
                >
                  Manage Questions
                </button>
                <button
                  onClick={() => deleteTestSeries(test.id)}
                  className="px-3 bg-red-50 text-red-600 py-2 rounded-lg text-sm hover:bg-red-100"
                >
                  🗑️
                </button>
              </div>
            </div>
          ))}
          {testSeries.length === 0 && (
            <p className="text-gray-400 col-span-3 text-center py-12">
              No test series yet. Create your first one!
            </p>
          )}
        </div>
      )}

      {/* CREATE VIEW */}
      {view === 'create' && (
        <div className="bg-white rounded-xl shadow-sm p-6 max-w-xl">
          <h2 className="text-xl font-bold text-gray-800 mb-4">Create Test Series</h2>
          <form onSubmit={createTestSeries} className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Exam Type</label>
              <select
                value={testForm.exam_type}
                onChange={(e) => setTestForm({ ...testForm, exam_type: e.target.value, subject_name: '' })}
                className="w-full border border-gray-300 rounded-lg px-3 py-2"
              >
                {EXAM_TYPES.map((exam) => (
                  <option key={exam} value={exam}>{exam}</option>
                ))}
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Subject</label>
              <select
                value={testForm.subject_name}
                onChange={(e) => setTestForm({ ...testForm, subject_name: e.target.value })}
                className="w-full border border-gray-300 rounded-lg px-3 py-2"
                required
              >
                <option value="">Select Subject</option>
                {subjects
                  .filter((s) => s.exam_type === testForm.exam_type)
                  .map((s) => (
                    <option key={s.id} value={s.name}>{s.name}</option>
                  ))}
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Test Name (English)</label>
              <input
                type="text"
                value={testForm.name}
                onChange={(e) => setTestForm({ ...testForm, name: e.target.value })}
                className="w-full border border-gray-300 rounded-lg px-3 py-2"
                placeholder="e.g. WBCHSE Physics Full Test"
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Test Name (Bengali)</label>
              <input
                type="text"
                value={testForm.name_bengali}
                onChange={(e) => setTestForm({ ...testForm, name_bengali: e.target.value })}
                className="w-full border border-gray-300 rounded-lg px-3 py-2"
              />
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Total Questions <span className="text-xs text-gray-400">(auto-set)</span>
                </label>
                <input
                  type="number"
                  value={testForm.total_questions}
                  onChange={(e) => setTestForm({ ...testForm, total_questions: parseInt(e.target.value) })}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 bg-gray-50"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Duration (mins) <span className="text-xs text-gray-400">(auto-set)</span>
                </label>
                <input
                  type="number"
                  value={testForm.duration_minutes}
                  onChange={(e) => setTestForm({ ...testForm, duration_minutes: parseInt(e.target.value) })}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 bg-gray-50"
                />
              </div>
            </div>
            <div className="flex items-center gap-2">
              <input
                type="checkbox"
                id="test_premium"
                checked={testForm.is_premium}
                onChange={(e) => setTestForm({ ...testForm, is_premium: e.target.checked })}
                className="w-4 h-4"
              />
              <label htmlFor="test_premium" className="text-sm font-medium text-gray-700">
                Premium Test 👑
              </label>
            </div>
            <button
              type="submit"
              className="w-full bg-purple-600 text-white py-3 rounded-lg font-medium hover:bg-purple-700"
            >
              Create Test Series
            </button>
          </form>
        </div>
      )}

      {/* MANAGE VIEW (Add questions to test) */}
      {view === 'manage' && selectedTest && (
        <div>
          <div className="bg-purple-50 border border-purple-200 rounded-xl p-4 mb-6">
            <h2 className="font-bold text-purple-900">{selectedTest.name}</h2>
            <p className="text-sm text-purple-700">
              {testQuestions.length} / {selectedTest.total_questions} questions added
            </p>
            <div className="w-full bg-purple-200 rounded-full h-2 mt-2">
              <div
                className="bg-purple-600 h-2 rounded-full transition-all"
                style={{
                  width: `${Math.min((testQuestions.length / selectedTest.total_questions) * 100, 100)}%`,
                }}
              />
            </div>
          </div>

          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
            {/* ADD QUESTION FORM */}
            <div className="bg-white rounded-xl shadow-sm p-6 h-fit">
              <h3 className="text-lg font-bold text-gray-800 mb-4">Add Question to Test</h3>
              <form onSubmit={addQuestionToTest} className="space-y-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Question (English)</label>
                  <textarea
                    value={questionForm.question_english}
                    onChange={(e) => setQuestionForm({ ...questionForm, question_english: e.target.value })}
                    className="w-full border border-gray-300 rounded-lg px-3 py-2"
                    rows="2"
                    required
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Question (Bengali)</label>
                  <textarea
                    value={questionForm.question_bengali}
                    onChange={(e) => setQuestionForm({ ...questionForm, question_bengali: e.target.value })}
                    className="w-full border border-gray-300 rounded-lg px-3 py-2"
                    rows="2"
                  />
                </div>

                {['a', 'b', 'c', 'd'].map((opt) => (
                  <div key={opt} className="grid grid-cols-2 gap-2">
                    <div>
                      <label className="block text-sm font-medium text-gray-700 mb-1">
                        Option {opt.toUpperCase()} (Eng)
                      </label>
                      <input
                        type="text"
                        value={questionForm[`option_${opt}_english`]}
                        onChange={(e) => setQuestionForm({ ...questionForm, [`option_${opt}_english`]: e.target.value })}
                        className="w-full border border-gray-300 rounded-lg px-3 py-2"
                        required
                      />
                    </div>
                    <div>
                      <label className="block text-sm font-medium text-gray-700 mb-1">
                        Option {opt.toUpperCase()} (Ban)
                      </label>
                      <input
                        type="text"
                        value={questionForm[`option_${opt}_bengali`]}
                        onChange={(e) => setQuestionForm({ ...questionForm, [`option_${opt}_bengali`]: e.target.value })}
                        className="w-full border border-gray-300 rounded-lg px-3 py-2"
                      />
                    </div>
                  </div>
                ))}

                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Correct Option</label>
                    <select
                      value={questionForm.correct_option}
                      onChange={(e) => setQuestionForm({ ...questionForm, correct_option: e.target.value })}
                      className="w-full border border-gray-300 rounded-lg px-3 py-2"
                    >
                      <option value="A">A</option>
                      <option value="B">B</option>
                      <option value="C">C</option>
                      <option value="D">D</option>
                    </select>
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Difficulty</label>
                    <select
                      value={questionForm.difficulty}
                      onChange={(e) => setQuestionForm({ ...questionForm, difficulty: e.target.value })}
                      className="w-full border border-gray-300 rounded-lg px-3 py-2"
                    >
                      {DIFFICULTIES.map((d) => (
                        <option key={d} value={d} className="capitalize">{d}</option>
                      ))}
                    </select>
                  </div>
                </div>

                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Explanation (English)</label>
                  <textarea
                    value={questionForm.explanation_english}
                    onChange={(e) => setQuestionForm({ ...questionForm, explanation_english: e.target.value })}
                    className="w-full border border-gray-300 rounded-lg px-3 py-2"
                    rows="2"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Explanation (Bengali)</label>
                  <textarea
                    value={questionForm.explanation_bengali}
                    onChange={(e) => setQuestionForm({ ...questionForm, explanation_bengali: e.target.value })}
                    className="w-full border border-gray-300 rounded-lg px-3 py-2"
                    rows="2"
                  />
                </div>

                <button
                  type="submit"
                  className="w-full bg-green-600 text-white py-3 rounded-lg font-medium hover:bg-green-700"
                >
                  ➕ Add Question to Test
                </button>
              </form>
            </div>

            {/* QUESTIONS LIST */}
            <div className="bg-white rounded-xl shadow-sm p-6 h-fit">
              <h3 className="text-lg font-bold text-gray-800 mb-4">
                Test Questions ({testQuestions.length})
              </h3>
              <div className="space-y-3 max-h-[800px] overflow-y-auto">
                {testQuestions.map((q, idx) => (
                  <div key={q.id} className="p-4 bg-gray-50 rounded-lg">
                    <div className="flex items-start justify-between mb-2">
                      <span className="text-xs bg-gray-200 px-2 py-1 rounded-full">
                        Q{idx + 1} • {q.difficulty}
                      </span>
                      <button
                        onClick={() => deleteTestQuestion(q.id)}
                        className="text-red-500 hover:text-red-700 text-sm"
                      >
                        🗑️
                      </button>
                    </div>
                    <p className="text-sm font-medium text-gray-800">{q.question_english}</p>
                    <p className="text-xs text-gray-500 mt-1">Correct: {q.correct_option}</p>
                  </div>
                ))}
                {testQuestions.length === 0 && (
                  <p className="text-gray-400 text-center py-8">No questions added yet.</p>
                )}
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
