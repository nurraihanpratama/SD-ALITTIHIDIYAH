export default function CustomerStatusTag({ row }) {
  function getColor() {
    // TODO UNTUK SEMENTARA PAKAI OLD STATUS, NANTI DIPINDAHIN

    // PSB
    if (row.status?.id === 'psb') return 'bg-[#D5E5FA] text-[#3E669F]'

    // Aktif
    if (row.status?.id === 'active') return 'bg-[#CCF6E4] text-[#008D8A]'

    // Off Sementara
    if (row.status?.id === 'off_temporary') return 'bg-[#FFEAAC] text-[#AA8105]'

    // Putus Permanan
    if (row.status?.id === 'off_permanent') return 'bg-[#FDE6D8] text-[#D98038]'

    //  Putus Migrasi
    if (row.status?.id === 'migration') return 'bg-[#C2C4C5] text-[#343A40]'

    // Registrasi Ulang
    if (row.status?.id === 're_register') return 'bg-[#CBB9E4] text-[#632EAE]'

    // Registrasi
    if (row.status?.id === 'register') return 'bg-[#C2C4C5] text-[#343A40]'

    // // PSB
    // if (['psb', '0'].includes(row.status?.id)) return 'bg-[#D5E5FA] text-[#3E669F]'

    // // Aktif
    // if (['active', '1'].includes(row.status?.id)) return 'bg-[#CCF6E4] text-[#008D8A]'

    // // Off Sementara
    // if (['temporary', '2'].includes(row.status?.id)) return 'bg-[#FFEAAC] text-[#AA8105]'

    // // Putus Permanan
    // if (['permanent', '3'].includes(row.status?.id)) return 'bg-[#FDE6D8] text-[#D98038]'

    // //  Putus Migrasi
    // if (['migration', '4'].includes(row.status?.id)) return 'bg-[#C2C4C5] text-[#343A40]'

    // // Registrasi Ulang
    // if (['reg_ulang', '5'].includes(row.status?.id)) return 'bg-[#CBB9E4] text-[#632EAE]'

    // // Registrasi
    // if (['register', '6'].includes(row.status?.id)) return 'bg-[#C2C4C5] text-[#343A40]'
  }
  return (
    <div>
      <p
        className={`text-xs whitespace-nowrap w-fit mt-1 px-2 font-bold rounded-full ${getColor()}`}
      >
        {row.status?.name}
      </p>
    </div>
  )
}
