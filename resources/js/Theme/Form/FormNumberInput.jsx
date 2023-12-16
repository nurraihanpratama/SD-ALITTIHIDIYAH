import InputError from '../Components/InputError'
import TextInput from '../Components/TextInput'
import InputLabel from '../Components/InputLabel'

export default function FormNumberInput({
  name,
  label,
  value,
  onChange,
  error,
  type = 'number',
  ismobile = false,
  disabled = false,
  nolabel = false,
  ...props
}) {
  return (
    <div className="block w-full">
      {!nolabel && <InputLabel htmlFor={name} value={label} />}
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
        min={0}
        step={1}
        {...props}
      />
      <InputError message={error} className="mt-2" />
    </div>
  )
}
