import StandardFormModalTemplate from "@/Theme/Components/ModalTemplates/StandardFormModalTemplate";
import FormTextInput from "@/Theme/Form/FormTextInput";
import { useForm } from "@inertiajs/react";
import TableInputNilai from "./Section/TableInputNilai";
import FormNumberInput from "@/Theme/Form/FormNumberInput";
import FormSelectInput from "@/Theme/Form/FormSelectInput";
import FormSelectInputPrimeReact from "@/Theme/Form/FormSelectInputPrimeReact";
import { useState } from "react";

export default function LaporanNilaiForm({
    collection,
    closeForm,
    loadOptions = null,
    nilai = null,
}) {
    const [selectedGuru, setSelectedGuru] = useState(
        loadOptions?.gurus[0] || null
    );
    const form = useForm({
        nisn: "",
        id_mapel: loadOptions.mapel?.id_mapel ?? loadOptions.mapel[0].id_mapel,
        id_guru: "",
        tahun_ajaran: nilai?.tahun_ajaran ?? "",
        uh1: nilai?.uh1 ?? 0,
        uh2: nilai?.uh2 ?? 0,
        uh3: nilai?.uh3 ?? 0,
        uts: nilai?.uts ?? 0,
        uas: nilai?.uas ?? 0,
    });

    const onChangeGuru = (val) => {
        const selectedGuru = loadOptions?.gurus.find(
            (guru) => guru.id_guru === val.id_guru
        );
        setSelectedGuru(selectedGuru);

        // Jika ingin mengatur nilai mapel secara default, misalnya mapel pertama dari guru yang dipilih
        form.setData(
            "id_mapel",
            selectedGuru?.bidang_studis[0]?.id_mapel || null
        );
    };

    const submit = (e) => {
        e.preventDefault;

        return console.log(form.data);
    };
    console.log(
        loadOptions.mapel.find((mapel) => mapel.id_mapel == form.data.id_mapel)
    );
    return (
        <StandardFormModalTemplate
            title={"Form Input Nilai"}
            closeForm={closeForm}
            submit={submit}
        >
            <div className="flex flex-col gap-4">
                <div className="gap-4 flex-between">
                    <FormSelectInput
                        name={"id_mapel"}
                        label={"Bidang Studi"}
                        value={form.data.id_mapel}
                        options={loadOptions?.mapel}
                        onChange={(val) =>
                            form.setData("id_mapel", val.id_mapel)
                        }
                        idKey="id_mapel"
                        nameKey="nama_mapel"
                    />

                    <FormSelectInput
                        name={"id_guru"}
                        label={"Guru Mapel"}
                        options={
                            loadOptions.mapel?.find(
                                (mapel) => mapel.id_mapel == form.data.id_mapel
                            )?.gurus || []
                        }
                        value={1}
                        onChange={(val) => form.setData("id_guru", val.id_guru)}
                        error={form.errors.id_guru}
                        idKey="id_guru"
                        nameKey="nama_guru"
                    />

                    <FormTextInput name={"test"} label={"Tahun Ajaran"} />
                </div>
                <TableInputNilai
                    collection={collection}
                    form={form}
                    columns={inputColumns}
                />
            </div>
        </StandardFormModalTemplate>
    );
}

const inputColumns = [
    {
        header: "Nama Siswa",
        field: "nama_siswa",
    },
    {
        header: "Ulangan Harian 1",
        render: (row, form) => (
            <InputData siswa={row} form={form} jenisNilai={"uh1"} />
        ),
    },
    {
        header: "Ulangan Harian 2",
        render: (row, form) => (
            <InputData siswa={row} form={form} jenisNilai={"uh2"} />
        ),
    },
    {
        header: "Ulangan Harian 3",
        render: (row, form) => (
            <InputData siswa={row} form={form} jenisNilai={"uh3"} />
        ),
    },
    {
        header: "Ujian Tengah Semester",
        render: (row, form) => (
            <InputData siswa={row} form={form} jenisNilai={"uts"} />
        ),
    },
    {
        header: "Ujian Akhir Semester",
        render: (row, form) => (
            <InputData siswa={row} form={form} jenisNilai={"uas"} />
        ),
    },
];

const InputData = ({ siswa, nilai = null, form, jenisNilai }) => {
    // function idJenisNilai() {}
    return (
        <FormNumberInput
            key={siswa.nisn}
            name={jenisNilai}
            value={form.data.jenisNilai}
            onChange={(val) => form.setData(jenisNilai, val.target.value)}
            // ismobile
            nolabel
        />
    );
};
