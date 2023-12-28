import StandardFormModalTemplate from "@/Theme/Components/ModalTemplates/StandardFormModalTemplate";
import FormSelectInputPrimeReact from "@/Theme/Form/FormSelectInputPrimeReact";
import { useForm } from "@inertiajs/react";
export default function SingleSendNilaiForm({
    closeForm,
    loadOptions = null,
    nilai = null,
    // row
}) {
    const form = useForm({
        nisn: nilai?.nisn ?? "",
        id_mapel: nilai?.id_mapel ?? loadOptions.mapels[0].id_mapel,
        id_guru: nilai?.id_guru ?? "",
    });

    const optionTemplate = (option) => {
        console.log("ini option", option);
        return <p>{option.nama_mapel}</p>;
    };
    const optionsTemplate = (option) => {
        return <p>{option.nama_guru}</p>;
    };

    const onChangeMapel = (item) => {
        form.setData((prevData) => ({
            ...prevData,
            id_mapel: item.value.id_mapel,
        }));
    };

    const onChangeGuru = (item) => {
        const selectedMapel = loadOptions?.mapels.find(
            (mapel) => mapel.id_mapel == form.data.id_mapel
        );

        if (selectedMapel) {
            const selectedGuru = selectedMapel.gurus.find(
                (guru) => guru.id_guru == item.value.id_guru
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
            console.log(selectedMapel, selectedGuru, form.data);
        }
    };
    return (
        <StandardFormModalTemplate
            title={`Tambahkan Nilai ${nilai.nama_siswa}`}
            closeForm={closeForm}
        >
            <div className="flex flex-col gap-4">
                <div className="gap-4 flex-between">
                    <FormSelectInputPrimeReact
                        name={"id_mapel"}
                        label={"Mata Pelajaran"}
                        options={loadOptions.mapels}
                        value={loadOptions.mapels.find(
                            (item) => item.id_mapel == form.data.id_mapel
                        )}
                        onChange={(e) => {
                            onChangeMapel(e);
                        }}
                        optionLabel={"nama_mapel"}
                        itemTemplate={optionTemplate}
                        error={form.errors.id_guru}
                    />

                    <FormSelectInputPrimeReact
                        label={"Guru Mapel"}
                        name={"id_guru"}
                        value={loadOptions?.mapels
                            .find((item) => item.id_mapel == form.data.mapel)
                            ?.gurus.find(
                                (item) => item.id_guru == form.data.id_guru
                            )}
                        onChange={(e) => {
                            onChangeGuru(e);
                        }}
                        options={
                            loadOptions.mapels?.find(
                                (mapel) => mapel.id_mapel == form.data.id_mapel
                            )?.gurus || []
                        }
                        optionLabel={"nama_guru"}
                        itemTemplate={optionsTemplate}
                    />
                </div>
            </div>
        </StandardFormModalTemplate>
    );
}
