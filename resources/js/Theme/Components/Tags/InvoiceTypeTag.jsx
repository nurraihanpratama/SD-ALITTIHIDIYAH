export default function InvoiceTypeTag({ type }) {
  return (
    <div>
      <p
        className={`uppercase text-xs whitespace-nowrap w-fit px-2 font-bold rounded-full ${type?.css}`}
      >
        {type?.name}
      </p>
    </div>
  )
}
