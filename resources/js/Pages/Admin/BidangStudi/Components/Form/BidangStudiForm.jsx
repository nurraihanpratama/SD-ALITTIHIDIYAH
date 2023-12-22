import { onErrorFeedback, onSuccessFeedback } from "@/Helpers/formFeedback";
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
        if (action === "update") return `Ubah Bidang Studi`;
    };

    const submit = (e) => {
        e.preventDefault();

        if (action === "create") {
            if (confirm("Yakin untuk menambahkan Bidang Studi baru?")) {
                return form.post(route("admin.bidang-studi.store"), {
                    onSuccess: (response) =>
                        onSuccessFeedback(response, closeForm()),
                    onError: (err) => onErrorFeedback,
                });
            }
        }
        if (action === "update") {
            if (
                confirm("Yakin untuk mengubah Bidang Studi?" + row.nama_mapel)
            ) {
                return form.patch(
                    route("admin.bidang-studi.update", row.id_mapel),
                    {
                        onSuccess: (response) =>
                            onSuccessFeedback(response, closeForm()),
                        onError: (err) => {
                            console.error(err);
                            onErrorFeedback(err);
                        },
                    }
                );
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
