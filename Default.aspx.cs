using System;
using System.Data;
using CommunityEvents.App_Code;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadStats();
            LoadEvents();
            LoadAnnouncement();
        }
    }

    private void LoadStats()
    {
         lblTotalEvents.Text = DBHelper.ExecuteScalar("SELECT COUNT(*) FROM events").ToString();
        lblUpcomingEvents.Text= DBHelper.ExecuteScalar("SELECT COUNT(*) FROM events WHERE Status='Upcoming'").ToString();
        lblTotalMembers.Text  = DBHelper.ExecuteScalar("SELECT COUNT(*) FROM users WHERE Role='Member'").ToString();
        lblTotalRegs.Text     = DBHelper.ExecuteScalar("SELECT COUNT(*) FROM registrations WHERE Status='Registered'").ToString();
    }

    private void LoadEvents()
    {
        string sql = @"SELECT e.*, c.CategoryName FROM events e
                       LEFT JOIN categories c ON e.CategoryID=c.CategoryID
                       WHERE e.Status='Upcoming' AND e.EventDate >= CURDATE()
                       ORDER BY e.EventDate ASC LIMIT 6";
        DataTable dt = DBHelper.GetDataTable(sql);
        if (dt.Rows.Count > 0)
        {
            rptEvents.DataSource = dt;
            rptEvents.DataBind();
        }
        else
        {
            pnlNoEvents.Visible = true;
        }
    }

    private void LoadAnnouncement()
    {
        string sql = "SELECT * FROM announcements WHERE IsActive=1 ORDER BY PostedAt DESC LIMIT 1";
        DataTable dt = DBHelper.GetDataTable(sql);
        if (dt.Rows.Count > 0)
        {
            pnlAnn.Visible   = true;
            lblAnnTitle.Text  = dt.Rows[0]["Title"].ToString();
            lblAnnContent.Text= dt.Rows[0]["Content"].ToString();
        }
    }
}
