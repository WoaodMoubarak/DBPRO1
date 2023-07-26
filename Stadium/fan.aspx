* <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="fan.aspx.cs" Inherits="Stadium.fan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
       
        <div>
            
             View available matches that have tickets<br />
            
             Date:
            <asp:TextBox ID="Date"  runat="server" TextMode ="DateTimeLocal"></asp:TextBox>
             <asp:Button ID="Data" runat="server" OnClick ="FetchData" Text="Available matches from this date"  /></div>
        <div>
            <asp:Panel ID="Panel1" runat="server" > </asp:Panel>
        </div>
        <p>
            purchase a ticket:</p>
        <p>
            Host Club:
            <asp:TextBox ID="hostClub"  runat="server"></asp:TextBox>
           
            Guest Club:
           <asp:TextBox ID="guestClub"  runat="server"></asp:TextBox>
            Start time:
            <asp:TextBox ID="StartTime"  runat="server" TextMode ="DateTimeLocal" ></asp:TextBox>
           <asp:Button ID="Button1" runat="server"  OnClick="purchaseTicket" Height="32px" Text="Purchase" Width="165px" /> 
          
        </p>
        <p>
            &nbsp;</p>
    </form>
</body>
</html>
