import { Fragment, useState } from 'react'
import { FaRegEye, FaRegEyeSlash } from 'react-icons/fa6'

export default function TextInput({
  type = 'text',
  ismobile = false,
  disabled = false,
  nolabel = false,
  secure = false,
  className,
  name,
  ...props
}) {
  const [typex, setTypex] = useState(type)

  const handleKeyPress = (e) => {
    if (ismobile) {
      if (!/[0-9]/.test(e.key)) {
        // /^\d+$/ (ini regex untuk disallow tanda titik maupun koma di angka)
        e.preventDefault()
      }
    }
  }

  function changeType() {
    return setTypex(typex == 'password' ? 'text' : 'password')
  }

  return (
    <Fragment>
      <input
        type={typex}
        name={name}
        className={`w-full cursor-text rounded-lg py-2 px-3 text-left shadow-md focus:outline-none focus:ring-2 sm:text-sm border-none 
      text-gray-700 dark:text-white
      bg-white dark:bg-black/40
      disabled:bg-gray-200 dark:disabled:bg-gray-700
      disabled:text-gray-700 dark:disabled:text-gray-300
      disabled:shadow-none disabled:cursor-not-allowed 
      ${className} ${!nolabel && 'mt-1'} `}
        // className="w-full text-[1rem] leading-[1.5] px-[1rem] py-[0.3125rem] appearance-none rounded-[0.2rem] border border-gray-300 mt-1"
        style={{
          backgroundClip: 'padding-box',
        }}
        onKeyPress={handleKeyPress}
        disabled={disabled}
        {...props}
      />
      {secure && (
        <button
          type="button"
          className="absolute pt-3 right-7 text-gray-700 dark:text-white"
          onClick={() => changeType()}
        >
          {typex == 'password' ? <FaRegEye /> : <FaRegEyeSlash />}
        </button>
      )}
    </Fragment>
  )
}
