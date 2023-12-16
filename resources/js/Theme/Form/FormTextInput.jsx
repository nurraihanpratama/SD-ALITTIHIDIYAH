import InputError from '../Components/InputError'
import TextInput from '../Components/TextInput'
import InputLabel from '../Components/InputLabel'

export default function FormTextInput({
  name,
  label,
  value,
  onChange,
  error,
  type = 'text',
  ismobile = false,
  disabled = false,
  nolabel = false,
  secure = false,
  isRequired = false,
  ...props
}) {
  return (
    <div className="block w-full">
      {!nolabel && <InputLabel htmlFor={name} value={label} isRequired={isRequired} />}
      <TextInput
        id={name}
        type={type}
        name={name}
        value={value}
        onChange={onChange}
        spellCheck={false}
        ismobile={ismobile}
        nolabel={nolabel}
        disabled={disabled}
        secure={secure}
        {...props}
      />
      <InputError message={error} className="mt-2" />
    </div>
  )
}
