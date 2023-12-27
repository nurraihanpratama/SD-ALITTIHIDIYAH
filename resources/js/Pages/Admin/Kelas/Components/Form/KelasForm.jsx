import StandardFormModalTemplate from "@/Theme/Components/ModalTemplates/StandardFormModalTemplate";
import FormTextInput from "@/Theme/Form/FormTextInput";
import FormSelectInput from "@/Theme/Form/FormSelectInput";
import { useForm } from "@inertiajs/react";
import { useState, useEffect } from "react";
import { onErrorFeedback, onSuccessFeedback } from "@/Helpers/formFeedback";

export default function KelasForm({
    action,
    loadOptions = null,
    row = null,
    closeForm,
}) {
    console.log(loadOptions);
    const form = useForm({
        tahun_ajaran_id: loadOptions.tahun_ajaran[0].id,
        tingkat_kelas: row?.tingkat_kelas ?? "",
        nama: row?.nama ?? "",
        wali_kelas: row?.guru.id_guru ?? loadOptions?.gurus[0]?.id,
    });

    const handleOnChange = (event) => {
        form.setData(event.target.name, event.target.value);
    };

    const titleHeader = () => {
        if (action === "create") return "Tambah Data Kelas";
        if (action === "update") return `Ubah Data Kelas`;
    };

    const submit = (e) => {
        e.preventDefault();

        if (action === "create") {
            if (confirm("Yakin untuk menambahkan Data Kelas baru?")) {
                return form.post(route("admin.kelas.store"), {
                    preserveScroll: true,
                    onSuccess: (response) =>
                        onSuccessFeedback(response, closeForm()),
                    onError: (err) => {
                        onErrorFeedback;
                        // closeForm();
                    },
                });
            }
        }
        if (action === "update") {
            if (confirm("Yakin untuk mengubah Data Kelas?")) {
                return form.patch(route("admin.kelas.update", row.id_kelas), {
                    preserveScroll: true,
                    onSuccess: (response) =>
                        onSuccessFeedback(response, closeForm()),
                    onError: (err) => {
                        onErrorFeedback;
                        // closeForm();
                    },
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
                {/* NAMA KELAS */}
                <FormSelectInput
                    name="tahun_ajaran_id"
                    label={"TAHUN AJARAN"}
                    value={form.data.tahun_ajaran_id}
                    options={loadOptions?.tahun_ajaran}
                    onChange={handleOnChange}
                    idKey="id"
                    nameKey="tahun_ajaran"
                    disabled
                    error={form.errors.tahun_ajaran_id}
                />

                <FormTextInput
                    name="tingkat_kelas"
                    type="number"
                    min={1}
                    max={9}
                    label={"TINGKAT KELAS"}
                    value={form.data.tingkat_kelas}
                    onChange={handleOnChange}
                    error={form.errors.tingkat_kelas}
                />
                <FormTextInput
                    name="nama"
                    label={"NAMA KELAS"}
                    value={form.data.nama}
                    onChange={handleOnChange}
                    error={form.errors.nama}
                />

                {/* WALI KELAS */}
                <FormSelectInput
                    name="wali_kelas"
                    label="WALI KELAS"
                    options={loadOptions?.gurus}
                    value={form.data.wali_kelas}
                    onChange={(val) => form.setData("wali_kelas", val.id)}
                />
            </div>
        </StandardFormModalTemplate>
    );
}
