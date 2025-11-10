using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class ForgotPassword
    {
        private int rand;
        private string user;
        public ForgotPassword()
        {
            this.rand = 0;
            this.user = null;
        }
        private void Random()
        {
            this.rand = new Random().Next(10000, 99999);
        }
        public string KiemTra(string username, string email)
        {
            if (username.Equals("Tên tài khoản") || username.Length == 0)
            {
                return "Vui lòng nhập tài khoản";
            }
            if (email.Equals("Email") || email.Length == 0)
            {
                return "Vui lòng nhập email";
            }


            string check = DAL.ForgotPassword.KiemTra(username, email);
            if (!check.Equals("Thành công"))
            {
                return check;

            }
            this.user = username;
            Random();
            MailMessage message = new MailMessage();
            message.To.Add(new MailAddress(email));
            message.From = new MailAddress("technopent@gmail.com");
            message.Subject = "Mail khôi phục mật khẩu";
            message.IsBodyHtml = true;
            message.Body = $@"
    <html>
    <body style='font-family: Arial, sans-serif; line-height: 1.6; color: #333;'>
        <h2 style='color: #0066cc;'>Thông báo từ Phòng Khám Răng Hàm Mặt</h2>
        <p>Xin chào,</p>
        <p>Bạn đã yêu cầu quên mật khẩu. Đây là mã xác nhận để tiếp tục:</p>
        <h3 style='color: #cc0000;'>{rand.ToString()}</h3>
        <p>Nếu bạn không yêu cầu quên mật khẩu, vui lòng bỏ qua email này hoặc liên hệ với chúng tôi để được hỗ trợ.</p>
        <p>Trân trọng,</p>
        <p><strong>Phòng Khám Răng Hàm Mặt</strong></p>
        <hr />
        <p style='font-size: 0.9em; color: #666;'>Lưu ý: Đây là email tự động, vui lòng không trả lời email này.</p>
    </body>
    </html>";
            SmtpClient smtpClient = new SmtpClient("smtp.gmail.com");
            smtpClient.EnableSsl = true;
            smtpClient.Port = 587;
            smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
            smtpClient.Credentials = new NetworkCredential("technopent@gmail.com", "qzgk mynh blvs tgww");
            try
            {
                smtpClient.Send(message);
            }
            catch
            {
                return "Gửi mail không thành công";
            }


            return "Đã gửi email";
        }
        public string Code(string code)
        {
            if (!code.Equals(rand.ToString()))
            {
                return "Nhập sai mã xác nhận";
            }

            DAL.ForgotPassword.Code(user);
            return "Khôi phục mật khẩu thành công";
        }
    }
}
