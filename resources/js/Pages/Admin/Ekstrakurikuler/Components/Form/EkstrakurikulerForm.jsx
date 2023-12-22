import { onErrorFeedback, onSuccessFeedback } from "@/Helpers/formFeedback";
import StandardFormModalTemplate from "@/Theme/Components/ModalTemplates/StandardFormModalTemplate";
import FormSelectInput from "@/Theme/Form/FormSelectInput";
import FormTextInput from "@/Theme/Form/FormTextInput";
import { useForm } from "@inertiajs/react";
import { useState } from "react";

export default function EkstrakurikulerForm({
    action,
    loadOptions = null,
    row = null,
    closeForm,
}) {
    const form = useForm({
        nama_ekstrakurikuler: row?.nama_ekstrakurikuler ?? "",
        pembina_ekskul: row?.pembina_ekskul ?? "",
        ikon: row?.ikon ?? "",
    });

    const handleOnChange = (event) => {
        form.setData(event.target.name, event.target.value);
    };

    const titleHeader = () => {
        if (action === "create") return "Tambah Data Ekstrakurikuler";
        else return `Ubah Data Ekstrakurikuler`;
    };

    const submit = (e) => {
        e.preventDefault();

        if (action === "create") {
            if (confirm("Yakin untuk menambahkan Data Ekstrakurikuler baru?")) {
                form.post(route("admin.ekstrakurikuler.store"), {
                    onSuccess: (response) =>
                        onSuccessFeedback(response, closeForm()),
                    onError: onErrorFeedback,
                });
            }
        }
        if (action === "update") {
            if (confirm("Yakin untuk Mengubah Data Ekstrakurikuler?")) {
                form.post(
                    route("admin.ekstrakurikuler.update", row.id_ekskul),
                    {
                        onSuccess: (response) =>
                            onSuccessFeedback(response, closeForm()),
                        onError: onErrorFeedback,
                    }
                );
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
                {/* NAMA EKSTRAKURIKULER */}
                <FormTextInput
                    name="nama_ekstrakurikuler"
                    label={"NAMA EKSTRAKURIKULER"}
                    value={form.data.nama_ekstrakurikuler}
                    onChange={handleOnChange}
                    error={form.errors.nama_ekstrakurikuler}
                />

                {/* PEMBINA */}
                <FormTextInput
                    name="pembina_ekskul"
                    label={"PEMBINA"}
                    value={form.data.pembina_ekskul}
                    onChange={handleOnChange}
                    error={form.errors.pembina_ekskul}
                />

                {/* IKON */}
                <FormTextInput
                    name="ikon"
                    label={"IKON"}
                    value={form.data.ikon}
                    onChange={handleOnChange}
                    error={form.errors.ikon}
                />
            </div>
        </StandardFormModalTemplate>
    );
}
