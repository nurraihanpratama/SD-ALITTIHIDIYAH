export default function WarningBox({ items, width = 'max-w-4xl' }) {
  return (
    <div className="w-full text-left px-4 py-2 mb-4 bg-yellow-700 text-white rounded-md">
      <p className={`${width}`}>Perhatian</p>
      {items.length > 0 && (
        <ul className={`${width} px-4`}>
          {items.map((item, i) => {
            return (
              <li key={i} className="list-disc">
                {item}
              </li>
            )
          })}
        </ul>
      )}
    </div>
  )
}
