import InputError from '../Components/InputError'
import TextInput from '../Components/TextInput'
import InputLabel from '../Components/InputLabel'
import SelectInput from '../Components/SelectInput'

export default function FormMobileInput({
  name,
  label,
  value,
  onChange,
  error,
  options,
  codeValue,
  onChangeCode,
  disabled,
  type = 'text',
  ismobile = true,
  ...props
}) {
  return (
    <div className="fxlex-start flex-xcol ">
      <InputLabel htmlFor={name} value={label} />
      <div className="flex-between gap-2">
        <div className="w-20 flex-none">
          <SelectInput
            options={options}
            value={codeValue}
            onChange={onChangeCode}
            disabled={disabled}
            label="code"
          />
        </div>
        <div className="flex-grow">
          <TextInput
            id={name}
            type={type}
            name={name}
            value={value}
            onChange={onChange}
            ismobile={ismobile}
            disabled={disabled}
            {...props}
          />
        </div>
      </div>
      <InputError message={error} className="mt-2" />
    </div>
  )
}
