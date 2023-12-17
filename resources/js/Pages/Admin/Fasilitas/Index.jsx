import React, { Fragment, useEffect, useState } from "react";
import axios from "axios";
import { route } from "path-to-your-route-file"; // Gantilah dengan path yang sesuai
import ContentCard from "@/Theme/Components/ContentCard";
import ThemeLayout from "@/Theme/ThemeLayout";
import FasilitasDataTable from "./Components/DataTable/FasilitasDataTable"; // Sesuaikan dengan file DataTable Fasilitas
import ProcessingLoader from "@/Theme/Components/ProcessingLoader";
import FasilitasForm from "./Components/Form/FasilitasForm"; // Sesuaikan dengan file Form Fasilitas
import Modal from "@/Theme/Components/Modal";

export default function Index(props) {
  const { page, collection } = props;
  const { title } = page;

  const [processing, setProcessing] = useState(false);
  const [showCreateForm, setShowCreateForm] = useState(false);
  const [data, setData] = useState([]);

  const loadOptions = async () => {
    try {
      const response = await axios.get(route("admin.fasilitas.create"));
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

      <FasilitasDataTable
        collection={collection}
        loadOptions={data}
        onClickNew={() => setShowCreateForm(true)} // Sesuaikan dengan aksi yang sesuai untuk form Fasilitas
        withNewButton
      />

      <Fragment>
        <Modal visible={processing} setVisible={setProcessing} noescape>
          <ProcessingLoader visible={processing} />
        </Modal>
        <Modal visible={showCreateForm} setVisible={setShowCreateForm} noescape>
          <FasilitasForm
            action="create"
            closeForm={() => setShowCreateForm(false)}
            loadOptions={data}
          />
        </Modal>
      </Fragment>
    </ThemeLayout>
  );
}