<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="sportsManager.aspx.cs" Inherits="Stadium.sportsManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Add Match;<br />
            Host Club:
            <asp:TextBox ID="host" runat="server"></asp:TextBox>
            Guest Club:
            <asp:TextBox ID="guest" runat="server"></asp:TextBox>
            Start time:
            <asp:TextBox ID="start" runat="server" TextMode ="DateTimeLocal" ></asp:TextBox>
            End time:
            <asp:TextBox ID="end" runat="server" TextMode ="DateTimeLocal" ></asp:TextBox>
            <asp:Button ID="Button1" runat="server" OnClick="addMatch" Text="Add match" />
        </div>
        Delete Match:<br />
        hostClub:
        <asp:TextBox ID="hostD" runat="server"></asp:TextBox>
        guestClub:
        <asp:TextBox ID="guestD" runat="server"></asp:TextBox>
        startTime:
        <asp:TextBox ID="startD" runat="server" TextMode ="DateTimeLocal" ></asp:TextBox>
        endTime:
        <asp:TextBox ID="endD" runat="server" TextMode ="DateTimeLocal" ></asp:TextBox>
            <asp:Button ID="Button2" runat="server" OnClick="deleteMatch" Text="Delete match" />
         <div>
            <asp:Panel ID="Panel1" runat="server" >
                <asp:Button ID="Button3" runat="server" OnClick="upcomingMatches" Text="View upcoming matches" />
             </asp:Panel>
        </div>
         <div>
            <asp:Panel ID="Panel2" runat="server" >
                <asp:Button ID="Button4" runat="server" OnClick="playedMatches" Text="View already played matches" />
             </asp:Panel>
        </div>
        <div>
            <asp:Panel ID="Panel3" runat="server" >
                <asp:Button ID="Button5" runat="server" OnClick="clubsneverplayed" Text="View clubs never matched" />
             </asp:Panel>
        </div>
    </form>
</body>
</html>
