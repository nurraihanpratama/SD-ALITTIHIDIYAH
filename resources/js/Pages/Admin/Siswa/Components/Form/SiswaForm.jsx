import { onErrorFeedback, onSuccessFeedback } from "@/Helpers/formFeedback";
import StandardFormModalTemplate from "@/Theme/Components/ModalTemplates/StandardFormModalTemplate";
import FormDatePicker from "@/Theme/Form/FormDatePicker";
import FormSelectInput from "@/Theme/Form/FormSelectInput";
import FormTextInput from "@/Theme/Form/FormTextInput";
import { useForm } from "@inertiajs/react";
import dayjs from "dayjs";
import { useState } from "react";
export default function SiswaForm({
    action,
    loadOptions = null,
    row = null,
    closeForm,
}) {
    const form = useForm({
        nisn: row?.nisn ?? "",
        nipd: row?.nipd ?? "",
        nama_siswa: row?.nama_siswa ?? "",
        jk_siswa: row?.jk?.id ?? loadOptions?.jk[0].id,
        agama_siswa: row?.agama?.id ?? loadOptions.agama[0].id,
        tempat_lahir: row?.tempat_lahir ?? "",
        tanggal_lahir:
            dayjs(row?.tanggal_lahir).format("YYYY-MM-DD") ??
            dayjs().format("YYYY-MM-DD"),
        status_siswa: row?.status?.id ?? loadOptions?.status[0].id,
        id_kelas: row?.id_kelas ?? loadOptions?.kelas[0].id,
    });
    const handleOnChange = (event) => {
        form.setData(event.target.name, event.target.value);
    };

    const titleHeader = () => {
        if (action === "create") return "Tambah Data Siswa";
        if (action === "update") return `Ubah Data Siswa`;
    };

    const submit = (e) => {
        e.preventDefault();

        if (action == "create") {
            // return console.log(form.data)
            if (confirm("Yakin untuk menambahkan Data Siswa baru?")) {
                return form.post(route("admin.siswa.store"), {
                    preserveScroll: true,
                    onSuccess: (response) =>
                        onSuccessFeedback(response, closeForm()),
                    onError: (err) => onErrorFeedback,
                });
            }
        }

        if (action == "update") {
            if (confirm("Yakin untuk Mengubah Data Siswa?")) {
                return form.patch(route("admin.siswa.update", row.nisn), {
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
                <div className="block w-full grid-cols-2 gap-4 space-y-4 text-gray-700 lg:space-y-0 lg:grid dark:text-white">
                    {/* NISN */}
                    <FormTextInput
                        name="nisn"
                        label={"NISN"}
                        value={form.data.nisn}
                        onChange={handleOnChange}
                        error={form.errors.nisn}
                    />

                    {/* NIPD */}
                    <FormTextInput
                        name="nipd"
                        label={"NIPD"}
                        value={form.data.nipd}
                        onChange={handleOnChange}
                        error={form.errors.nipd}
                    />
                </div>

                {/* NAMA SISWA */}
                <FormTextInput
                    name="nama_siswa"
                    label={"NAMA SISWA"}
                    value={form.data.nama_siswa}
                    onChange={handleOnChange}
                    error={form.errors.nama_siswa}
                />

                {/* PILIH KELAS */}
                <FormSelectInput
                    name="id_kelas"
                    label="PILIH KELAS"
                    options={loadOptions?.kelas}
                    value={form.data.id_kelas}
                    onChange={(val) => form.setData("id_kelas", val.id)}
                />

                {/* JENIS KELAMIN */}
                <FormSelectInput
                    name="jk_siswa"
                    label="JENIS KELAMIN SISWA"
                    options={loadOptions?.jk}
                    value={form.data.jk_siswa}
                    onChange={(val) => form.setData("jk_siswa", val.id)}
                    error={form.errors.jk_siswa}
                    isRequired={true}
                />

                {/* AGAMA SISWA */}
                <FormSelectInput
                    name="agama_siswa"
                    label="AGAMA SISWA"
                    options={loadOptions?.agama}
                    value={form.data.agama_siswa}
                    onChange={(val) => form.setData("agama_siswa", val.id)}
                    error={form.errors.agama_siswa}
                    isRequired={true}
                />

                {/* TEMPAT LAHIR */}
                <FormTextInput
                    name="tempat_lahir"
                    label={"TEMPAT LAHIR"}
                    value={form.data.tempat_lahir}
                    onChange={handleOnChange}
                    error={form.errors.tempat_lahir}
                />

                {/* TANGGAL LAHIR */}
                <FormDatePicker
                    name={"tanggal_lahir"}
                    label={"TANGGAL LAHIR"}
                    defaultDate={new Date(form.data.tanggal_lahir)}
                    handleOnChange={(val) => form.setData("tanggal_lahir", val)}
                    error={form.errors.tanggal_lahir}
                />

                {/* STATUS */}
                <FormSelectInput
                    name="status_siswa"
                    label="STATUS SISWA"
                    options={loadOptions?.status}
                    value={form.data.status_siswa}
                    onChange={(val) => form.setData("status_siswa", val.id)}
                    error={form.errors.status_siswa}
                    isRequired={true}
                />
            </div>
        </StandardFormModalTemplate>
    );
}
