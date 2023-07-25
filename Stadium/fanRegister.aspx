<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="fanRegister.aspx.cs" Inherits="Stadium.fanRegister" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Panel ID="Panel1" runat="server" >
                Name:
                <asp:TextBox ID="name1" runat="server"></asp:TextBox>
            </asp:Panel>
        </div>
          <div>
            <asp:Panel ID="Panel2" runat="server" >
                Username:
                <asp:TextBox ID="username1" runat="server"></asp:TextBox>
              </asp:Panel>
        </div>
          <div>
             
            <asp:Panel ID="Panel3" runat="server" >
                Password:
                <asp:TextBox ID="password1" runat="server"></asp:TextBox>
              </asp:Panel>
        </div>
          <div>
            <asp:Panel ID="Panel4" runat="server" >
                NationalID
                <asp:TextBox ID="NationalID1" runat="server"></asp:TextBox>
              </asp:Panel>
        </div>
          <div>
            <asp:Panel ID="Panel5" runat="server" >
                phone:
                <asp:TextBox ID="phone1" runat="server"></asp:TextBox>
              </asp:Panel>
        </div>
          <div>
            <asp:Panel ID="Panel6" runat="server" >
                Date of birth:
                <asp:TextBox ID="DOB1" runat="server" TextMode ="DateTimeLocal"></asp:TextBox>
              </asp:Panel>
        </div>
          <div>
            <asp:Panel ID="Panel7" runat="server" >
                Address
                <asp:TextBox ID="Address1" runat="server"></asp:TextBox>
              </asp:Panel>
        </div>
        <div>
            <asp:Panel ID="Panel8" runat="server" >
                <asp:Button ID="Button5" runat="server" OnClick="addFan1" Text ="Register" />
            </asp:Panel>
        </div>

    </form>
</body>
</html>
