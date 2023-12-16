export default function Tag({ color, label }) {
  return (
    <div className="flex-center">
      <p className={`w-fit whitespace-nowrap text-xs px-2 rounded-sm ${color}`}>
        {label}
      </p>
    </div>
  )
}
