using System;
using System.Data;
using MySql.Data.MySqlClient;
using CommunityEvents.App_Code;

public partial class MyRegistrations : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null) { Response.Redirect("~/Login.aspx"); return; }
        if (!IsPostBack) LoadMyRegs();
    }

    private void LoadMyRegs()
    {
        int uid = Convert.ToInt32(Session["UserID"]);
        string sql = @"SELECT r.RegID, r.RegDate, r.Status AS RegStatus,
                              e.EventID, e.Title, e.EventDate, e.Venue, e.TicketPrice,
                              c.CategoryName
                       FROM registrations r
                       JOIN events e ON r.EventID=e.EventID
                       LEFT JOIN categories c ON e.CategoryID=c.CategoryID
                       WHERE r.UserID=@uid
                       ORDER BY e.EventDate DESC";

        DataTable dt = DBHelper.GetDataTable(sql, new MySqlParameter("@uid", uid));
        if (dt.Rows.Count > 0)
        {
            rptMyRegs.DataSource = dt;
            rptMyRegs.DataBind();
        }
        else
        {
            pnlNone.Visible = true;
        }
    }
}
