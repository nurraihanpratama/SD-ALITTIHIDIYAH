import { onErrorFeedback, onSuccessFeedback } from "@/Helpers/formFeedback";
import StandardFormModalTemplate from "@/Theme/Components/ModalTemplates/StandardFormModalTemplate";
import FormDatePicker from "@/Theme/Form/FormDatePicker";
import FormSelectInput from "@/Theme/Form/FormSelectInput";
import FormTextInput from "@/Theme/Form/FormTextInput";
import { useForm } from "@inertiajs/react";
import dayjs from "dayjs";
import { useState } from "react";

export default function PegawaiForm({
    action,
    loadOptions = null,
    row = null,
    closeForm,
}) {
    console.log(row);
    const form = useForm({
        nama_pegawai: row?.nama_pegawai ?? "",
        jns_kelamin: row?.jk?.id ?? loadOptions?.jk[0].id,
        ket_pegawai: row?.ket_pegawai ?? "",
        status_pegawai: row?.status?.id ?? loadOptions?.status[0].id,
        // ... (existing form fields)
    });

    const handleOnChange = (event) => {
        form.setData(event.target.name, event.target.value);
    };

    const titleHeader = () => {
        if (action === "create") return "Tambah Data Pegawai";
        if (action === "update") return `Ubah Data Pegawai`;
    };

    const submit = (e) => {
        e.preventDefault();

        if (action === "create") {
            if (window.confirm("Yakin untuk menambahkan Data Pegawai baru?")) {
                form.post(route("admin.pegawai.store"), {
                    onSuccess: (response) =>
                        onSuccessFeedback(response, closeForm()),
                    onError: (err) => onErrorFeedback,
                });
            }
        }
        if (action === "update") {
            if (window.confirm("Yakin untuk menambahkan Data Pegawai baru?")) {
                form.patch(route("admin.pegawai.update", row.id_pegawai), {
                    onSuccess: (response) =>
                        onSuccessFeedback(response, closeForm()),
                    onError: (err) => onErrorFeedback,
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
                {/* Nama Pegawai */}
                <FormTextInput
                    name="nama_pegawai"
                    label={"Nama Pegawai"}
                    value={form.data.nama_pegawai}
                    onChange={handleOnChange}
                    error={form.errors.nama_pegawai}
                />

                {/* Jenis Kelamin */}
                <FormSelectInput
                    name="jns_kelamin"
                    label="Jenis Kelamin"
                    options={loadOptions?.jk}
                    value={form.data.jns_kelamin}
                    onChange={(val) => form.setData("jns_kelamin", val.id)}
                    error={form.errors.jns_kelamin}
                    isRequired={true}
                />

                {/* Keterangan Pegawai */}
                <FormTextInput
                    name="ket_pegawai"
                    label={"Keterangan Pegawai"}
                    value={form.data.ket_pegawai}
                    onChange={handleOnChange}
                    error={form.errors.ket_pegawai}
                />

                {/* Status Pegawai */}
                <FormSelectInput
                    name="status_pegawai"
                    label="Status Pegawai"
                    options={loadOptions?.status}
                    value={form.data.status_pegawai}
                    onChange={(val) => form.setData("status_pegawai", val.id)}
                    error={form.errors.status_pegawai}
                    isRequired={true}
                />
            </div>
        </StandardFormModalTemplate>
    );
}
