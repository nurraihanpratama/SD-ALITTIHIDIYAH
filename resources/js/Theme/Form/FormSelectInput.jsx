import { Fragment } from 'react'
import InputError from '../Components/InputError'
import InputLabel from '../Components/InputLabel'
import SelectInput from '../Components/SelectInput'

export default function FormSelectInput({
  name,
  label,
  options,
  value,
  onChange,
  error,
  disabled = false,
  isRequired = false,
  type = 'text',
  nolabel = false,
  ...props
}) {
  return (
    <div className="block w-full">
      {!nolabel && (
        <InputLabel
          htmlFor={name}
          value={label}
          isRequired={isRequired}
          className="whitespace-nowrap"
        />
      )}
      <SelectInput
        options={options}
        value={value}
        onChange={onChange}
        disabled={disabled}
        {...props}
      />
      <InputError message={error} className="mt-2" />
    </div>
  )
}
