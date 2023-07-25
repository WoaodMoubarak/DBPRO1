<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StadiumManagerRegister.aspx.cs" Inherits="Stadium.StadiumManagerRegister" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
             
            Name:
            <asp:TextBox ID="name1" runat="server"></asp:TextBox>
            <p>
                Stadium Name:
                   <asp:TextBox ID="stadiumname1" runat="server"></asp:TextBox>
            </p>
         
        </div>
        <p>
            Username:
            <asp:TextBox ID="username1" runat="server"></asp:TextBox>
        </p>
        <p>
            Password
            <asp:TextBox ID="password1" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="Button1" runat="server" OnClick="addManager" Text="Register" />
        </p>
       
    </form>
</body>
</html>
