<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Stadium.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Register As:
            <br />
            <asp:Button ID="Button1" runat="server" OnClick="Fan" Text="Fan" />
            <asp:Button ID="Button2" runat="server"  OnClick="StadiumManager" Text="Stadium Manager" />
            <asp:Button ID="Button3" runat="server" OnClick="SportsM" Text="Sports Association Manager" />
            <asp:Button ID="Button4" runat="server" OnClick="ClubR" Text="Club Representative" />
        </div>
         <div>
            <asp:Panel ID="Panel1" runat="server" > </asp:Panel>
        </div>
         <div>
            <asp:Panel ID="Panel2" runat="server" > </asp:Panel>
        </div>
         <div>
            <asp:Panel ID="Panel3" runat="server" > </asp:Panel>
        </div>
         <div>
            <asp:Panel ID="Panel4" runat="server" > </asp:Panel>
        </div>
         <div>
            <asp:Panel ID="Panel5" runat="server" > </asp:Panel>
        </div>
         <div>
            <asp:Panel ID="Panel6" runat="server" > </asp:Panel>
        </div>
         <div>
            <asp:Panel ID="Panel7" runat="server" > </asp:Panel>
        </div>
        <div>
            <asp:Panel ID="Panel8" runat="server" >
                
            </asp:Panel>
        </div>
    </form>
</body>
</html>
