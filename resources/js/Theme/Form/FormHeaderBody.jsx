export default function FormHeaderBody({ label }) {
  return (
    <div className="bg-[#F9FAFD] dark:bg-[#121E2D]">
      <p
        className="py-2 text-xs italic font-bold text-left px-4 
      text-white 
      bg-teal-800"
      >
        {label}
      </p>
    </div>
  )
}
