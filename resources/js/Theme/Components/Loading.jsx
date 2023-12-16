import { TbSettings } from 'react-icons/tb'

export default function Loading({ text = 'Processing... Please Wait' }) {
  return (
    <div className="flex-center gap-2 text-gray-700 dark:text-white whitespace-nowrap">
      <TbSettings size={30} className="text-white animate-spin" />
      <p>{text}</p>
    </div>
  )
}
