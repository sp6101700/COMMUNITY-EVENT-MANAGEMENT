<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server"/>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Hero Banner -->
    <div class="hero-banner">
        <div class="container">
            <h1><i class="fas fa-calendar-star mr-2"></i>Community Events Hub</h1>
            <p>Discover, join, and celebrate local events that bring your community together.</p>
            <a href="Events.aspx" class="btn btn-primary-custom btn-lg mr-3">
                <i class="fas fa-search mr-2"></i>Explore Events
            </a>
            <a href="Register.aspx" class="btn btn-outline-light btn-lg">
                <i class="fas fa-user-plus mr-2"></i>Join Free
            </a>
        </div>
    </div>

    <div class="container">

        <!-- Stats Row -->
        <div class="row mt-4 mb-4" id="statsRow" runat="server">
            <div class="col-md-3 col-6 mb-3">
                <div class="stat-card">
                    <div class="stat-num text-primary">
                        <asp:Label ID="lblTotalEvents" runat="server">0</asp:Label>
                    </div>
                    <div class="stat-label"><i class="fas fa-calendar text-primary mr-1"></i>Total Events</div>
                </div>
            </div>
            <div class="col-md-3 col-6 mb-3">
                <div class="stat-card" style="border-left-color:#28a745;">
                    <div class="stat-num" style="color:#28a745;">
                        <asp:Label ID="lblUpcomingEvents" runat="server">0</asp:Label>
                    </div>
                    <div class="stat-label"><i class="fas fa-clock mr-1" style="color:#28a745;"></i>Upcoming</div>
                </div>
            </div>
            <div class="col-md-3 col-6 mb-3">
                <div class="stat-card" style="border-left-color:#f5a623;">
                    <div class="stat-num" style="color:#f5a623;">
                        <asp:Label ID="lblTotalMembers" runat="server">0</asp:Label>
                    </div>
                    <div class="stat-label"><i class="fas fa-users mr-1" style="color:#f5a623;"></i>Members</div>
                </div>
            </div>
            <div class="col-md-3 col-6 mb-3">
                <div class="stat-card" style="border-left-color:#17a2b8;">
                    <div class="stat-num" style="color:#17a2b8;">
                        <asp:Label ID="lblTotalRegs" runat="server">0</asp:Label>
                    </div>
                    <div class="stat-label"><i class="fas fa-ticket-alt mr-1" style="color:#17a2b8;"></i>Registrations</div>
                </div>
            </div>
        </div>

        <!-- Alert Box -->
        <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert alert-info alert-dismissible" role="alert">
            <button type="button" class="close" data-dismiss="alert">&times;</button>
            <asp:Label ID="lblAlert" runat="server"></asp:Label>
        </asp:Panel>

        <!-- Announcement -->
        <asp:Panel ID="pnlAnn" runat="server" Visible="false" CssClass="alert" style="background:linear-gradient(135deg,#1a1a2e,#16213e);color:#fff;border-radius:12px;padding:18px 24px;">
            <i class="fas fa-bullhorn mr-2" style="color:#f5a623;"></i>
            <asp:Label ID="lblAnnTitle" runat="server" CssClass="font-weight-bold"></asp:Label> —
            <asp:Label ID="lblAnnContent" runat="server"></asp:Label>
        </asp:Panel>

        <!-- Upcoming Events Section -->
        <div class="d-flex justify-content-between align-items-center mt-4 mb-2">
            <div>
                <div class="section-title">Upcoming Events</div>
                <div class="section-divider"></div>
            </div>
            <a href="Events.aspx" class="btn btn-outline-custom">View All <i class="fas fa-arrow-right ml-1"></i></a>
        </div>

        <asp:Repeater ID="rptEvents" runat="server">
            <HeaderTemplate><div class="row"></HeaderTemplate>
            <ItemTemplate>
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="event-card card h-100">
                        <div class="card-header">
                            <div class="d-flex justify-content-between align-items-start">
                                <h5><%# Eval("Title") %></h5>
                                <span class="badge-status badge-upcoming ml-2"><%# Eval("Status") %></span>
                            </div>
                            <small style="color:rgba(255,255,255,.7);">
                                <i class="fas fa-tag mr-1"></i><%# Eval("CategoryName") %>
                            </small>
                        </div>
                        <div class="card-body">
                            <p class="text-muted small mb-3"><%# Eval("Description") %></p>
                            <p class="mb-1"><i class="fas fa-calendar-day text-danger mr-2"></i>
                                <strong><%# Convert.ToDateTime(Eval("EventDate")).ToString("MMMM dd, yyyy") %></strong>
                            </p>
                            <p class="mb-1"><i class="fas fa-clock text-primary mr-2"></i>
                                <%# Eval("StartTime") %> - <%# Eval("EndTime") %>
                            </p>
                            <p class="mb-1"><i class="fas fa-map-marker-alt text-success mr-2"></i>
                                <%# Eval("Venue") %>, <%# Eval("City") %>
                            </p>
                            <p class="mb-0"><i class="fas fa-users text-warning mr-2"></i>
                                Capacity: <%# Eval("MaxCapacity") %>
                            </p>
                        </div>
                        <div class="card-footer bg-white border-top-0 pb-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="font-weight-bold" style="color:var(--accent);">
                                    <%# Convert.ToDecimal(Eval("TicketPrice")) == 0 ? "FREE" : "$" + Eval("TicketPrice") %>
                                </span>
                                <a href='EventDetail.aspx?id=<%# Eval("EventID") %>' class="btn btn-primary-custom btn-sm">
                                    <i class="fas fa-info-circle mr-1"></i>Details
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
            <FooterTemplate></div></FooterTemplate>
        </asp:Repeater>

        <asp:Panel ID="pnlNoEvents" runat="server" Visible="false" CssClass="text-center py-5">
            <i class="fas fa-calendar-times fa-4x text-muted mb-3"></i>
            <h4 class="text-muted">No upcoming events found.</h4>
            <a href="Admin/AddEvent.aspx" class="btn btn-primary-custom mt-2">Add First Event</a>
        </asp:Panel>

    </div>
</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
<script>
    // Animate stats on load
    $(document).ready(function(){
        $('.stat-num').each(function(){
            var $this = $(this);
            var target = parseInt($this.text());
            $({count:0}).animate({count:target},{duration:1200,easing:'swing',
                step:function(){ $this.text(Math.floor(this.count)); },
                complete:function(){ $this.text(target); }
            });
        });
    });
</script>
</asp:Content>
