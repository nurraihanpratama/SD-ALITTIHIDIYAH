import StandardFormModalTemplate from "@/Theme/Components/ModalTemplates/StandardFormModalTemplate";
import FormTextInput from "@/Theme/Form/FormTextInput";
import { useForm } from "@inertiajs/react";
import { useState } from "react";

export default function BidangStudiForm({
  action,
  loadOptions = null,
  row = null,
  closeForm,
}) {
  const form = useForm({
    nama_mapel: row?.nama_mapel ?? "", // Add the new field for Nama Bidang Studi
    // ... (existing form fields)
  });

  const handleOnChange = (event) => {
    form.setData(event.target.name, event.target.value);
  };

  const titleHeader = () => {
    if (action === "create") return "Tambah Bidang Studi";
    else return `Ubah Bidang Studi`;
  };

  const submit = (e) => {
    e.preventDefault();

    if (action === "create") {
      if (window.confirm("Yakin untuk menambahkan Bidang Studi baru?")) {
        form.post(route("admin.bidangstudi.store"), {
          onSuccess: (response) => console.log(response),
          onError: (err) => console.log("err", err),
        });
      }
    }
    // ... (handle update case if needed)
  };

  return (
    <StandardFormModalTemplate
      title={titleHeader(action)}
      closeForm={closeForm}
      processing={form.processing}
      submit={submit}
    >
      <div className="flex flex-col gap-4 text-gray-700 dark:text-white">
        {/* Nama Bidang Studi */}
        <FormTextInput
          name="nama_mapel"
          label={"Nama Bidang Studi"}
          value={form.data.nama_mapel}
          onChange={handleOnChange}
          error={form.errors.nama_mapel}
        />

        {/* ... (existing form fields) */}
      </div>
    </StandardFormModalTemplate>
  );
}
