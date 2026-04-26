using System;
using System.Web.Security;
using System.Web.UI;

public partial class Site : MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] != null)
        {
            pnlLoggedIn.Visible  = true;
            pnlLoggedOut.Visible = false;
            lblUserName.Text     = Session["UserName"].ToString();

            pnlMemberNav.Visible = true;
            if (Session["Role"] != null && Session["Role"].ToString() == "Admin")
                pnlAdminNav.Visible = true;
        }
        else
        {
            pnlLoggedIn.Visible  = false;
            pnlLoggedOut.Visible = true;
            pnlMemberNav.Visible = false;
            pnlAdminNav.Visible  = false;
        }
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Session.Abandon();
        Response.Redirect("~/Default.aspx");
    }
}
