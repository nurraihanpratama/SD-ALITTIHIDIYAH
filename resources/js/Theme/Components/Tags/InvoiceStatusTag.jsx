import Pill from '../Pill'

export default function InvoiceStatusTag({ invoice }) {
  return <Pill css={invoice.status.css} name={invoice.status.name} />
}
