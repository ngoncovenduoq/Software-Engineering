using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Project_CNPM
{
    public partial class ChangePassword : Form
    {
        SqlConnection conn = new SqlConnection(@"");  
        SqlCommand cmd = new SqlCommand();
        public ChangePassword()
        {
            InitializeComponent();
        }

        private void eye1_Click(object sender, EventArgs e)
        {
            if (tbPassword1.PasswordChar == '\0')
            {
                eye2.BringToFront();
                tbPassword1.PasswordChar = '*';

            }
        }
        private void eye2_Click(object sender, EventArgs e)
        {
            if (tbPassword1.PasswordChar == '*')
            {
                eye1.BringToFront();
                tbPassword1.PasswordChar = '\0';

            }
        }

        private void eye3_Click(object sender, EventArgs e)
        {
            if (tbPassword2.PasswordChar == '\0')
            {
                eye4.BringToFront();
                tbPassword2.PasswordChar = '*';

            }
        }

        private void eye4_Click(object sender, EventArgs e)
        {
            if (tbPassword2.PasswordChar == '*')
            {
                eye3.BringToFront();
                tbPassword2.PasswordChar = '\0';

            }
        }

        private void comeBack_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            Login login = new Login();
            login.Show();
            this.Hide();
        }

        private void btnConfirm_Click(object sender, EventArgs e)
        {
            // Kiểm tra nếu mật khẩu cũ và mới chưa được nhập đầy đủ
            if (string.IsNullOrWhiteSpace(tbPassword1.Text) || string.IsNullOrWhiteSpace(tbPassword2.Text))
            {
                lblMessage.Text = "Vui lòng nhập đầy đủ thông tin, mật khẩu ít nhất 6 ký tự.";
                return;
            }

            // Kiểm tra nếu hai mật khẩu mới và cũ giống nhau
            if (tbPassword1.Text.Equals(tbPassword2.Text))
            {
                lblMessage.Text = "Vui lòng nhập mật khẩu mới khác mật khẩu cũ.";
                return;
            }

            // Gọi phương thức Change để xử lý mật khẩu
            string result = BLL.ChangePassword.Change(tbPassword1.Text, tbPassword2.Text);

            // Hiển thị kết quả trên Label
            lblMessage.Text = result;
        }



        private void label1_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
