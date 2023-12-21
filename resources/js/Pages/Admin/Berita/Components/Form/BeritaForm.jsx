import StandardFormModalTemplate from "@/Theme/Components/ModalTemplates/StandardFormModalTemplate";
import FormTextInput from "@/Theme/Form/FormTextInput";
import FormSelectInput from "@/Theme/Form/FormSelectInput";
import { useForm } from "@inertiajs/react";
import { useState } from "react";
import FormUploadInput from "@/Theme/Form/FormUploadInput";

export default function BeritaForm({
    action,
    loadOptions = null,
    row = null,
    closeForm,
}) {
    const form = useForm({
        judul: row?.judul ?? "",
        foto_img: "",
        foto_filename: "",
        deskripsi: row?.deskripsi ?? "",
        // ... (existing form fields)
    });

    const handleOnChange = (event) => {
        form.setData(event.target.name, event.target.value);
    };

    const handleFileChange = (file) => {
        form.setData("foto", file); // Set the file data when the file is selected
    };

    const titleHeader = () => {
        if (action === "create") return "Tambah Berita";
        else return `Ubah Berita`;
    };

    const submit = (e) => {
        e.preventDefault();

        if (action === "create") {
            // Check if the form is valid and confirm before submitting
            if (window.confirm("Yakin untuk menambahkan Berita baru?")) {
                // Use form.post for form submissions
                form.post(route("admin.berita.store"), {
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
                {/* Nama Berita */}
                <FormTextInput
                    name="judul"
                    label={"Nama Berita"}
                    value={form.data.judul}
                    onChange={handleOnChange}
                    error={form.errors.judul}
                />

                {/* Deskripsi */}
                <FormTextInput
                    name="deskripsi"
                    label={"Deskripsi"}
                    value={form.data.deskripsi}
                    onChange={handleOnChange}
                    error={form.errors.deskripsi}
                />

                {/* Foto */}
                <FormUploadInput
                    id={"foto_img"}
                    label="Gambar Berita"
                    onChange={(val) => form.setData("foto_img", val)}
                    currentImage={
                        form.data.foto_filename
                            ? form.data.foto_filename === "no_img.png"
                                ? null
                                : `/storage/upload/berita/foto/${form.data.foto_filename}`
                            : null
                    }
                    onRemoveImage={() => form.setData("foto_img", null)}
                    withChange={action != "show"}
                    withRemove={action != "show"}
                    disabled={action == "show"}
                />
            </div>
        </StandardFormModalTemplate>
    );
}
