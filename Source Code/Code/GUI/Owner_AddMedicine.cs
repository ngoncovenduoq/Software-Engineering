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
    public partial class Owner_AddMedicine : Form
    {
        private int trangthai;
        private string name;
        public Owner_AddMedicine()
        {
            InitializeComponent();
            trangthai = 0;
        }

        public void ChangeLanguage(string language)
        {
            if (language == "Vietnam") 
            {
                lbForm.Text = "Thêm Thuốc";
                lbName.Text = "Tên thuốc";
                lbQuantity.Text = "Số lượng";
                lbDrugContent.Text = "Hàm lượng";
                lbNote.Text = "Ghi chú";
                lbDVT.Text = "ĐVT";
                lbPrice.Text = "Giá bán";
                lbType.Text = "Loại thuốc";
                btnDone.Text = "Xác nhận";
                btnDelete.Text = "Xóa";
            }
            else
            {
                lbForm.Text = "Add Medicine";
                lbName.Text = "Medicine Name";
                lbQuantity.Text = "Quantity";
                lbDrugContent.Text = "Drug Content";
                lbNote.Text = "Note";
                lbDVT.Text = "Unit";
                lbPrice.Text = "Price";
                lbType.Text = "Medicine Type";
                btnDone.Text = "Confirm";
                btnDelete.Text = "Delete";
            }
        }
        public Owner_AddMedicine(string name)
        {
            InitializeComponent();
            trangthai = 1;
            this.name = name;
            DTO.Thuoc thuoc = BLL.Owner_MedicalInstruments.GetThuoc(name);
            tbName.Text = name;
            lbForm.Text = "Sửa Thuốc";
            tbName.Enabled = false;
            cbDVT.Text = thuoc.getDVT();
            tbQuantity.Text = thuoc.getSo_luong().ToString();
            tbPrice.Text = thuoc.getGia_ban().ToString("#");
            tbDrugContent.Text = thuoc.getHam_luong();
            tbNote.Text = thuoc.getGhi_chu();
            cb.Text = thuoc.getTen_loai();
        }

        private void btnDone_Click(object sender, EventArgs e)
        {
            // Reset thông báo lỗi
            lblError.Text = "";

            // Kiểm tra đầu vào
            if (
                string.IsNullOrWhiteSpace(tbName.Text) ||
                string.IsNullOrWhiteSpace(tbDrugContent.Text) ||
                string.IsNullOrWhiteSpace(tbPrice.Text) ||
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
                !BLL.CheckTextBox.KiemTraTenDacbiet(tbDrugContent.Text) ||
                !BLL.CheckTextBox.KiemTraSo(tbPrice.Text) ||
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
                text = BLL.Owner_MedicalInstruments.AddThuoc(tbName.Text, cbDVT.Text, tbQuantity.Text, tbPrice.Text, tbDrugContent.Text, tbNote.Text, cb.Text);
                isSuccess = text.Contains("thành công"); 
            }
            else
            {
                text = BLL.Owner_MedicalInstruments.EditThuoc(tbName.Text, cbDVT.Text, tbQuantity.Text, tbPrice.Text, tbDrugContent.Text, tbNote.Text, cb.Text);
                isSuccess = text.Contains("thành công");
            }

            if (isSuccess)
            {
                this.Close();
            }
            else
            {
                lblError.Text = text; 
            }
        }



        private void Owner_AddMedicine_Load(object sender, EventArgs e)
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
            tbPrice.Text = "";
            tbDrugContent.Text = "";
            cb.SelectedIndex = -1;
            cbDVT.SelectedIndex = -1;
        }
    }
}
