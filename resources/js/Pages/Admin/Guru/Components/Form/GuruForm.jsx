import { onErrorFeedback, onSuccessFeedback } from "@/Helpers/formFeedback";
import StandardFormModalTemplate from "@/Theme/Components/ModalTemplates/StandardFormModalTemplate";
import FormSelectInput from "@/Theme/Form/FormSelectInput";
import FormTextInput from "@/Theme/Form/FormTextInput";
import { useForm } from "@inertiajs/react";
import { useState } from "react";

export default function GuruForm({
    action,
    loadOptions = null,
    row = null,
    closeForm,
}) {
    const form = useForm({
        nama_guru: row?.nama_guru ?? "",
        ket_guru: row?.ket_guru ?? loadOptions.ket_guru[0].id,
        status_guru: row?.status?.id ?? loadOptions?.status[0].id,
    });

    const handleOnChange = (event) => {
        form.setData(event.target.name, event.target.value);
    };

    const titleHeader = () => {
        if (action === "create") return "Tambah Data Guru";
        else return `Ubah Data Guru`;
    };

    const submit = (e) => {
        e.preventDefault();

        if (action === "create") {
            if (confirm("Yakin untuk menambahkan Data Guru baru?")) {
                return form.post(route("admin.guru.store"), {
                    preserveScroll: true,
                    onSuccess: (response) =>
                        onSuccessFeedback(response, closeForm()),
                    onError: (err) => onErrorFeedback,
                });
            }
        }
        if (action === "update") {
            if (confirm("Yakin untuk mengubah Data Guru?")) {
                return form.patch(route("admin.guru.update", row.id_guru), {
                    preserveScroll: true,
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
                {/* NAMA GURU */}
                <FormTextInput
                    name="nama_guru"
                    label={"NAMA GURU"}
                    value={form.data.nama_guru}
                    onChange={handleOnChange}
                    error={form.errors.nama_guru}
                />

                {/* KETERANGAN GURU */}
                <FormSelectInput
                    name="ket_guru"
                    label={"KETERANGAN GURU"}
                    options={loadOptions?.ket_guru}
                    value={form.data.ket_guru}
                    onChange={(val) => form.setData("ket_guru", val.id)}
                    error={form.errors.ket_guru}
                />

                {/* STATUS GURU */}
                <FormSelectInput
                    name="status_guru"
                    label="STATUS GURU"
                    options={loadOptions?.status}
                    value={form.data.status_guru}
                    onChange={(val) => form.setData("status_guru", val.id)}
                    error={form.errors.status_guru}
                    isRequired={true}
                />
            </div>
        </StandardFormModalTemplate>
    );
}
