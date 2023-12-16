import { useState } from 'react'

export default function ResponsiveMeasurement() {
  const [widthX, setWidthX] = useState(window.innerWidth)

  function handleResize() {
    const windowWidth = window.innerWidth
    setWidthX(windowWidth)
  }

  window.addEventListener('resize', handleResize)

  return (
    <div className="text-3xl text-gray-700 dark:text-white">
      <p className="sm:hidden md:hidden lg:hidden xl:hidden 2xl:hidden">XS</p>
      <p className="hidden xs:hidden sm:block md:hidden lg:hidden xl:hidden 2xl:hidden">
        SM
      </p>
      <p className="hidden sm:hidden md:block lg:hidden xl:hidden 2xl:hidden">MD</p>
      <p className="hidden sm:hidden md:hidden lg:block xl:hidden 2xl:hidden">LG</p>
      <p className="hidden sm:hidden md:hidden lg:hidden xl:block 2xl:hidden">XL</p>
      <p className="hidden sm:hidden md:hidden lg:hidden xl:hidden 2xl:block">2XL</p>
      <p>{widthX}</p>
    </div>
  )
}
