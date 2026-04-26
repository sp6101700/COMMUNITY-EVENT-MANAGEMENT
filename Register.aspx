<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
<div class="container">
    <div class="row justify-content-center mt-4">
        <div class="col-md-6">
            <div class="text-center mb-4">
                <div style="width:75px;height:75px;background:linear-gradient(135deg,#28a745,#20c997);border-radius:50%;display:inline-flex;align-items:center;justify-content:center;margin-bottom:15px;">
                    <i class="fas fa-user-plus fa-2x text-white"></i>
                </div>
                <h2 class="section-title">Create Account</h2>
                <p class="text-muted">Join the community — it's free!</p>
            </div>

            <div class="form-card">
                <asp:Panel ID="pnlMsg" runat="server" Visible="false"></asp:Panel>

                <div class="form-row">
                    <div class="form-group col-12">
                        <label><i class="fas fa-user mr-1 text-muted"></i>Full Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="John Smith"></asp:TextBox>
                        <asp:RequiredFieldValidator ControlToValidate="txtName" runat="server"
                            ErrorMessage="Name is required." CssClass="text-danger small" Display="Dynamic"/>
                    </div>
                    <div class="form-group col-12">
                        <label><i class="fas fa-envelope mr-1 text-muted"></i>Email Address</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="email@example.com"></asp:TextBox>
                        <asp:RequiredFieldValidator ControlToValidate="txtEmail" runat="server"
                            ErrorMessage="Email is required." CssClass="text-danger small" Display="Dynamic"/>
                    </div>
                    <div class="form-group col-md-6">
                        <label><i class="fas fa-lock mr-1 text-muted"></i>Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Min 6 chars"></asp:TextBox>
                        <asp:RequiredFieldValidator ControlToValidate="txtPassword" runat="server"
                            ErrorMessage="Password required." CssClass="text-danger small" Display="Dynamic"/>
                        <asp:RegularExpressionValidator ControlToValidate="txtPassword" runat="server"
                            ValidationExpression=".{6,}" ErrorMessage="Min 6 characters."
                            CssClass="text-danger small" Display="Dynamic"/>
                    </div>
                    <div class="form-group col-md-6">
                        <label><i class="fas fa-lock mr-1 text-muted"></i>Confirm Password</label>
                        <asp:TextBox ID="txtConfirmPwd" runat="server" CssClass="form-control" TextMode="Password" placeholder="Repeat password"></asp:TextBox>
                        <asp:CompareValidator ControlToValidate="txtConfirmPwd" ControlToCompare="txtPassword"
                            runat="server" ErrorMessage="Passwords don't match."
                            CssClass="text-danger small" Display="Dynamic"/>
                    </div>
                    <div class="form-group col-12">
                        <label><i class="fas fa-phone mr-1 text-muted"></i>Phone (Optional)</label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="+1 555 0123"></asp:TextBox>
                    </div>
                </div>

                <asp:Button ID="btnRegister" runat="server" Text="Create Account"
                    CssClass="btn btn-success btn-block btn-lg" OnClick="btnRegister_Click"
                    Style="border-radius:8px;font-weight:600;"/>

                <hr/>
                <div class="text-center">
                    Already have an account? <a href="Login.aspx" style="color:var(--accent);font-weight:600;">Sign in</a>
                </div>
            </div>
        </div>
    </div>
</div>
</asp:Content>
