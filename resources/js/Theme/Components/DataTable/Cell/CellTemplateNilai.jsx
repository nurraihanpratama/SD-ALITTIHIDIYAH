export default function CellTemplateNilai({ row, jenis }) {
    const nilaiDitemukan = row.nilais?.find(
        (nilai) => nilai?.jenis_nilai === jenis
    );

    if (nilaiDitemukan) {
        return nilaiDitemukan.nilai;
    } else if (nilaiDitemukan?.nilai == 0) {
        return 0;
    } else {
        return (
            <p className="text-red-500 dark:text-orange-500 animate-pulse">
                Belum ada nilai
            </p>
        );
    }
}
