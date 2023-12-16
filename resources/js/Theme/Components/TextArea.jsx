import { useEffect } from 'react'

export default function TextArea({ id, value, ...props }) {
  function autoResizeTextarea() {
    const textarea = document.getElementById(id + '-auto-resize-textarea')
    textarea.style.height = 'auto' // Reset the height to auto
    textarea.style.height = `${textarea.scrollHeight}px` // Set the height to the scroll height
  }

  useEffect(() => {
    // Auto resize textarea rows depend on its value
    autoResizeTextarea()
  }, [])

  return (
    <textarea
      id={id + '-auto-resize-textarea'}
      cols="30"
      rows="2"
      className="mt-1 w-full cursor-text rounded-lg py-2 px-3 text-left shadow-md focus:outline-none focus:ring-2 sm:text-sm border-none 
    text-gray-700 dark:text-white
    bg-white dark:bg-black/40
    disabled:bg-gray-200 dark:disabled:bg-gray-700
    disabled:text-gray-700 dark:disabled:text-gray-300
    disabled:shadow-none
    "
      style={{
        backgroundClip: 'padding-box',
        resize: 'none', // Disable manual resizing
      }}
      onInput={autoResizeTextarea}
      value={value}
      {...props}
    />
  )
}
