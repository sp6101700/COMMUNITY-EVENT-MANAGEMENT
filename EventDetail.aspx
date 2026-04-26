<%@ Page Title="Event Details" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="EventDetail.aspx.cs" Inherits="EventDetail" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
<div class="container mt-4">
    <div class="row">
        <div class="col-md-8">
            <div class="form-card mb-4">
                <asp:Panel ID="pnlMsg" runat="server" Visible="false"></asp:Panel>

                <!-- Event Header -->
                <div class="d-flex justify-content-between align-items-start mb-3">
                    <div>
                        <span class="badge-status badge-upcoming" id="spnStatus" runat="server"></span>
                        <span class="cat-pill ml-2" id="spnCategory" runat="server"></span>
                    </div>
                    <a href="Events.aspx" class="btn btn-outline-secondary btn-sm">
                        <i class="fas fa-arrow-left mr-1"></i>Back
                    </a>
                </div>

                <h2 style="font-family:'Playfair Display',serif;color:var(--primary);">
                    <asp:Label ID="lblTitle" runat="server"></asp:Label>
                </h2>
                <p class="text-muted mt-2">
                    <asp:Label ID="lblDescription" runat="server"></asp:Label>
                </p>
                <hr/>

                <div class="row">
                    <div class="col-md-6">
                        <p><i class="fas fa-calendar-day text-danger fa-fw mr-2"></i>
                            <strong>Date:</strong> <asp:Label ID="lblDate" runat="server"></asp:Label></p>
                        <p><i class="fas fa-clock text-primary fa-fw mr-2"></i>
                            <strong>Time:</strong> <asp:Label ID="lblTime" runat="server"></asp:Label></p>
                        <p><i class="fas fa-map-marker-alt text-success fa-fw mr-2"></i>
                            <strong>Venue:</strong> <asp:Label ID="lblVenue" runat="server"></asp:Label></p>
                    </div>
                    <div class="col-md-6">
                        <p><i class="fas fa-city text-info fa-fw mr-2"></i>
                            <strong>City:</strong> <asp:Label ID="lblCity" runat="server"></asp:Label></p>
                        <p><i class="fas fa-users text-warning fa-fw mr-2"></i>
                            <strong>Capacity:</strong> <asp:Label ID="lblCapacity" runat="server"></asp:Label></p>
                        <p><i class="fas fa-ticket-alt fa-fw mr-2" style="color:var(--accent);"></i>
                            <strong>Price:</strong> <asp:Label ID="lblPrice" runat="server"></asp:Label></p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Registration Panel -->
        <div class="col-md-4">
            <div class="sidebar-card text-center">
                <div style="font-size:3rem;margin-bottom:10px;">🎫</div>
                <h5 style="color:var(--primary);font-weight:700;">Reserve Your Spot</h5>
                <p class="text-muted small mb-3">
                    <asp:Label ID="lblSpotsLeft" runat="server"></asp:Label>
                </p>
                <div class="mb-3">
                    <div class="stat-num" style="font-size:1.8rem;color:var(--accent);">
                        <asp:Label ID="lblPriceTag" runat="server"></asp:Label>
                    </div>
                </div>

                <asp:Panel ID="pnlRegister" runat="server">
                    <asp:Button ID="btnRegister" runat="server" Text="Register for this Event"
                        CssClass="btn btn-primary-custom btn-block" OnClick="btnRegister_Click"/>
                </asp:Panel>

                <asp:Panel ID="pnlAlreadyReg" runat="server" Visible="false">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle mr-2"></i>You are registered!
                    </div>
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel Registration"
                        CssClass="btn btn-outline-danger btn-sm btn-block" OnClick="btnCancel_Click"/>
                </asp:Panel>

                <asp:Panel ID="pnlNotLoggedIn" runat="server" Visible="false">
                    <div class="alert alert-warning small">
                        <i class="fas fa-info-circle mr-1"></i>
                        Please <a href="Login.aspx">login</a> to register.
                    </div>
                </asp:Panel>
            </div>

            <!-- Attendees Count -->
            <div class="sidebar-card mt-3">
                <h6><i class="fas fa-user-friends mr-2 text-primary"></i>Attendees</h6>
                <div class="progress" style="height:12px;border-radius:10px;">
                    <div class="progress-bar" id="progBar" runat="server" role="progressbar" style="background:var(--accent);border-radius:10px;"></div>
                </div>
                <p class="text-muted small mt-2">
                    <asp:Label ID="lblAttendeeCount" runat="server"></asp:Label>
                </p>
            </div>
        </div>
    </div>
</div>
</asp:Content>
