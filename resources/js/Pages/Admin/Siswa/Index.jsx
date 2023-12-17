import ContentCard from "@/Theme/Components/ContentCard";
import ThemeLayout from "@/Theme/ThemeLayout";
import SiswaDataTable from "./Components/DataTable/SiswaDataTable";
import { Fragment, useEffect, useState } from "react";
import ProcessingLoader from "@/Theme/Components/ProcessingLoader";
import SiswaForm from "./Components/Form/SiswaForm";
import Modal from "@/Theme/Components/Modal";

export default function Index(props) {
    const { page, collection } = props;
    const { title } = page;

    const [processing, setProcessing] = useState(false);
    const [showCreateForm, setShowCreateForm] = useState(false);
    const [data, setData] = useState([]);

    const loadOptions = async () => {
        try {
            const response = await axios.get(route("admin.siswa.create"));
            setData(response.data);
        } catch (error) {
            console.error("Error fetching data:", error);
        }
    };

    useEffect(() => {
        // Panggil loadOptions() saat komponen pertama kali dirender
        loadOptions();
    }, []);

    return (
        <ThemeLayout title={title}>
            <ContentCard title={title} />

            <SiswaDataTable
                collection={collection}
                loadOptions={data}
                onClickNew={setShowCreateForm}
                withNewButton
            />

            <Fragment>
                <Modal visible={processing} setVisible={setProcessing} noescape>
                    <ProcessingLoader visible={processing} />
                </Modal>
                <Modal
                    visible={showCreateForm}
                    setVisible={setShowCreateForm}
                    noescape
                >
                    <SiswaForm
                        action="create"
                        closeForm={() => setShowCreateForm(false)}
                        loadOptions={data}
                    />
                </Modal>
            </Fragment>
        </ThemeLayout>
    );
}
