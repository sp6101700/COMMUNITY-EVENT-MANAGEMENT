<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
<div class="container">
    <div class="row justify-content-center mt-5">
        <div class="col-md-5">
            <div class="text-center mb-4">
                <div style="width:75px;height:75px;background:linear-gradient(135deg,var(--primary),var(--accent));border-radius:50%;display:inline-flex;align-items:center;justify-content:center;margin-bottom:15px;">
                    <i class="fas fa-sign-in-alt fa-2x text-white"></i>
                </div>
                <h2 class="section-title">Welcome Back</h2>
                <p class="text-muted">Sign in to your account</p>nv  v
            </div>

            <div class="form-card">
                <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-danger">
                    <i class="fas fa-exclamation-circle mr-2"></i>
                    <asp:Label ID="lblError" runat="server"></asp:Label>
                </asp:Panel>

                <div class="form-group">
                    <label><i class="fas fa-envelope mr-1 text-muted"></i>Email Address</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"
                        ToolTip="Enter Email"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtEmail" runat="server"
                        ErrorMessage="Email is required." CssClass="text-danger  small" UnobtrusiveValidationMode="None"
                        Display="Dynamic"/>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-lock mr-1 text-muted"></i>Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtPassword" runat="server"
                        ErrorMessage="Password is required." CssClass="text-danger small" UnobtrusiveValidationMode="None"
                        Display="Dynamic"/>
                </div>

                <asp:Button ID="btnLogin" runat="server" Text="Sign In"
                    CssClass="btn btn-primary-custom btn-block btn-lg" OnClick="btnLogin_Click"/>

                <hr/>
                <div class="text-center">
                    <p class="mb-1">Don't have an account? <a href="Register.aspx" style="color:var(--accent);font-weight:600;">Register here</a></p>
                    <p class="small text-muted mt-3">
                        <strong>Demo Credentials:</strong><br/>
                        Admin: admin@community.com / admin123<br/>
                        Member: john@email.com / john123
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
</asp:Content>
