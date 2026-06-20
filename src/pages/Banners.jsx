import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'

const EXAM_TYPES = ['All Exams', 'WBCHSE', 'NEET', 'JEE Mains', 'WBJEE']

export default function Banners() {
  const [banners, setBanners] = useState([])
  const [loading, setLoading] = useState(true)
  const [uploading, setUploading] = useState(false)
  const [message, setMessage] = useState('')

  const initialForm = {
    title: '',
    title_bengali: '',
    description: '',
    description_bengali: '',
    link_url: '',
    exam_type: '',
    is_active: true,
  }
  const [form, setForm] = useState(initialForm)
  const [imageFile, setImageFile] = useState(null)
  const [imagePreview, setImagePreview] = useState(null)

  useEffect(() => {
    fetchBanners()
  }, [])

  async function fetchBanners() {
    setLoading(true)
    const { data } = await supabase
      .from('banners')
      .select('*')
      .order('order_index', { ascending: true })
    setBanners(data || [])
    setLoading(false)
  }

  function handleImageChange(e) {
    const file = e.target.files[0]
    if (file) {
      setImageFile(file)
      setImagePreview(URL.createObjectURL(file))
    }
  }

  async function handleSubmit(e) {
    e.preventDefault()

    if (!imageFile) {
      setMessage('❌ Please select a banner image')
      setTimeout(() => setMessage(''), 3000)
      return
    }

    setUploading(true)

    try {
      // Upload image to Supabase Storage
      const fileExt = imageFile.name.split('.').pop()
      const fileName = `banner-${Date.now()}.${fileExt}`
      const filePath = `banners/${fileName}`

      const { error: uploadError } = await supabase.storage
        .from('banners')
        .upload(filePath, imageFile)

      if (uploadError) throw uploadError

      // Get public URL
      const { data: urlData } = supabase.storage
        .from('banners')
        .getPublicUrl(filePath)

      // Insert banner record
      const payload = {
        ...form,
        exam_type: form.exam_type === '' ? null : form.exam_type,
        image_url: urlData.publicUrl,
        order_index: banners.length,
      }

      const { error: insertError } = await supabase.from('banners').insert([payload])

      if (insertError) throw insertError

      setMessage('✅ Banner uploaded successfully!')
      setForm(initialForm)
      setImageFile(null)
      setImagePreview(null)
      fetchBanners()
    } catch (error) {
      setMessage(`❌ Error: ${error.message}`)
    } finally {
      setUploading(false)
      setTimeout(() => setMessage(''), 3000)
    }
  }

  async function toggleActive(banner) {
    const { error } = await supabase
      .from('banners')
      .update({ is_active: !banner.is_active })
      .eq('id', banner.id)
    if (!error) fetchBanners()
  }

  async function deleteBanner(banner) {
    if (!window.confirm('Delete this banner?')) return

    // Delete image from storage
    if (banner.image_url) {
      const path = banner.image_url.split('/banners/').pop()
      await supabase.storage.from('banners').remove([`banners/${path}`])
    }

    const { error } = await supabase.from('banners').delete().eq('id', banner.id)
    if (error) {
      setMessage(`❌ Error: ${error.message}`)
    } else {
      setMessage('✅ Banner deleted!')
      fetchBanners()
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
      <div className="mb-8">
        <h1 className="text-3xl font-bold text-gray-800">Banner Management</h1>
        <p className="text-gray-500 mt-1">Upload and manage app banners</p>
      </div>

      {message && (
        <div className={`mb-4 p-4 rounded-lg ${message.includes('❌') ? 'bg-red-50 text-red-700' : 'bg-green-50 text-green-700'}`}>
          {message}
        </div>
      )}

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* UPLOAD FORM */}
        <div className="bg-white rounded-xl shadow-sm p-6 h-fit">
          <h2 className="text-xl font-bold text-gray-800 mb-4">Upload New Banner</h2>
          <form onSubmit={handleSubmit} className="space-y-4">
            {/* Image Upload */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Banner Image</label>
              <input
                type="file"
                accept="image/*"
                onChange={handleImageChange}
                className="w-full border border-gray-300 rounded-lg px-3 py-2"
                required
              />
              <p className="text-xs text-gray-400 mt-1">Recommended: 1200x400px, JPG or PNG</p>
              {imagePreview && (
                <img
                  src={imagePreview}
                  alt="Preview"
                  className="mt-3 w-full h-40 object-cover rounded-lg border"
                />
              )}
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Title (English)</label>
              <input
                type="text"
                value={form.title}
                onChange={(e) => setForm({ ...form, title: e.target.value })}
                className="w-full border border-gray-300 rounded-lg px-3 py-2"
                placeholder="e.g. New Answer Keys Released!"
                required
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Title (Bengali)</label>
              <input
                type="text"
                value={form.title_bengali}
                onChange={(e) => setForm({ ...form, title_bengali: e.target.value })}
                className="w-full border border-gray-300 rounded-lg px-3 py-2"
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Description (English)</label>
              <textarea
                value={form.description}
                onChange={(e) => setForm({ ...form, description: e.target.value })}
                className="w-full border border-gray-300 rounded-lg px-3 py-2"
                rows="2"
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Description (Bengali)</label>
              <textarea
                value={form.description_bengali}
                onChange={(e) => setForm({ ...form, description_bengali: e.target.value })}
                className="w-full border border-gray-300 rounded-lg px-3 py-2"
                rows="2"
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Link URL (optional)</label>
              <input
                type="text"
                value={form.link_url}
                onChange={(e) => setForm({ ...form, link_url: e.target.value })}
                className="w-full border border-gray-300 rounded-lg px-3 py-2"
                placeholder="https://..."
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Show For Exam</label>
              <select
                value={form.exam_type}
                onChange={(e) => setForm({ ...form, exam_type: e.target.value })}
                className="w-full border border-gray-300 rounded-lg px-3 py-2"
              >
                {EXAM_TYPES.map((exam) => (
                  <option key={exam} value={exam === 'All Exams' ? '' : exam}>
                    {exam}
                  </option>
                ))}
              </select>
            </div>

            <div className="flex items-center gap-2">
              <input
                type="checkbox"
                id="is_active"
                checked={form.is_active}
                onChange={(e) => setForm({ ...form, is_active: e.target.checked })}
                className="w-4 h-4"
              />
              <label htmlFor="is_active" className="text-sm font-medium text-gray-700">
                Active (visible in app)
              </label>
            </div>

            <button
              type="submit"
              disabled={uploading}
              className="w-full bg-purple-600 text-white py-3 rounded-lg font-medium hover:bg-purple-700 disabled:opacity-50"
            >
              {uploading ? '⏳ Uploading...' : '🖼️ Upload Banner'}
            </button>
          </form>
        </div>

        {/* BANNERS LIST */}
        <div className="bg-white rounded-xl shadow-sm p-6 h-fit">
          <h2 className="text-xl font-bold text-gray-800 mb-4">Banners ({banners.length})</h2>
          <div className="space-y-4 max-h-[800px] overflow-y-auto">
            {banners.map((banner) => (
              <div key={banner.id} className="border border-gray-200 rounded-lg overflow-hidden">
                {banner.image_url && (
                  <img
                    src={banner.image_url}
                    alt={banner.title}
                    className="w-full h-32 object-cover"
                  />
                )}
                <div className="p-3">
                  <div className="flex items-start justify-between mb-2">
                    <h3 className="font-medium text-gray-800 text-sm">{banner.title}</h3>
                    <span
                      className={`text-xs px-2 py-1 rounded-full ${
                        banner.is_active
                          ? 'bg-green-100 text-green-700'
                          : 'bg-gray-100 text-gray-500'
                      }`}
                    >
                      {banner.is_active ? 'Active' : 'Inactive'}
                    </span>
                  </div>
                  <p className="text-xs text-gray-500 mb-3">
                    {banner.exam_type || 'All Exams'}
                  </p>
                  <div className="flex gap-2">
                    <button
                      onClick={() => toggleActive(banner)}
                      className="flex-1 bg-blue-50 text-blue-700 py-1.5 rounded-lg text-xs font-medium hover:bg-blue-100"
                    >
                      {banner.is_active ? 'Deactivate' : 'Activate'}
                    </button>
                    <button
                      onClick={() => deleteBanner(banner)}
                      className="px-3 bg-red-50 text-red-600 py-1.5 rounded-lg text-xs hover:bg-red-100"
                    >
                      🗑️
                    </button>
                  </div>
                </div>
              </div>
            ))}
            {banners.length === 0 && (
              <p className="text-gray-400 text-center py-8">No banners yet. Upload your first one!</p>
            )}
          </div>
        </div>
      </div>
    </div>
  )
}
