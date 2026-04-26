   using System;
using System.Data;
using MySql.Data.MySqlClient;
using CommunityEvents.App_Code;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text.Trim();
        string pass  = txtPassword.Text.Trim();

        string sql = "SELECT * FROM users WHERE Email='" + email + "'AND Password='" + pass + "'" ;
        DataTable dt = DBHelper.GetDataTable(sql,
            new MySqlParameter("@email", email),
            new MySqlParameter("@pass",  pass));

        if (dt.Rows.Count == 1)
        {
            DataRow row = dt.Rows[0];
            Session["UserID"]   = row["UserID"].ToString();
            Session["UserName"] = row["FullName"].ToString();
            Session["Email"]    = row["Email"].ToString();
            Session["Role"]     = row["Role"].ToString();

            if (row["Role"].ToString() == "Admin")
                Response.Redirect("~/Admin/Dashboard.aspx",false);
            else
                Response.Redirect("~/Default.aspx");
        }
        else
        {
            pnlError.Visible = true;
            lblError.Text    = "Invalid email or password. Please try again.";
        }
    }
}
