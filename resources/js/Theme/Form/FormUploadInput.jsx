import InputError from '../Components/InputError'
import InputLabel from '../Components/InputLabel'
import { useRef } from 'react'
import UploadImage from '../Components/UploadImage'

export default function FormUploadInput({
  id,
  label,
  onChange,
  errorMsg,
  currentImage,
  onRemoveImage,
  nolabel = false,
  withChange = true,
  withRemove = true,
  disabled = false,
  ...props
}) {
  const imageRef = useRef(null)
  return (
    <div className="w-full">
      {!nolabel && <InputLabel htmlFor={id} value={label} />}
      <UploadImage
        currentImage={currentImage}
        onUpload={(f) => onChange(f)}
        inputRef={imageRef}
        onRemoveImage={onRemoveImage}
        withChange={withChange}
        withRemove={withRemove}
        disabled={disabled}
      />
      <InputError message={errorMsg} className="mt-2 text-xs" />
    </div>
  )
}
