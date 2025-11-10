using Project_CNPM;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class ChangePassword
    {
        public static string Change(string pass, string passnew)
        {
            if (string.IsNullOrWhiteSpace(pass) || string.IsNullOrWhiteSpace(passnew))
            {
                return "Vui lòng nhập đầy đủ thông tin và mật khẩu dài ít nhất 6 ký tự";
            }
            if (pass.Equals(passnew))
            {
                return "Vui lòng nhập mật khẩu mới khác mật khẩu cũ";
            }
            return DAL.ChangePassword.Check(Static.getUser().GetMaNhanVien(), pass, passnew);
        }
    }
}
