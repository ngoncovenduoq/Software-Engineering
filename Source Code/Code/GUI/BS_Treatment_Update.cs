using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Xml.Linq;

namespace Project_CNPM
{
    public partial class BS_Treatment_Update : Form
    {
        private string ten;
        private string soluong;
        public delegate void BS_Treatment_UpdateEventHandler(string text1,string text2);
        public BS_Treatment_UpdateEventHandler bS_Treatment_UpdateEventHandler;
        public delegate void BS_Treatment_UpdateEvent(string text1, string text2,string text3);
        public BS_Treatment_UpdateEvent bS_Treatment_UpdateEvent;
        private int trangthai;
        public BS_Treatment_Update()
        {
            InitializeComponent();
        }

        public void ChangeLanguage(string language)
        {
            if (language == "Vietnam")
            {
                label1.Text = "Cập Nhật";
                lbName.Text = "Tên";
                lbQuantity.Text = "Số lượng";
                btnDone.Text = "Xác nhận";
            }
            else
            {
                label1.Text = "Update";
                lbName.Text = "Name";
                lbQuantity.Text = "Quantity";
                btnDone.Text = "Done";
            }
        }

        public BS_Treatment_Update(string ten,string soluong)
        {
            InitializeComponent();
            this.ten = ten;
            this.soluong = soluong;
            tbName.Text = this.ten;
            tbName.Enabled = false;
            tbQuantity.Text = this.soluong;
            trangthai = 0;
        }
        public void change()
        {
            trangthai = 1;
    
        }

        private void btnDone_Click(object sender, EventArgs e)
        {
            // Kiểm tra định dạng của số lượng nhập vào
            if (BLL.CheckTextBox.KiemTraSo(tbQuantity.Text))
            {
                if (tbQuantity.Text.Length != 0)
                {
                    // Nếu trạng thái chỉnh sửa cơ bản
                    if (trangthai == 0 && bS_Treatment_UpdateEventHandler != null)
                    {
                        bS_Treatment_UpdateEventHandler(ten, tbQuantity.Text); // Gửi tên và số lượng mới qua delegate
                    }
                    // Nếu trạng thái chỉnh sửa nâng cao
                    else if (trangthai == 1 && bS_Treatment_UpdateEvent != null)
                    {
                        bS_Treatment_UpdateEvent(ten, tbQuantity.Text, ""); 
                    }
                    this.Close();
                }
                else
                {
                    MessageBox.Show("Vui lòng nhập số lượng hợp lệ.", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
            }
            else
            {
                MessageBox.Show("Số lượng phải là số nguyên.", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }


        private void label3_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnHuy_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
