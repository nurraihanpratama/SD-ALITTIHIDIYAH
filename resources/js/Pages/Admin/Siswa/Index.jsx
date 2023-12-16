import ContentCard from "@/Theme/Components/ContentCard";
import ThemeLayout from "@/Theme/ThemeLayout";
import SiswaDataTable from "./Components/DataTable/SiswaDataTable";
import { Fragment, useState } from "react";
import Modal from "@/Components/Modal";
import ProcessingLoader from "@/Theme/Components/ProcessingLoader";
import SiswaForm from "./Components/Form/SiswaForm";

export default function Index(props) {
    const { page, collection } = props;
    const { title } = page;

    const [processing, setProcessing] = useState(false);
    const [showCreateForm, setShowCreateForm] = useState(false);
    console.log(showCreateForm);

    return (
        <ThemeLayout title={title}>
            <ContentCard title={title} />

            <SiswaDataTable
                collection={collection}
                onClickNew={setShowCreateForm}
                withNewButton
            />

            <Fragment>
                <Modal
                    visible={showCreateForm}
                    setVisible={setShowCreateForm}
                    noescape
                >
                    <SiswaForm
                        action="create"
                        closeForm={() => setShowCreateForm(false)}
                    />
                </Modal>
            </Fragment>
        </ThemeLayout>
    );
}
