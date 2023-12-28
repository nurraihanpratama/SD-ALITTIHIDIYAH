export default function ModalOpenButton({
  type = 'button',
  onClick,
  disabled = false,
  children,
}) {
  return (
    <button
      type={type}
      className="flex-center gap-2 font-semibold px-4 py-1 rounded-md button-shadow border
      text-gray-600 dark:text-white 
      bg-white dark:bg-[#0B1727] 
      dark:border-white
      hover:bg-green-500 hover:text-white 
      hover:dark:bg-green-500 hover:dark:text-white
      disabled:dark:bg-gray-500
      "
      onClick={onClick}
      disabled={disabled}
    >
      {children}
    </button>
  )
}
