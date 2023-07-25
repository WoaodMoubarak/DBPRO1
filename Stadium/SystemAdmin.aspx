<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SystemAdmin.aspx.cs" Inherits="Stadium.SystemAdmin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Add A Club:<br />
            Club Name:
            <asp:TextBox ID="name"  runat="server"></asp:TextBox>
            Club Location:
            <asp:TextBox ID="location"  runat="server"></asp:TextBox>

            <asp:Button ID="Button1" runat="server"  OnClick="addClub" Text="Add Club" />
        </div>
        <div>
            Delete a Club:<br />
        Club Name 
        <asp:TextBox ID="deletename" runat="server"></asp:TextBox>

        <asp:Button ID="Button2" runat="server"  OnClick="deleteClub" Text="Delete Club" />
        
        </div>
        <p>
            &nbsp;Add A New Stadium:</p>
        <p>
            Stadium Name:
            <asp:TextBox ID="sname" runat="server"></asp:TextBox>
            Stadium Location:
            <asp:TextBox ID="slocation" runat="server"></asp:TextBox>
            Capacity:
            <asp:TextBox ID="scapacity" runat="server"></asp:TextBox>

            <asp:Button ID="Button3" runat="server" OnClick="addStadium" Text="Add Stadium" />

        </p>
        <p>
            Delete A Stadium</p>
        <p>
            Stadium Name:
            <asp:TextBox ID="stadiumname" runat="server"></asp:TextBox>
            <asp:Button ID="Button4" runat="server"   OnClick="deleteStadium" Text="Delete Stadium" />
        </p>
        <p>
            Block/Unblock Fan</p>
        <p>
            NationalID:
            <asp:TextBox ID="fan" runat="server"></asp:TextBox>
            <asp:Button ID="Button5" runat="server" OnClick="block" Text="Block Fan" />
            <asp:Button ID="Button6" runat="server" OnClick="unblock" Text="Unblock Fan" />
        </p>
    </form>
</body>
</html>
