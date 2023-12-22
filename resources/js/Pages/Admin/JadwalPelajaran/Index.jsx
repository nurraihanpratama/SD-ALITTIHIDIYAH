import ContentCard from "@/Theme/Components/ContentCard";
import ThemeLayout from "@/Theme/ThemeLayout";
import JadwalPelajaranDataTable from "./Components/DataTable/JadwalPelajaranDataTable";
import { Fragment, useState } from "react";
import Modal from "@/Theme/Components/Modal";
import ProcessingLoader from "@/Theme/Components/ProcessingLoader";
import JadwalPelajaranForm from "./Components/Form/JadwalPelajaranForm";

export default function Index(props) {
    const { page, collection } = props;
    const { title } = page;
    console.log(collection);
    const [processing, setProcessing] = useState(false);
    const [showCreateForm, setShowCreateForm] = useState(false);
    return (
        <ThemeLayout title={title}>
            <ContentCard title={title} />
            <JadwalPelajaranDataTable
                collection={collection}
                onClickNew={() => setShowCreateForm(true)}
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
                    <JadwalPelajaranForm
                        action="create"
                        closeForm={() => setShowCreateForm(false)}
                        // loadOptions={data}
                    />
                </Modal>
            </Fragment>
        </ThemeLayout>
    );
}
