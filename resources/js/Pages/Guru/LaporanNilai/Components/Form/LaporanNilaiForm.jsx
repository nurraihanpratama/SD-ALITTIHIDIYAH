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
    const form = useForm({
        nisn: "",
        id_mapel: nilai?.mapels?.id_mapel ?? loadOptions.mapels[0].id_mapel,
        id_guru: nilai?.id_guru ?? 1,
        tahun_ajaran: nilai?.tahun_ajaran ?? "",
        uh1: nilai?.uh1 ?? 0,
        uh2: nilai?.uh2 ?? 0,
        uh3: nilai?.uh3 ?? 0,
        uts: nilai?.uts ?? 0,
        uas: nilai?.uas ?? 0,
    });

    const submit = (e) => {
        e.preventDefault;

        return console.log(form.data);
    };

    // console.log(
    //     "test",
    //     loadOptions.mapels.find((mapel) => mapel.id_mapel == form.data.id_mapel)
    // );

    const onChangeMapel = (item) => {
        form.setData((prevData) => ({
            ...prevData,
            id_mapel: item.id_mapel,
        }));
    };

    const onChangeGuru = (item) => {
        const selectedMapel = loadOptions?.mapels.find(
            (mapel) => mapel.id_mapel == form.data.id_mapel
        );

        if (selectedMapel) {
            const selectedGuru = selectedMapel.gurus.find(
                (guru) => guru.id_guru == item.id_guru
            );

            if (selectedGuru) {
                form.setData((prevData) => ({
                    ...prevData,
                    id_guru: selectedGuru.id_guru,
                }));
            } else {
                form.setData((prevData) => ({
                    ...prevData,
                    id_guru: [],
                }));
            }
        }
    };

    const optionTemplate = (option) => {
        return <p>{option.nama_guru}</p>;
    };
    console.log("selectedGuru:", form.data);
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
                        options={loadOptions?.mapels}
                        onChange={(e) => onChangeMapel(e)}
                        idKey="id_mapel"
                        nameKey="nama_mapel"
                    />

                    {/* <FormSelectInputPrimeReact
                        label={"Guru Mapel"}
                        name={"id_guru"}
                        value={loadOptions?.mapels
                            .find((item) => item.id_mapel == form.data.mapel)
                            ?.gurus.find(
                                (item) => item.id_guru == form.data.id_guru
                            )}
                        onChange={(e) => onChangeGuru(e)}
                        options={
                            loadOptions.mapels?.find(
                                (mapel) => mapel.id_mapel == form.data.id_mapel
                            )?.gurus || []
                        }
                        optionLabel={"nama_guru"}
                        itemTemplate={(option) => <p>{option.nama_guru}</p>}
                        className={
                            " relative w-full h-[36px]  bg-white text-gray-700 dark:text-white dark:bg-black/40"
                        }
                        panelClassName={
                            "text-gray-700 bg-white dark:bg-black dark:text-white "
                        }
                    /> */}

                    {/* <FormSelectInput
                        name={"id_guru"}
                        label={"Guru Mapel"}
                        options={
                            loadOptions.mapels?.find(
                                (mapel) => mapel.id_mapel == form.data.id_mapel
                            ).gurus
                        }
                        value={loadOptions?.mapels
                            ?.find(
                                (item) => item?.id_mapel == form.data.id_mapel
                            )
                            ?.gurus?.find(
                                (item) => item?.id_guru == form.data.id_guru
                            )}
                        onChange={(e) => onChangeGuru(e)}
                        error={form.errors.id_guru}
                        // idKey="id_guru"
                        nameKey="nama_guru"
                    /> */}

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
            name={jenisNilai[siswa.nisn]}
            value={form.data.jenisNilai}
            onChange={(val) => form.setData(jenisNilai, val.target.value)}
            // ismobile
            nolabel
        />
    );
};
