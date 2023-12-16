export default function DeviceNotReturnBackWarningBox({ subscription, devices }) {
  if (subscription) {
    if (subscription.deleted_at) {
      if (devices?.length > 0) {
        if (devices.some((d) => d.pivot.returned_at == null)) {
          return <p className="animate-pulse text-red-500">Ada alat belum kembali</p>
        }
      }
    }
  }
}
