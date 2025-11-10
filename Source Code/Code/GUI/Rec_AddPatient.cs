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
    public partial class Rec_AddPatient : Form
    {
        public delegate void Rechand();
        public Rechand rechand;
        public Rec_AddPatient()
        {
            InitializeComponent();
        }

        public void ChangeLanguage(string language)
        {
            if(language == "Vietnam")
            {
                labelForm.Text = "THÊM BỆNH NHÂN MỚI";
                lbLastName.Text = "Họ";
                lbFirstName.Text = "Tên";
                lbSex.Text = "Giới tính";
                btnCancel.Text = "HỦY";
                btnDone.Text = "XONG";
            }
            else
            {
                labelForm.Text = "ADD NEW PATIENT";
                lbLastName.Text = "Last Name";
                lbFirstName.Text = "First Name";
                lbSex.Text = "Gender";
                btnCancel.Text = "CANCEL";
                btnDone.Text = "DONE";
            }
        }

        public void ChangeColor(Color color, Color color2)
        {
            panel1.BackColor = panel3.BackColor = panel4.BackColor = panel2.BackColor = Color.FromArgb(241, 241, 241);
            panel5.BackColor = color2;
            if(color2 == Color.FromArgb(50,50,50)) 
            {
                lbCCCD.ForeColor = Color.White;
                labelForm.ForeColor = Color.White;
                lbLastName.ForeColor = Color.White;
                lbFirstName.ForeColor = Color.White;
                lbSex.ForeColor = Color.White;
                lbdc.ForeColor = Color.White;
                lbBirthday.ForeColor = Color.White;
                lbjob.ForeColor = Color.White;
                lbsdt.ForeColor = Color.White;
                lbBirth1.ForeColor = Color.FromArgb(213, 218, 223);
                lbBirth2.ForeColor = Color.FromArgb(213, 218, 223);


                btnCancel.ForeColor = Color.White;
                btnCancel.FillColor = Color.FromArgb(50, 50, 50);
                btnDone.FillColor = Color.FromArgb(50, 50, 50);

                tbCCCD.FillColor = Color.FromArgb(50, 50,50);
                tbLastName.FillColor = Color.FromArgb (50, 50, 50);
                tbFirstName.FillColor = cbSex.FillColor = Color.FromArgb(50, 50, 50);
                tbdc.FillColor = Color.FromArgb(50, 50, 50);
                tbDay.FillColor = Color.FromArgb(50, 50, 50);
                tbMonth.FillColor = Color.FromArgb(50, 50, 50);
                tbYear.FillColor = Color.FromArgb(50, 50, 50);
                tbsdt.FillColor = Color.FromArgb(50, 50, 50);
                tbjob.FillColor = Color.FromArgb(50, 50, 50);
                panel1.BackColor = panel3.BackColor = panel4.BackColor = panel2.BackColor = Color.FromArgb(45, 38, 38);
            }
            else
            {
                lbCCCD.ForeColor = Color.Black;
                labelForm.ForeColor = Color.FromArgb(68, 197, 229);
                lbLastName.ForeColor = Color.Black;
                lbFirstName.ForeColor = Color.Black;
                lbSex.ForeColor = Color.Black;
                lbdc.ForeColor = Color.Black;
                lbBirthday.ForeColor = Color.Black;
                lbjob.ForeColor = Color.Black;
                lbsdt.ForeColor = Color.Black;
                lbBirth1.ForeColor = Color.Black;
                lbBirth2.ForeColor = Color.Black;


                btnCancel.ForeColor = Color.White;
                btnCancel.FillColor = Color.FromArgb(230, 34, 34);
                btnDone.FillColor = Color.FromArgb(68, 197, 229);

                tbCCCD.FillColor = Color.White;
                tbLastName.FillColor = Color.White;
                tbFirstName.FillColor = cbSex.FillColor = tbYear.FillColor = tbDay.FillColor = tbMonth.FillColor = Color.White;
                tbdc.FillColor = Color.White;
                tbDay.FillColor = Color.White;
                tbMonth.FillColor = Color.White;
                tbYear.FillColor = Color.White;
                tbsdt.FillColor = Color.White;
                tbjob.FillColor = Color.White;
            }
        }
        private bool IsValidPhoneNumber(string phoneNumber)
        {
            // Kiểm tra số điện thoại phải chứa đúng 10 chữ số
            return phoneNumber.Length == 10 && long.TryParse(phoneNumber, out _);
        }
        private void btnDone_Click(object sender, EventArgs e)
        {
            // Reset nội dung của label thông báo lỗi chung
            lblError.Text = "";

            // Kiểm tra các ô nhập liệu trống
            if (string.IsNullOrWhiteSpace(tbCCCD.Text) ||
                string.IsNullOrWhiteSpace(tbFirstName.Text) ||
                string.IsNullOrWhiteSpace(tbLastName.Text) ||
                string.IsNullOrWhiteSpace(tbjob.Text) ||
                string.IsNullOrWhiteSpace(tbsdt.Text) ||
                string.IsNullOrWhiteSpace(tbdc.Text) ||
                string.IsNullOrWhiteSpace(tbDay.Text) ||
                string.IsNullOrWhiteSpace(tbMonth.Text) ||
                string.IsNullOrWhiteSpace(tbYear.Text) ||
                string.IsNullOrWhiteSpace(cbSex.Text))
            {
                lblError.Text = "Vui lòng nhập đủ thông tin."; // Thông báo lỗi chung
                return;
            }
            if (!IsValidPhoneNumber(tbsdt.Text))
            {
                lblError.Text = "Số điện thoại phải đủ 10 chữ số.";
                lblError.Visible = true;
                return; // Dừng xử lý nếu số điện thoại không hợp lệ
            }

            // Kiểm tra định dạng
            if (
                !BLL.CheckTextBox.KiemTraSo(tbCCCD.Text) ||
                !BLL.CheckTextBox.KiemTraTenDacbiet(tbFirstName.Text) ||
                !BLL.CheckTextBox.KiemTraTenDacbiet(tbLastName.Text) ||
                !BLL.CheckTextBox.KiemTraTenDacbiet(tbjob.Text) ||
                !BLL.CheckTextBox.KiemTraSo(tbsdt.Text) ||
                !BLL.CheckTextBox.KiemTraTenDacbiet(tbdc.Text) ||
                !BLL.CheckTextBox.KiemTraSo(tbMonth.Text) ||
                !BLL.CheckTextBox.KiemTraSo(tbYear.Text) ||
                !BLL.CheckTextBox.KiemTraSo(tbDay.Text) ||
                !BLL.CheckTextBox.KiemTraTenDacbiet(cbSex.Text)
            )
            {
                lblError.Text = "Vui lòng nhập đúng định dạng."; // Thông báo lỗi định dạng
                return;
            }

            // Nếu không có lỗi, tiếp tục xử lý thêm bệnh nhân
            try
            {
                DTO.BenhNhan benh = new DTO.BenhNhan(
                    tbCCCD.Text,
                    tbFirstName.Text,
                    tbLastName.Text,
                    cbSex.Text,
                    tbdc.Text,
                    tbjob.Text,
                    tbsdt.Text,
                    new DateTime(Int32.Parse(tbYear.Text), Int32.Parse(tbMonth.Text), Int32.Parse(tbDay.Text))
                );

                string text = BLL.Rec_AddPatient.ThemBenhNhan(benh);
                MessageBox.Show(text);
                rechand();
                this.Close();
            }
            catch (Exception ex)
            {
                lblError.Text = "Đã xảy ra lỗi: " + ex.Message;
            }
        }




        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }


    }
}
