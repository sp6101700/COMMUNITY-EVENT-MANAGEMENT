<%@ Page Title="My Events" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="MyRegistrations.aspx.cs" Inherits="MyRegistrations" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
<div style="background:linear-gradient(135deg,#1a1a2e,#16213e);color:#fff;padding:30px 0 20px;">
    <div class="container">
        <h2><i class="fas fa-ticket-alt mr-2"></i>My Registered Events</h2>
        <p class="mb-0 text-white-50">Track your event registrations here</p>
    </div>
</div>
<div class="container mt-4">
    <asp:Panel ID="pnlMsg" runat="server" Visible="false"></asp:Panel>

    <div class="table-responsive table-custom">
        <table class="table mb-0">
            <thead>
                <tr>
                    <th>#</th><th>Event</th><th>Date</th><th>Venue</th>
                    <th>Price</th><th>Reg Date</th><th>Status</th><th>Action</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptMyRegs" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td><%# Container.ItemIndex + 1 %></td>
                            <td>
                                <strong><%# Eval("Title") %></strong><br/>
                                <small class="text-muted"><%# Eval("CategoryName") %></small>
                            </td>
                            <td><%# Convert.ToDateTime(Eval("EventDate")).ToString("MMM dd, yyyy") %></td>
                            <td><%# Eval("Venue") %></td>
                            <td>
                                <span style="color:var(--accent);font-weight:600;">
                                    <%# Convert.ToDecimal(Eval("TicketPrice"))==0 ? "FREE" : "$"+Eval("TicketPrice") %>
                                </span>
                            </td>
                            <td><%# Convert.ToDateTime(Eval("RegDate")).ToString("MMM dd, yyyy") %></td>
                            <td>
                                <span class='badge-status <%# Eval("RegStatus").ToString()=="Registered" ? "badge-upcoming" : "badge-cancelled" %>'>
                                    <%# Eval("RegStatus") %>
                                </span>
                            </td>
                            <td>
                                <a href='EventDetail.aspx?id=<%# Eval("EventID") %>' class="btn btn-sm btn-outline-primary">View</a>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>

    <asp:Panel ID="pnlNone" runat="server" Visible="false" CssClass="text-center py-5">
        <i class="fas fa-ticket-alt fa-3x text-muted mb-3"></i>
        <h5 class="text-muted">You haven't registered for any events yet.</h5>
        <a href="Events.aspx" class="btn btn-primary-custom mt-2">Browse Events</a>
    </asp:Panel>
</div>
</asp:Content>
