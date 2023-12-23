import ContentCard from "@/Theme/Components/ContentCard";
import ThemeLayout from "@/Theme/ThemeLayout";
import LaporanNilaiDataTable from "./Components/DataTable/LaporanNilaiDataTable";
import { Fragment, useEffect, useState } from "react";
import Modal from "@/Theme/Components/Modal";
import ProcessingLoader from "@/Theme/Components/ProcessingLoader";
import LaporanNilaiForm from "./Components/Form/LaporanNilaiForm";

export default function Index(props) {
    const { page, collection } = props;
    const [showCreateForm, setShowCreateForm] = useState(false);
    const [processing, setProcessing] = useState(false);
    const [data, setData] = useState([]);
    const [loadOptions, setLoadOptions] = useState([]);
    const { title } = page;

    const loadData = async () => {
        try {
            const response = await axios.get(
                route("guru.laporan-nilai.datatable")
            );
            setData(response.data);
        } catch (error) {
            console.error("Error fetching data:", error);
        }
    };

    function onClickNew() {
        setProcessing(true);

        const url = route("guru.laporan-nilai.create");

        axios
            .get(url)
            .then((response) => {
                setLoadOptions(response.data);
                setProcessing(false);
                setShowCreateForm(true);
            })
            .catch((error) => fetchErrorCatch(error, setProcessing(false)));
    }

    useEffect(() => {
        loadData();
    }, []);
    console.log(loadOptions);
    return (
        <ThemeLayout title={title}>
            <ContentCard title={title} />
            <LaporanNilaiDataTable
                collection={collection}
                withNewButton
                onClickNew={onClickNew}
            />

            <Fragment>
                <Modal visible={processing} setVisible={setProcessing}>
                    <ProcessingLoader visible={processing} />
                </Modal>
                <Modal
                    visible={showCreateForm}
                    setVisible={setShowCreateForm}
                    noescape
                >
                    <LaporanNilaiForm
                        action="create"
                        closeForm={() => setShowCreateForm(false)}
                        collection={data}
                        loadOptions={loadOptions}

                        // loadOptions={data}
                    />
                </Modal>
            </Fragment>
        </ThemeLayout>
    );
}
