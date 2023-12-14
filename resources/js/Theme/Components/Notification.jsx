import { FaRegBell } from 'react-icons/fa6'

export default function Notification() {
  const countNotification = 0
  return (
    <button
      type="button"
      className="flex-center text-gray-700 dark:text-white hover:text-primary dark:hover:text-primary"
    >
      <FaRegBell />
      <p className="text-xs font-bold">
        {countNotification > 0 ? countNotification : ''}
      </p>
    </button>
  )
}
