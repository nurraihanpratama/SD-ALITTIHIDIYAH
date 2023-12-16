import { TbSettings } from 'react-icons/tb'

export default function LoadingText() {
  return (
    <div className="flex-center gap-4 py-4 text-lg text-gray-700 dark:text-white">
      <TbSettings size={30} className="animate-spin " />
      <p>Processing... Please Wait</p>
    </div>
  )
}
