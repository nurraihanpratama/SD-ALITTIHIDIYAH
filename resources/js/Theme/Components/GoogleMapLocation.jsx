import usePlacesAutocomplete, { getGeocode, getLatLng } from 'use-places-autocomplete'
import { useState } from 'react'
import { GoogleMap, MarkerF, useLoadScript, InfoWindow } from '@react-google-maps/api'
import { DebounceInput } from 'react-debounce-input'
import { FiSearch } from 'react-icons/fi'
import { TbSettings } from 'react-icons/tb'

export default function GoogleMapLocation({ form }) {
  const [libraries] = useState(['places'])

  const apiKey = () => {
    // if (props.appEnv == 'production') {
    // 	return 'AIzaSyAqA5WIZOV7KB1giG8mWyO6qUY9wrixNpM'
    // }

    // return null;

    return import.meta.env.VITE_GOOGLE_MAPS_KEY
  }

  const { isLoaded, loadError } = useLoadScript({
    googleMapsApiKey: apiKey(),
    libraries,
  })

  if (!isLoaded)
    return (
      <div className="flex-center gap-2 text-gray-700 dark:text-white whitespace-nowrap">
        <TbSettings size={30} className="text-white animate-spin" />
        <p>Load Google Map... Please Wait</p>
      </div>
    )

  return <Map form={form} />
}

function Map({ form }) {
  const clickOnMap = (point) => {
    form.setData((data) => ({
      ...data,
      lat: point.latLng.lat(),
      lng: point.latLng.lng(),
    }))
  }

  return (
    <div className="w-full h-full">
      <PlacesAutoComplete form={form} />
      <div className="py-2"></div>
      <GoogleMap
        zoom={16}
        center={{ lat: form.data.lat, lng: form.data.lng }}
        mapContainerClassName="w-full rounded-xl h-96"
        onClick={(point) => clickOnMap(point)}
      >
        <MarkerF position={{ lat: form.data.lat, lng: form.data.lng }} />
      </GoogleMap>

      <div className="mt-1 flex items-center md:justify-between text-xs text-gray-700 dark:text-white">
        <span>Latitude: {form.data.lat}</span>
        <span>Longitude: {form.data.lng}</span>
      </div>
    </div>
  )
}

const PlacesAutoComplete = ({ form }) => {
  const {
    ready,
    value,
    setValue,
    clearSuggestions,
    suggestions: { status, data },
  } = usePlacesAutocomplete()

  const handleSelect = async (address) => {
    setValue(address, false)
    clearSuggestions()

    const results = await getGeocode({ address })
    const { lat, lng } = getLatLng(results[0])

    form.setData((data) => ({
      ...data,
      lat: lat,
      lng: lng,
    }))
  }

  return (
    <div className="relative">
      <DebounceInput
        type="search"
        className="w-full cursor-default rounded-lg py-2 pl-10 pr-4 text-left shadow-md focus:outline-none focus:ring-2 sm:text-sm border-none 
				text-gray-700 dark:text-white
				bg-white dark:bg-black/40
				disabled:bg-gray-200 dark:disabled:bg-gray-700
				disabled:text-gray-700 dark:disabled:text-gray-300
				disabled:shadow-none"
        placeholder="Cari alamat..."
        spellCheck={false}
        minLength={1}
        debounceTimeout={500}
        value={value}
        onChange={(e) => setValue(e.target.value)}
        disabled={!ready}
      />

      <button className="absolute inset-0 right-auto group cursor-default px-3">
        <FiSearch color="gray" />
      </button>

      {status === 'OK' && (
        <div className="absolute top-12 left-0 z-10 text-left p-4 rounded-lg shadow-xl mx-4 border-2 bg-white dark:bg-black/90 text-gray-700 dark:text-white border-indigo-900 overflow-hidden">
          {data.map(({ place_id, description }) => (
            <div
              key={place_id}
              onClick={() => handleSelect(description)}
              className="border-b py-1 px-2 hover:cursor-pointer border-gray-200 dark:border-gray-800 hover:text-amber-500"
            >
              {description}
            </div>
          ))}
        </div>
      )}
    </div>
  )
}
