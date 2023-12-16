export default function SubscriptionStatusTag({ status }) {
  return (
    <p
      className={`uppercase text-xs whitespace-nowrap w-fit px-2 font-bold rounded-full ${status?.css}`}
    >
      {status?.name}
    </p>
  )
}
