import StandardFormModalTemplate from "@/Theme/Components/ModalTemplates/StandardFormModalTemplate";
import FormTextInput from "@/Theme/Form/FormTextInput";
import FormSelectInput from "@/Theme/Form/FormSelectInput";
import { useForm } from "@inertiajs/react";
import { useState } from "react";

export default function PrestasiForm({
  action,
  loadOptions = null,
  row = null,
  closeForm,
}) {
  const form = useForm({
    nama_prestasi: row?.nama_prestasi ?? "",
    deskripsi: row?.deskripsi ?? "",
    // Sesuaikan dengan field lain yang diperlukan
  });

  const handleOnChange = (event) => {
    form.setData(event.target.name, event.target.value);
  };

  const titleHeader = () => {
    if (action === "create") return "Tambah Data Prestasi";
    else return `Ubah Data Prestasi`;
  };

  const submit = (e) => {
    e.preventDefault();

    if (action === "create") {
      if (window.confirm("Yakin untuk menambahkan Data Prestasi baru?")) {
        form.post(route("admin.prestasi.store"), {
          onSuccess: (response) => console.log(response),
          onError: (err) => console.log("err", err),
        });
      }
    }
  };

  return (
    <StandardFormModalTemplate
      title={titleHeader(action)}
      closeForm={closeForm}
      processing={form.processing}
      submit={submit}
    >
      <div className="flex flex-col gap-4 text-gray-700 dark:text-white">
        {/* NAMA PRESTASI */}
        <FormTextInput
          name="nama_prestasi"
          label={"NAMA PRESTASI"}
          value={form.data.nama_prestasi}
          onChange={handleOnChange}
          error={form.errors.nama_prestasi}
        />

        {/* DESKRIPSI */}
        <FormTextInput
          name="deskripsi"
          label={"DESKRIPSI"}
          value={form.data.deskripsi}
          onChange={handleOnChange}
          error={form.errors.deskripsi}
        />

        {/* Tambahan field lain sesuai kebutuhan */}
      </div>
    </StandardFormModalTemplate>
  );
}
