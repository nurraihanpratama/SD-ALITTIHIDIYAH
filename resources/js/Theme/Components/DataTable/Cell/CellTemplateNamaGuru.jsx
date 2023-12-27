export default function CellTemplateNamaGuru({ row }) {
    return (
        <span>
            <p>
                {row?.gelar_guru
                    ? `${row?.nama_guru}, ${row?.gelar_guru}`
                    : row?.nama_guru}
            </p>
        </span>
    );
}
