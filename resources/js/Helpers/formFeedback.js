import toast from 'react-hot-toast'

export const onSuccessFeedback = (response, callback) => {
  toast.success(response.props.flash)
  return callback
}

export const onErrorFeedback = (err) => {
  let message
  // console.log(err)
  if (Object.keys(err) == 0) {
    message = err[0]
  } else {
    message = 'Terjadi kesalahan input, mohon diperbaiki'
  }
  return toast.error(message)
}
