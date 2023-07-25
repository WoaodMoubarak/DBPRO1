<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Stadium.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="please login"></asp:Label>
            <br />
            UserName:<br />
            <asp:TextBox ID="username" runat="server"></asp:TextBox>
            <br />
            Password:<br />
            <asp:TextBox ID="Password" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="login1" runat="server" OnClick =" login" Text="Log In"  />
            <br />
            <br />
            Register if you don&#39;t have an account<br />
        </div>
        <asp:Button ID="RButton" runat="server" OnClick =" register" Text="Register" />
    </form>
</body>
</html>
