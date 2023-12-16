import moment from 'moment/moment'
import Flatpickr from 'react-flatpickr'
import InputLabel from '../Components/InputLabel'
import InputError from '../Components/InputError'
import { BsCalendar2WeekFill } from 'react-icons/bs'

export default function FormDatePicker({
  name,
  label,
  defaultDate,
  value,
  handleOnChange,
  error,
  minDate,
  maxDate,
  nolabel = false,
  disabled = false,
  ...props
}) {
  const options = {
    altInput: true,
    altFormat: 'j M, Y',
    dateFormat: 'Y-m-d',
    defaultDate: defaultDate,
    prevArrow:
      '<svg class="fill-current" width="7" height="11" viewBox="0 0 7 11"><path d="M5.4 10.8l1.4-1.4-4-4 4-4L5.4 0 0 5.4z" /></svg>',
    nextArrow:
      '<svg class="fill-current" width="7" height="11" viewBox="0 0 7 11"><path d="M1.4 10.8L0 9.4l4-4-4-4L1.4 0l5.4 5.4z" /></svg>',
    // onReady: (selectedDates, dateStr, instance) => {
    // 	instance.element.value = dateStr.replace('to', '-');
    // },
    onChange: (selectedDates, dateStr, instance) => {
      handleOnChange(moment(selectedDates[0]).format('YYYY-MM-DD'))
    },
    minDate: minDate,
    maxDate: maxDate,
  }

  return (
    <div className="relactive w-full">
      {!nolabel && <InputLabel htmlFor={name} value={label} />}
      <Flatpickr
        id={name}
        name={name}
        className={`
				w-full cursor-pointer rounded-lg py-2 px-10 text-left shadow-md focus:outline-none focus:ring-2 sm:text-sm border-none 
      text-gray-700 dark:text-white
      bg-white dark:bg-black/40
      disabled:bg-gray-200 dark:disabled:bg-gray-700
      disabled:text-gray-700 dark:disabled:text-gray-300
      disabled:shadow-none ${!nolabel && 'mt-1'}
      `}
        style={{ zIndex: 9999992 }}
        options={options}
        disabled={disabled}
      />

      <BsCalendar2WeekFill className="absolute -mt-7 ml-3 text-gray-700 dark:text-white" />
      {error && <InputError message={error} className="mt-2" />}
    </div>
  )
}
