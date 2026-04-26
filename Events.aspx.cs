using System;
using System.Data;
using System.Collections.Generic;
using MySql.Data.MySqlClient;
using CommunityEvents.App_Code;

public partial class Events : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadCategories();
            LoadEvents();
        }
    }

    private void LoadCategories()
    {
        DataTable dt = DBHelper.GetDataTable("SELECT * FROM categories ORDER BY CategoryName");
        ddlCategory.Items.Clear();
        ddlCategory.Items.Add(new System.Web.UI.WebControls.ListItem("All Categories", ""));
        foreach (DataRow row in dt.Rows)
            ddlCategory.Items.Add(new System.Web.UI.WebControls.ListItem(
                row["CategoryName"].ToString(), row["CategoryID"].ToString()));
    }

    private void LoadEvents()
    {
        var where = new List<string>();
        var parms = new List<MySqlParameter>();

        if (!string.IsNullOrEmpty(ddlCategory.SelectedValue))
        {
            where.Add("e.CategoryID=@cat");
            parms.Add(new MySqlParameter("@cat", ddlCategory.SelectedValue));
        }
        if (!string.IsNullOrEmpty(ddlStatus.SelectedValue))
        {
            where.Add("e.Status=@status");
            parms.Add(new MySqlParameter("@status", ddlStatus.SelectedValue));
        }
        if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
        {
            where.Add("e.Title LIKE @search");
            parms.Add(new MySqlParameter("@search", "%" + txtSearch.Text.Trim() + "%"));
        }

        string whereClause = where.Count > 0 ? "WHERE " + string.Join(" AND ", where) : "";
        string sql = "SELECT e.*, c.CategoryName FROM events e " +
                     "LEFT JOIN categories c ON e.CategoryID=c.CategoryID " +
                     whereClause + " ORDER BY e.EventDate ASC";

        DataTable dt = DBHelper.GetDataTable(sql, parms.ToArray());
        lblResultCount.Text = "Showing <strong>" + dt.Rows.Count + "</strong> event(s)";

        if (dt.Rows.Count > 0)
        {
            rptAllEvents.DataSource = dt;
            rptAllEvents.DataBind();
            pnlNone.Visible = false;
        }
        else
        {
            rptAllEvents.DataSource = null;
            rptAllEvents.DataBind();
            pnlNone.Visible = true;
        }
    }

    protected void Filter_Changed(object sender, EventArgs e) { LoadEvents(); }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        ddlCategory.SelectedIndex = 0;
        ddlStatus.SelectedIndex = 0;
        txtSearch.Text = "";
        LoadEvents();
    }

    public string GetBadgeClass(string status)
    {
        switch (status)
        {
            case "Upcoming": return "badge-upcoming";
            case "Completed": return "badge-completed";
            case "Cancelled": return "badge-cancelled";
            case "Ongoing": return "badge-ongoing";
            default: return "badge-upcoming";
        }
    }
}
