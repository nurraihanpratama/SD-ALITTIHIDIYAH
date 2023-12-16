export default function Pill({ css, name }) {
  return (
    <p
      className={`uppercase text-xs whitespace-nowrap w-fit px-2 font-bold rounded-full ${css}`}
    >
      {name}
    </p>
  )
}
