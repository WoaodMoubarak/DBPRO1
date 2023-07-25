<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="clubrepresentative.aspx.cs" Inherits="Stadium.clubrepresentative" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            view club<br />
            <asp:Button ID="viewClubB" runat="server" OnClick =" viewClub" Text="view club" />
            <br />
            <br />
              <div>
            <asp:Panel ID="Panel1" runat="server" > </asp:Panel>
        </div>
            <br />
            view all upcoming matches<br />
            <asp:Button ID="upcomingMatchesB" runat="server" OnClick =" upcominMatches"  Text="Upcoming Matches" />
            <br />
            <br />
             <div>
            <asp:Panel ID="Panel2" runat="server" > </asp:Panel>
        </div>
            <br />
            Date:<br />
            <asp:TextBox ID="Date" runat="server" TextMode ="DateTimeLocal" ></asp:TextBox>
&nbsp;<asp:Button ID="availableStadiumsB" runat="server" OnClick =" availableStadiums" Text="View Available Stadiums" />
            <br />
             <div>
            <asp:Panel ID="Panel3" runat="server" > </asp:Panel>
        </div>
            <br />
            <br />
            Send a request:<br />
            Stadium name<br />
            <asp:TextBox ID="StadiumName" runat="server"></asp:TextBox>
            <br />
            <br />
            Start time<br />
            <asp:TextBox ID="startTime" runat="server" TextMode ="DateTimeLocal"  ></asp:TextBox>
            <br />
            <asp:Button ID="sendRequestB" runat="server" OnClick =" sendRequest" Text="Send Request" />
        </div>
    </form>
</body>
</html>
