import InputError from '../Components/InputError'
import TextInput from '../Components/TextInput'
import InputLabel from '../Components/InputLabel'
import { FaEye, FaEyeSlash } from 'react-icons/fa'
import { useState } from 'react'

export default function FormPasswordInput({
  name,
  label,
  value,
  onChange,
  error,
  type = 'password',
  ismobile = false,
  disabled = false,
  ...props
}) {
  const [inputType, setInputType] = useState(type)
  return (
    <div className="block">
      <div className="flex-between pr-4">
        <InputLabel htmlFor={name} value={label} />
        <button
          type="button"
          className="block w-fit font-medium text-sm text-gray-700 dark:text-white hover:text-amber-600 dark:hover:text-amber-600"
          onClick={
            () => setInputType('text')
            // setInputType(inputType == 'password' ? 'text' : 'password')
          }
        >
          {inputType == 'password' && <FaEye />}
          {inputType == 'text' && <FaEyeSlash />}
        </button>
      </div>
      <TextInput
        id={name}
        type={inputType}
        name={name}
        value={value}
        onChange={onChange}
        spellCheck={false}
        ismobile={ismobile}
        disabled={disabled}
        {...props}
      />
      <InputError message={error} className="mt-2" />
    </div>
  )
}
