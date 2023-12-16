import StandardFormModalTemplate from "@/Theme/Components/ModalTemplates/StandardFormModalTemplate";
import FormDatePicker from "@/Theme/Form/FormDatePicker";
import FormSelectInput from "@/Theme/Form/FormSelectInput";
import FormTextInput from "@/Theme/Form/FormTextInput";
import { useForm } from "@inertiajs/react";
import dayjs from "dayjs";
export default function SiswaForm({ action, row = null, closeForm }) {
    const dataAgama = [
        { id: "Islam", name: "ISLAM" },
        { id: "Kristen", name: "KRISTEN" },
    ];
    const dataJk = [
        { id: "L", name: "Laki-Laki" },
        { id: "P", name: "Perempuan" },
    ];
    const statuses = [
        { id: "Aktif", name: "AKTIF" },
        { id: "Nonaktif", name: "NONAKTIF" },
    ];

    const form = useForm({
        nisn: row?.nisn ?? "",
        nipd: row?.nipd ?? "",
        nama_siswa: row?.nama_siswa ?? "",
        jk_siswa: row?.jk?.id ?? dataJk[0].id,
        agama_siswa: dataAgama[0].id,
        tempat_lahir: row?.tempat_lahir ?? "",
        tanggal_lahir: dayjs().format("YYYY-MM-DD"),
        status_siswa: row?.status?.id ?? statuses[0].id,
        id_kelas: row?.id_kelas ?? "",
    });
    const handleOnChange = (event) => {
        form.setData(event.target.name, event.target.value);
    };

    const titleHeader = () => {
        if (action === "create") return "Tambah Data Siswa";
        else return `Ubah Data Siswa`;
    };
    const submit = (e) => {
        e.preventDefault();

        if (action == "create") {
            return console.log(form.data);
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

                {/* JENIS KELAMIN */}
                <FormSelectInput
                    name="jk_siswa"
                    label="JENIS KELAMIN SISWA"
                    options={dataJk}
                    value={form.data.jk_siswa}
                    onChange={(val) => form.setData("jk_siswa", val.id)}
                    error={form.errors.jk_siswa}
                    isRequired={true}
                />

                {/* AGAMA SISWA */}
                <FormSelectInput
                    name="agama_siswa"
                    label="AGAMA SISWA"
                    options={dataAgama}
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
                    options={statuses}
                    value={form.data.status_siswa}
                    onChange={(val) => form.setData("status_siswa", val.id)}
                    error={form.errors.status_siswa}
                    isRequired={true}
                />
            </div>
        </StandardFormModalTemplate>
    );
}
