import { Fragment, useState } from 'react'
import { BsImage } from 'react-icons/bs'
import { fDate, moneyFormatter } from '@/Helpers/helper'
import MapSection from '@/Pages/Public/CustomerDetail/Components/MapSection'
import { team } from '@/Helpers/getTeamSlug'
import axios from 'axios'
import ModalCloseButton from '../Buttons/ModalCloseButton'
import Modal from '../Modal'
import ProcessingLoader from '../ProcessingLoader'

export default function MoreCustomerDetail({ customer_id }) {
  const [processing, setProcessing] = useState(false)
  const [visible, setVisible] = useState(false)
  const [moreCustomerData, setMoreCustomerData] = useState(null)

  const team_slug = team().slug

  function onClickMoreDetail() {
    setProcessing(true)

    const url = route('customer.show', [team_slug, customer_id])

    axios
      .get(url)
      .then((response) => {
        setMoreCustomerData(response.data.customer)
        setVisible(true)
        setProcessing(false)
      })
      .catch((error) => {
        setProcessing(false)
        alert('Terjadi masalah, tidak dapat membuka form')
      })
  }

  return (
    <Fragment>
      <button
        type="button"
        className="hover:underline text-xs text-blue-600"
        onClick={() => onClickMoreDetail()}
      >
        More details
      </button>

      <Modal visible={processing} setVisible={setProcessing} noescape>
        <ProcessingLoader visible={processing} />
      </Modal>

      <Modal visible={visible} setVisible={setVisible}>
        <div className="rounded-t-xl px-4 py-2 flex-between gap-6 bg-white dark:bg-[#162231]">
          <p className="font-bold text-lg text-start text-gray-700 dark:text-white">
            More Customer Details
          </p>
          <ModalCloseButton onClick={() => setVisible(false)} disabled={processing} />
        </div>
        {moreCustomerData && <Detail customer={moreCustomerData} />}
      </Modal>
    </Fragment>
  )
}

const Detail = ({ customer }) => {
  return (
    <div className="rounded-b-xl p-4 bg-[#F9FAFD] dark:bg-[#121E2D]">
      <table className="w-full text-sm text-gray-700 dark:text-white">
        <tbody className="divide-y dark:divide-stone-700">
          <TableTrow label="ID" value={customer.reg_no} />
          <TableTrow label="Nama" value={customer.name} />
          <TableTrow label="Tgl.&nbsp;Registrasi" value={fDate(customer.reg_date)} />
          <TableTrow label="Contact" value={customer.contact} />
          <TableTrow label="Contact&nbsp;#2" value={customer.mobile2} />
          <TableTrow label="No.&nbsp;Identitas" value={customer.identity_no} />
          <TableTrow label="Alamat" value={customer.address} />
          <TableTrow
            label="TTL"
            value={customer.birth_place + ', ' + fDate(customer.dob)}
          />
          <TableTrow label="Deposit" value={moneyFormatter(customer.deposit ?? 0)} />

          <TableTrow label="Sts.Tempat" value={customer.cust_place_ownership} />

          <TableTrow label="No.&nbsp;Rek.Listrik" value={customer.electricity_bill} />
          <TableTrow label="Pekerjaan" value={customer.job} />

          <TableTrow label="Tipe" value={customer.type.name} />
          {/* company_name */}

          {customer.cust_type == 'corporate' && (
            <Fragment>
              <TableTrow label="Nama&nbsp;PT" value={customer.company_name} />
              <TableTrow label="Alamat&nbsp;PT" value={customer.company_address} />
              <TableTrow label="Manajer&nbsp;PT" value={customer.company_manager} />
              <TableTrow label="No.Kontak&nbsp;PT" value={customer.company_phone} />
            </Fragment>
          )}

          <TableTrow label="Team" value={customer.team.name} />
        </tbody>
      </table>
      <div className="my-4">
        {customer.lat ? (
          <MapSection customer={customer} />
        ) : (
          <p className="text-lg px-4 text-gray-700 dark:text-white">
            Belum ditentukan titik lokasi pelanggan ini
          </p>
        )}
      </div>
    </div>
  )
}

const TableTrow = ({ label, value }) => {
  return (
    <tr>
      <td className="text-end">{label}</td>
      <td className="text-center px-2">:</td>
      <td className="text-start">{value}</td>
    </tr>
  )
}
