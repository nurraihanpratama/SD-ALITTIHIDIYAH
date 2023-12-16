import ThemeContext from '@/Context/ThemeContext'
import { useContext } from 'react'
import ReactSelect from 'react-select'
import makeAnimated from 'react-select/animated'

export default function ReactSelectOptions({ data, onChange, currentSelected }) {
  const { theme, updateTheme } = useContext(ThemeContext)

  const animatedComponents = makeAnimated()

  const handleChange = (items) => {
    const map = items.map(({ id }) => id)
    const query = items ? map.join('-') : null
    onChange(query)
  }

  function getDefaultValue() {
    if (currentSelected) {
      const arraySelected = currentSelected.split('-').map((item) => {
        return !isNaN(item) ? Number(item) : item
      })
      return data.filter((item) => arraySelected.includes(item.id))
    }
  }
  if (data.length > 0)
    return (
      <ReactSelect
        isMulti={true}
        options={data}
        defaultValue={() => getDefaultValue()}
        onChange={handleChange}
        closeMenuOnSelect={false}
        components={animatedComponents}
        className={'w-full shadow-md rounded-lg bg-wxhite'}
        getOptionLabel={(x) => x.name}
        getOptionValue={(x) => x.id}
        placeholder="Select All"
        styles={{
          control: (baseStyles, state) => ({
            ...baseStyles,
            // borderColor: state.isFocused ? 'blue' : 'red',
            borderColor: theme.darkMode ? '#232E3C' : '#fff',
            backgroundColor: theme.darkMode ? 'rgb(0 0 0 / 0.4)' : '#fff',
            borderRadius: '0.5rem',
          }),
        }}
      />
    )
}
