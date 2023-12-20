import ContentCard from "@/Theme/Components/ContentCard";
import ThemeLayout from "@/Theme/ThemeLayout";
import LaporanNilaiDataTable from "./Components/DataTable/LaporanNilaiDataTable";
import { Fragment, useState } from "react";
import Modal from "@/Theme/Components/Modal";
import ProcessingLoader from "@/Theme/Components/ProcessingLoader";
import LaporanNilaiForm from "./Components/Form/LaporanNilaiForm";

export default function Index(props) {
    const { page, collection } = props;
    const [showCreateForm, setShowCreateForm] = useState(false);
    const [processing, setProcessing] = useState(false);

    const { title } = page;

    console.log(collection);
    return (
        <ThemeLayout title={title}>
            <ContentCard title={title} />
            <LaporanNilaiDataTable
                collection={collection}
                withNewButton
                onClickNew={() => setShowCreateForm(true)}
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
                    <LaporanNilaiForm
                        action="create"
                        closeForm={() => setShowCreateForm(false)}
                        // loadOptions={data}
                    />
                </Modal>
            </Fragment>
        </ThemeLayout>
    );
}
