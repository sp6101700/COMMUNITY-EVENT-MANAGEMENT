<%@ Page Title="All Events" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Events.aspx.cs" Inherits="Events" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
<div style="background:linear-gradient(135deg,var(--primary),#0f3460);color:#fff;padding:35px 0 25px;">
    <div class="container">
        <h2><i class="fas fa-calendar-alt mr-2"></i>All Community Events</h2>
        <p class="mb-0 text-white-50">Find and join events happening near you</p>
    </div>
</div>
<div class="container mt-4">
    <div class="row">
        <!-- Sidebar Filters -->
        <div class="col-md-3 mb-4">
            <div class="sidebar-card">
                <h6><i class="fas fa-filter mr-1"></i>Filter Events</h6>
                <div class="form-group">
                    <label class="small font-weight-bold">Category</label>
                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control form-control-sm"
                        AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed"/>
                </div>
                <div class="form-group">
                    <label class="small font-weight-bold">Status</label>
                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control form-control-sm"
                        AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
                        <asp:ListItem Value="">All Status</asp:ListItem>
                        <asp:ListItem Value="Upcoming">Upcoming</asp:ListItem>
                        <asp:ListItem Value="Ongoing">Ongoing</asp:ListItem>
                        <asp:ListItem Value="Completed">Completed</asp:ListItem>
                        <asp:ListItem Value="Cancelled">Cancelled</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label class="small font-weight-bold">Search</label>
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control form-control-sm"
                        placeholder="Event name..." onkeyup="__doPostBack('txtSearch','')" ></asp:TextBox>
                </div>
                <asp:Button ID="btnSearch" runat="server" Text="Apply Filters"
                    CssClass="btn btn-primary-custom btn-sm btn-block" OnClick="Filter_Changed"/>
                <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-outline-secondary btn-sm btn-block mt-2" OnClick="btnClear_Click"/>
            </div>
        </div>

        <!-- Events Grid -->
        <div class="col-md-9">
            <asp:Label ID="lblResultCount" runat="server" CssClass="text-muted small"></asp:Label>

            <asp:Repeater ID="rptAllEvents" runat="server">
                <HeaderTemplate><div class="row"></HeaderTemplate>
                <ItemTemplate>
                    <div class="col-md-6 mb-4">
                        <div class="event-card card h-100">
                            <div class="card-header">
                                <div class="d-flex justify-content-between">
                                    <h5 class="mb-1"><%# Eval("Title") %></h5>
                                    <span class='badge-status <%# GetBadgeClass(Eval("Status").ToString()) %>'><%# Eval("Status") %></span>
                                </div>
                                <small style="color:rgba(255,255,255,.7);"><i class="fas fa-tag mr-1"></i><%# Eval("CategoryName") %></small>
                            </div>
                            <div class="card-body">
                                <p class="text-muted small mb-2"><%# Eval("Description") %></p>
                                <p class="mb-1 small"><i class="fas fa-calendar-day text-danger mr-2"></i><%# Convert.ToDateTime(Eval("EventDate")).ToString("ddd, MMM dd yyyy") %></p>
                                <p class="mb-1 small"><i class="fas fa-clock text-primary mr-2"></i><%# Eval("StartTime") %> – <%# Eval("EndTime") %></p>
                                <p class="mb-1 small"><i class="fas fa-map-marker-alt text-success mr-2"></i><%# Eval("Venue") %>, <%# Eval("City") %></p>
                                <p class="mb-0 small"><i class="fas fa-users text-info mr-2"></i>Capacity: <%# Eval("MaxCapacity") %></p>
                            </div>
                            <div class="card-footer bg-white border-top-0">
                                <div class="d-flex justify-content-between align-items-center">
                                    <strong style="color:var(--accent);">
                                        <%# Convert.ToDecimal(Eval("TicketPrice"))==0 ? "🎟 FREE" : "$"+Eval("TicketPrice") %>
                                    </strong>
                                    <a href='EventDetail.aspx?id=<%# Eval("EventID") %>' class="btn btn-primary-custom btn-sm">
                                        View Details
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
                <FooterTemplate></div></FooterTemplate>
            </asp:Repeater>

            <asp:Panel ID="pnlNone" runat="server" Visible="false" CssClass="text-center py-5">
                <i class="fas fa-search fa-3x text-muted mb-3"></i>
                <h5 class="text-muted">No events found matching your criteria.</h5>
            </asp:Panel>
        </div>
    </div>
</div>
</asp:Content>
