import { Link, usePage } from '@inertiajs/react'
import { MdClose } from 'react-icons/md'

export default function ContentHeader({ title, rightSide, forExternalAccess = false }) {
  const { auth } = usePage().props

  return (
    <div className="rounded-md shadow-lg overflow-hidden">
      <div className="p-2 flex-between pr-6 bg-white dark:bg-[#162231]">
        <div className="flex-start gap-2">
          {!forExternalAccess && (
            <Link
              href={route('customer.index', auth?.user?.current_team.slug)}
              className="inline-block px-2 py-2 active:translate-y-1 font-medium border rounded-full shadow-md 
                bg-gray-300 dark:bg-gray-900
                text-gray-700 dark:text-white
                border-none
                hover:bg-gray-300 "
            >
              <MdClose />
            </Link>
          )}
          <p className="font-bold text-xl text-gray-700 dark:text-white">{title}</p>
        </div>
        {rightSide}
      </div>
    </div>
  )
}
