import React from "react";
import StandardFormModalTemplate from "@/Theme/Components/ModalTemplates/StandardFormModalTemplate";
import FormTextInput from "@/Theme/Form/FormTextInput";
import FormSelectInput from "@/Theme/Form/FormSelectInput";
import { useForm } from "@inertiajs/react";
import dayjs from "dayjs";
import { useState } from "react";
import FormUploadInput from "@/Theme/Form/FormUploadInput";
import { onErrorFeedback, onSuccessFeedback } from "@/Helpers/formFeedback";

export default function FasilitasForm({
    action,
    loadOptions = null,
    row = null,
    closeForm,
}) {
    const form = useForm({
        nama_fasilitas: row?.nama_fasilitas ?? "",
        foto_fasilitas: row?.foto_fasilitas ?? "", // Foto fasilitas disertakan di sini
        deskripsi: row?.deskripsi ?? "",
    });

    const handleOnChange = (event) => {
        form.setData(event.target.name, event.target.value);
    };

    const titleHeader = () => {
        if (action === "create") return "Tambah Data Fasilitas";
        else return `Ubah Data Fasilitas`;
    };

    const submit = (e) => {
        e.preventDefault();

        if (action === "create") {
            if (confirm("Yakin untuk menambahkan Data Fasilitas baru?")) {
                form.post(route("admin.fasilitas.store"), {
                    onSuccess: (response) =>
                        onSuccessFeedback(response, closeForm()),
                    onError: onErrorFeedback,
                });
            }
        }
        if (action === "update") {
            if (confirm("Yakin untuk mengubah Data Fasilitas?")) {
                form.post(route("admin.fasilitas.update", row.id_fasilitas), {
                    onSuccess: (response) =>
                        onSuccessFeedback(response, closeForm()),
                    onError: onErrorFeedback,
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
                {/* NAMA FASILITAS */}
                <FormTextInput
                    name="nama_fasilitas"
                    label={"NAMA FASILITAS"}
                    value={form.data.nama_fasilitas}
                    onChange={handleOnChange}
                    error={form.errors.nama_fasilitas}
                />

                {/* FOTO FASILITAS */}
                <FormUploadInput
                    id={"foto_fasilitas"}
                    label="Gambar Fasilitas"
                    onChange={(val) => form.setData("foto_fasilitas", val)}
                    onRemoveImage={() => form.setData("foto_fasilitas", null)}
                    withChange={action != "show"}
                    withRemove={action != "show"}
                    disabled={action == "show"}
                />
                {/* DESKRIPSI */}
                <FormTextInput
                    name="deskripsi"
                    label={"DESKRIPSI"}
                    value={form.data.deskripsi}
                    onChange={handleOnChange}
                    error={form.errors.deskripsi}
                />
            </div>
        </StandardFormModalTemplate>
    );
}
