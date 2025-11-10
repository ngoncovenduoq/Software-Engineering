using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Project_CNPM
{
    public partial class Owner_AddMaterial : Form
    {
        private int trangthai;
        public Owner_AddMaterial()
        {
            InitializeComponent();
            trangthai = 0;
        }

        public void ChangeLanguage(string language)
        {
            if(language == "Vietnam")
            {
                lbForm.Text = "Thêm Dụng Cụ";
                lbName.Text = "Tên dụng cụ";
                lbQuantity.Text = "Số lượng";
                lbColor.Text = "Màu sắc";
                lbType.Text = "Loại dụng cụ";
                lbNote.Text = "Ghi chú";
                lbDVT.Text = "ĐVT";
                lbSize.Text = "Kích cỡ";
                lbValue.Text = "Trị giá";
                btnDone.Text = "Xác nhận";
                btnDelete.Text = "Xóa";
            }
            else
            {
                lbForm.Text = "Add Equipment";
                lbName.Text = "Equipment Name";
                lbQuantity.Text = "Quantity";
                lbColor.Text = "Color";
                lbType.Text = "Equipment Type";
                lbNote.Text = "Note";
                lbDVT.Text = "Unit";
                lbSize.Text = "Size";
                lbValue.Text = "Value";
                btnDone.Text = "Confirm";
                btnDelete.Text = "Delete";
            }
        }
        public Owner_AddMaterial(string name)
        {
            InitializeComponent();
            trangthai = 1;
            DTO.Vat_lieu vat_Lieu = BLL.Owner_MedicalInstruments.GetVatLieu(name);
            lbForm.Text = "Sửa Vật liệu";
            tbName.Text = name;
            tbName.Enabled = false;
            tbColor.Text = vat_Lieu.getMau_sac();
            tbSize.Text = vat_Lieu.getKich_co().ToString();
            cbDVT.Text = vat_Lieu.getDVT();
            tbValue.Text = vat_Lieu.getGia().ToString("#");
            tbQuantity.Text = vat_Lieu.getSo_luong().ToString();
            tbNote.Text = vat_Lieu.getGhi_chu();
            cb.Text = vat_Lieu.getLoai();
        }

        private void btnDone_Click(object sender, EventArgs e)
        {
           
            lblError.Text = "";

         
            if (
                string.IsNullOrWhiteSpace(tbName.Text) ||
                string.IsNullOrWhiteSpace(tbColor.Text) ||
                string.IsNullOrWhiteSpace(tbSize.Text) ||
                string.IsNullOrWhiteSpace(tbValue.Text) ||
                string.IsNullOrWhiteSpace(cbDVT.Text) ||
                string.IsNullOrWhiteSpace(cb.Text) ||
                string.IsNullOrWhiteSpace(tbQuantity.Text) ||
                cbDVT.SelectedIndex == -1 ||
                cb.SelectedIndex == -1
            )
            {
                lblError.Text = "Vui lòng điền đầy đủ thông tin.";
                return;
            }

            if (
                !BLL.CheckTextBox.KiemTraTenDacbiet(tbName.Text) ||
                !BLL.CheckTextBox.KiemTraTenDacbiet(tbColor.Text) ||
                !BLL.CheckTextBox.KiemTraTenDacbiet(tbNote.Text) ||
                !BLL.CheckTextBox.KiemTraSo(tbSize.Text) ||
                !BLL.CheckTextBox.KiemTraSo(tbValue.Text) ||
                !BLL.CheckTextBox.KiemTraSo(tbQuantity.Text)
            )
            {
                lblError.Text = "Vui lòng nhập đúng định dạng.";
                return;
            }

        
            string text;
            bool isSuccess;

            if (trangthai == 0) 
            {
                text = BLL.Owner_MedicalInstruments.AddVatLieu(tbName.Text, tbColor.Text, tbSize.Text, cbDVT.Text, tbValue.Text, tbQuantity.Text, tbNote.Text, cb.Text);
                isSuccess = text.Contains("thành công"); 
            }
            else // Sửa vật liệu
            {
                text = BLL.Owner_MedicalInstruments.EditVatLieu(tbName.Text, tbColor.Text, tbSize.Text, cbDVT.Text, tbValue.Text, tbQuantity.Text, tbNote.Text, cb.Text);
                isSuccess = text.Contains("thành công");
            }

            // Nếu thành công, đóng form
            if (isSuccess)
            {
                this.Close();
            }
            else
            {
                lblError.Text = text; 
            }
        }


        private void Owner_AddMaterial_Load(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            tbName.Text = "";
            tbNote.Text = "";
            tbQuantity.Text = "";
            tbColor.Text = "";
            tbSize.Text = "";
            tbValue.Text = "";
            cb.SelectedIndex = -1;
            cbDVT.SelectedIndex = -1;
        }
    }
}
