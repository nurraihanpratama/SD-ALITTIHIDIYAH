import Compressor from 'compressorjs'
import { useEffect, useRef, useState } from 'react'
import { FaUpload } from 'react-icons/fa6'
import Modal from './Modal'
import ModalCloseButton from './Buttons/ModalCloseButton'

export default function UploadImage({
  inputRef,
  currentImage,
  onUpload,
  onRemoveImage,
  withChange = true,
  withRemove = true,
  disabled = false,
}) {
  const [uploaded, setUploaded] = useState(currentImage)
  const [zoom, setZoom] = useState(false)

  const openFileDialog = () => {
    inputRef.current?.click()
  }

  const handleCompressedUpload = (image) => {
    new Compressor(image, {
      maxHeight: image.size > 500000 ? 800 : 0,
      maxWidth: image.size > 500000 ? 600 : 0,
      quality: 0.6, // 0.6 can also be used, but its not recommended to go below.
      success: (res) => {
        setUploaded(URL.createObjectURL(res))
        onUpload(res)
      },
    })
  }

  const imageUploaded = (e) => {
    const file = e.target.files[0]
    const allowedExtensions = ['.jpeg', '.jpg', '.png', '.webp']

    if (file) {
      const fileName = file.name
      const fileExtension = fileName.substring(fileName.lastIndexOf('.')).toLowerCase()
      if (!allowedExtensions.includes(fileExtension)) {
        alert('Invalid file type. Only JPEG, JPG, and PNG files are allowed.')
        return
      }

      // File is valid, continue with further processing...

      // Start compressing
      handleCompressedUpload(file)

      // setUploaded(URL.createObjectURL(file))
      // onUpload(file)
    }
  }

  const onClickRemoveImage = () => {
    setUploaded(null)
    inputRef.current.value = ''
    onRemoveImage()
  }

  return (
    <div className="min-w-[200px] mt-1 rounded-xl border-2 border-amber-500 border-dashed bg-white dark:bg-black/40">
      <div
        className={`${!uploaded && 'flex-center'} ${
          !inputRef.current?.value && 'border-2x'
        } hover:border-indigo-500 rounded-md cursor-pointer h-32 p-2`}
        onClick={() => openFileDialog()}
      >
        {inputRef.current?.value || uploaded ? (
          <div
            className="h-full"
            style={{
              backgroundImage: `url(${uploaded})`,
              backgroundPosition: 'center',
              backgroundSize: 'contain',
              backgroundRepeat: 'no-repeat',
            }}
          ></div>
        ) : (
          <div className="flex-center flex-col gap-0 p-2 text-gray-700 dark:text-white">
            <FaUpload />
            <p className="text-sm">Click to upload</p>
            <p className="text-xs">JPG, JPEG, PNG, WEBP (MAX 5MB)</p>
          </div>
        )}
      </div>

      <div className="flex-between border-t-2 border-dashed py-1 text-xs font-semibold text-gray-700 dark:text-white">
        {withChange && (
          <button
            type="button"
            className="w-full hover:text-blue-400"
            onClick={() => openFileDialog()}
          >
            {(inputRef.current?.value || uploaded) && 'Change'}
            {!inputRef.current?.value && !uploaded && 'Choose'}
          </button>
        )}
        {withRemove && (inputRef.current?.value || uploaded) && (
          <button
            type="button"
            className="w-full hover:text-rose-400"
            onClick={() => onClickRemoveImage()}
          >
            Remove
          </button>
        )}
        {(inputRef.current?.value || uploaded) && (
          <button
            type="button"
            className="w-full hover:text-green-400"
            onClick={() => setZoom(true)}
          >
            Zoom
          </button>
        )}
      </div>
      <input
        ref={inputRef}
        onChange={(e) => imageUploaded(e)}
        type="file"
        className="hidden"
        accept=".jpeg, .jpg, .png, .webp"
        multiple={false}
        disabled={disabled}
      />

      <Modal visible={zoom} setVisible={setZoom}>
        <div className="flex-center flex-col gap-4">
          <img src={uploaded} alt="zoom" width={300} />
          <div className="flex-center gap-2">
            <ModalCloseButton onClick={() => setZoom(false)} />
            <p className="font-bold text-red-500">Close</p>
          </div>
        </div>
      </Modal>
    </div>
  )
}
