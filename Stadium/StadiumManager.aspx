<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StadiumManager.aspx.cs" Inherits="Stadium.StadiumManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="direction: ltr">
            View Stadium<br />
            <asp:Button ID="view1" runat="server" onClick =" viewStadium" Text="View Stadium" />
            <br />
            <br />
            <asp:Panel ID="Panel1" runat="server" > </asp:Panel>
            <br />
            View All Requests<br />
            <asp:Button ID="view2" runat="server" onClick =" viewRequests" Text="View All Requests" />
            <br />
            <br />
            <asp:Panel ID="Panel2" runat="server" > </asp:Panel>
            <br />
            Accept / Reject&nbsp; Request<br />
            Host Club Name:
            <asp:TextBox ID="hostClub" runat="server"></asp:TextBox>
            <br />
            Guest Club Name:
            <asp:TextBox ID="guestClub" runat="server"></asp:TextBox>
            <br />
            Start Time of Match:
            <asp:TextBox ID="startTime" runat="server" TextMode ="DateTimeLocal" ></asp:TextBox>
            <br />
            <asp:Button ID="Button1" runat="server" onClick =" acceptRequest" Text="Accept" />
            <asp:Button ID="Button2" runat="server" onClick =" rejectRequest" Text="Reject" />
            <br />
        </div>
    </form>
</body>
</html>
