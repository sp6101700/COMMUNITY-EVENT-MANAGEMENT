using System;
using System.Data;
using MySql.Data.MySqlClient;
using CommunityEvents.App_Code;

public partial class EventDetail : System.Web.UI.Page
{
    private int eventId;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!int.TryParse(Request.QueryString["id"], out eventId))
        { Response.Redirect("~/Events.aspx"); return; }

        if (!IsPostBack) LoadEvent();
    }

    private void LoadEvent()
    {
        string sql = "SELECT e.*, c.CategoryName, c.ColorCode FROM events e " +
                     "LEFT JOIN categories c ON e.CategoryID=c.CategoryID " +
                     "WHERE e.EventID=@id";
        DataTable dt = DBHelper.GetDataTable(sql, new MySqlParameter("@id", eventId));

        if (dt.Rows.Count == 0) { Response.Redirect("~/Events.aspx"); return; }

        DataRow r = dt.Rows[0];
        lblTitle.Text = r["Title"].ToString();
        lblDescription.Text = r["Description"].ToString();
        lblDate.Text = Convert.ToDateTime(r["EventDate"]).ToString("dddd, MMMM dd yyyy");
        lblTime.Text = r["StartTime"].ToString() + " - " + r["EndTime"].ToString();
        lblVenue.Text = r["Venue"].ToString();
        lblCity.Text = r["City"].ToString();
        lblCapacity.Text = r["MaxCapacity"].ToString();

        decimal price = Convert.ToDecimal(r["TicketPrice"]);
        lblPrice.Text = price == 0 ? "FREE" : "Rs" + price.ToString("F2");
        lblPriceTag.Text = price == 0 ? "FREE" : "Rs" + price.ToString("F2");

        spnStatus.InnerText = r["Status"].ToString();
        spnCategory.InnerText = r["CategoryName"].ToString();
        spnCategory.Style["background"] = r["ColorCode"].ToString();

        // Attendee count
        int regCount = Convert.ToInt32(DBHelper.ExecuteScalar(
            "SELECT COUNT(*) FROM registrations WHERE EventID=@id AND Status='Registered'",
            new MySqlParameter("@id", eventId)));
        int maxCap = Convert.ToInt32(r["MaxCapacity"]);
        int pct = maxCap > 0 ? Math.Min(100, (int)((double)regCount / maxCap * 100)) : 0;

        lblAttendeeCount.Text = regCount.ToString() + " registered out of " + maxCap.ToString() + " spots";
        lblSpotsLeft.Text = (maxCap - regCount).ToString() + " spots remaining";
        progBar.Style["width"] = pct.ToString() + "%";
        progBar.Attributes["aria-valuenow"] = pct.ToString();

        // Registration state
        if (Session["UserID"] == null)
        {
            pnlRegister.Visible = false;
            pnlNotLoggedIn.Visible = true;
        }
        else
        {
            int uid = Convert.ToInt32(Session["UserID"]);
            bool already = Convert.ToInt32(DBHelper.ExecuteScalar(
                "SELECT COUNT(*) FROM registrations WHERE EventID=@eid AND UserID=@uid AND Status='Registered'",
                new MySqlParameter("@eid", eventId), new MySqlParameter("@uid", uid))) > 0;

            pnlAlreadyReg.Visible = already;
            pnlRegister.Visible = !already;
        }
    }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if (Session["UserID"] == null) { Response.Redirect("~/Login.aspx"); return; }
        int uid = Convert.ToInt32(Session["UserID"]);

        try
        {
            DBHelper.ExecuteNonQuery(
                "INSERT INTO registrations (EventID,UserID) VALUES(@eid,@uid)",
                new MySqlParameter("@eid", eventId),
                new MySqlParameter("@uid", uid));

            ShowMsg("success", "You have successfully registered for this event!");
        }
        catch
        {
            ShowMsg("danger", "You are already registered or an error occurred.");
        }

        LoadEvent();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        if (Session["UserID"] == null) return;
        int uid = Convert.ToInt32(Session["UserID"]);

        DBHelper.ExecuteNonQuery(
            "UPDATE registrations SET Status='Cancelled' WHERE EventID=@eid AND UserID=@uid",
            new MySqlParameter("@eid", eventId),
            new MySqlParameter("@uid", uid));

        ShowMsg("warning", "Your registration has been cancelled.");
        LoadEvent();
    }

    private void ShowMsg(string type, string msg)
    {
        pnlMsg.Visible = true;
        pnlMsg.CssClass = "alert alert-" + type;
        pnlMsg.Controls.Clear();
        pnlMsg.Controls.Add(new System.Web.UI.LiteralControl(msg));
    }
}
