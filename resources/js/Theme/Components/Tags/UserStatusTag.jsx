export default function UserStatusTag({ row }) {
  function getColor() {
    // BELUM BAYAR
    if (row.status == 'nonactive') return 'bg-[#FDE6D8] text-[#D98038]'

    // SUDAH BAYAR
    if (row.status == 'active') return 'bg-[#CCF6E4] text-[#008D8A]'
  }
  return (
    <div>
      <p
        className={`uppercase text-xs whitespace-nowrap w-fit px-2 font-bold rounded-full ${getColor()}`}
      >
        {row.rstatus?.name}
      </p>
    </div>
  )
}
