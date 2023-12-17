import ContentCard from "@/Theme/Components/ContentCard";
import ThemeLayout from "@/Theme/ThemeLayout";
import KelasDataTable from "./Components/DataTable/KelasDataTable"; // Ganti dengan file yang sesuai untuk DataTable Kelas
import { Fragment, useEffect, useState } from "react";
import ProcessingLoader from "@/Theme/Components/ProcessingLoader";
import KelasForm from "./Components/Form/KelasForm"; // Import form kelas yang sudah dimodifikasi
import Modal from "@/Theme/Components/Modal";

export default function Index(props) {
  const { page, collection } = props;
  const { title } = page;

  const [processing, setProcessing] = useState(false);
  const [showCreateForm, setShowCreateForm] = useState(false);
  const [data, setData] = useState([]);

  const loadOptions = async () => {
    try {
      const response = await axios.get(route("admin.kelas.create"));
      setData(response.data);
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  };

  useEffect(() => {
    // Panggil loadOptions() saat komponen pertama kali dirender
    loadOptions();
  }, []);
console.log(data);
  return (
    <ThemeLayout title={title}>
      <ContentCard title={title} />

      <KelasDataTable
        collection={collection}
        loadOptions={data}
        onClickNew={() => setShowCreateForm(true)} // Ganti dengan aksi yang sesuai untuk form Kelas
        withNewButton
      />

      <Fragment>
        <Modal visible={processing} setVisible={setProcessing} noescape>
          <ProcessingLoader visible={processing} />
        </Modal>
        <Modal visible={showCreateForm} setVisible={setShowCreateForm} noescape>
          <KelasForm
            action="create"
            closeForm={() => setShowCreateForm(false)}
            loadOptions={data}
          />
        </Modal>
      </Fragment>
    </ThemeLayout>
  );
}
