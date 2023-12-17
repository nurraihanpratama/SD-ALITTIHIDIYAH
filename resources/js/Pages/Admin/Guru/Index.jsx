import ContentCard from "@/Theme/Components/ContentCard";
import ThemeLayout from "@/Theme/ThemeLayout";
import GuruDataTable from "./Components/DataTable/GuruDataTable";
import { Fragment, useEffect, useState } from "react";
import ProcessingLoader from "@/Theme/Components/ProcessingLoader";
import GuruForm from "./Components/Form/GuruForm";
import Modal from "@/Theme/Components/Modal";

export default function Index(props) {
    const { page, collection } = props;
    const { title } = page;

    const [processing, setProcessing] = useState(false);
    const [showCreateForm, setShowCreateForm] = useState(false);
    const [data, setData] = useState([]);

    const loadOptions = async () => {
        try {
            const response = await axios.get(route("admin.guru.create"));
            setData(response.data);
        } catch (error) {
            console.error("Error fetching data:", error);
        }
    };

    useEffect(() => {
        loadOptions();
    }, []);

    console.log(data);
    return (
        <ThemeLayout title={title}>
            <ContentCard title={title} />

            <GuruDataTable
                collection={collection}
                loadOptions={data}
                onClickNew={() => setShowCreateForm(true)} // Ganti dengan aksi yang sesuai untuk form Guru
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
                    <GuruForm
                        action="create"
                        closeForm={() => setShowCreateForm(false)}
                        loadOptions={data}
                    />
                </Modal>
            </Fragment>
        </ThemeLayout>
    );
}
