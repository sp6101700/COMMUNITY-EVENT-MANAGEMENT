using System;
using MySql.Data.MySqlClient;
using CommunityEvents.App_Code;

public partial class Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e) { }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid) return;

        string name  = txtName.Text.Trim();
        string email = txtEmail.Text.Trim();
        string pass  = txtPassword.Text.Trim();
        string phone = txtPhone.Text.Trim();

        // Check duplicate email
        object existing = DBHelper.ExecuteScalar(
            "SELECT COUNT(*) FROM users WHERE Email=@email",
            new MySqlParameter("@email", email));

        if (Convert.ToInt32(existing) > 0)
        {
            pnlMsg.Visible   = true;
            pnlMsg.CssClass  = "alert alert-danger";
            pnlMsg.Controls.Clear();
            pnlMsg.Controls.Add(new System.Web.UI.LiteralControl(
                "<i class='fas fa-exclamation-circle mr-2'></i>This email is already registered."));
            return;
        }

        string sql = @"INSERT INTO users (FullName,Email,Password,Phone,Role)
                       VALUES(@name,@email,@pass,@phone,'Member')";
        DBHelper.ExecuteNonQuery(sql,
            new MySqlParameter("@name",  name),
            new MySqlParameter("@email", email),
            new MySqlParameter("@pass",  pass),
            new MySqlParameter("@phone", phone));

        pnlMsg.Visible  = true;
        pnlMsg.CssClass = "alert alert-success";
        pnlMsg.Controls.Clear();
        pnlMsg.Controls.Add(new System.Web.UI.LiteralControl(
            "<i class='fas fa-check-circle mr-2'></i>Account created! <a href='Login.aspx'>Click here to login.</a>"));

        txtName.Text = txtEmail.Text = txtPassword.Text = txtConfirmPwd.Text = txtPhone.Text = "";
    }
}
