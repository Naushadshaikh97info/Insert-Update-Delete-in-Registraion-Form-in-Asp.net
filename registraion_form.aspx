<%@ Page Language="C#" AutoEventWireup="true" CodeFile="registraion_form.aspx.cs" Inherits="registraion_form" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registraion</title>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js">
    </script>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.8.2.js"></script>
    <script language="javascript" type="text/javascript">
        $(function () {
            $('#btn_submit').click(function () {
                var summary = "";
                summary += isvalidfirstname();
                summary += isvalidLastName();
                summary += isvalidmobileno();
                summary += isvalidCountry();
                summary += isvalidState();

                summary += isvalidimage();


                if (summary != "") {
                    alert(summary);
                    return false;
                }
                else {
                    return true;
                }
            })
        })
        function isvalidfirstname() {
            var temp = $("#txt_firstname").val();
            if (temp == "") {
                return ("Please Enter Firstname" + "\n");
            }
            else {
                return "";
            }
        }
        function isvalidLastName() {
            var temp = $("#txt_LastName").val();
            if (temp == "") {
                return ("Please Enter LastName" + "\n");
            }
            else {
                return "";
            }
        }
        function isvalidmobileno() {
            var temp = $("#txt_mobileno").val();
            if (temp == "") {
                return ("Please Enter Mobileno" + "\n");
            }
            else {
                return "";
            }
        }
        function isvalidCountry() {
            var temp = $("#ddl_country").val();
            if (temp == "-- Select Country --") {
                return ("Please Select Country" + "\n");
            }
            else {
                return "";
            }
        }
        function isvalidState() {
            var temp = $("#ddl_state").val();
            if (temp == "-- Select State --") {
                return ("Please Select State" + "\n");
            }
            else {
                return "";
            }
        }

        function isvalidimage() {
            var temp = $("#FileUpload1").val();
            if (temp == "") {
                return ("Please Select Image" + "\n");
            }
            else {
                return "";
            }
        }

        $(document).ready(function () {
            $('#btn_submit').click(function () {
                if ($('#ch_hobbies input:checked').length > 0) {
                    return true;
                }
                else {
                    alert('Please select atleast one hobbies')
                    return false;
                }
            })
        });

        $(document).ready(function () {
            $('#btn_submit').click(function () {
                if ($('#rb_gender input:checked').length > 0) {
                    return true;
                }
                else {
                    alert('Please select gender')
                    return false;
                }
            })
        });


        $(document).ready(function () {
            $("#btn_submit").click(function () {
                var EmailText = $("#txt_emailid").val();
                if ($.trim(EmailText).length == 0) {
                    alert("Please enter email address");
                    return false;
                }
                if (validateEmail(EmailText)) {
                    alert('Valid Email Address');
                    return true;
                }
                else {
                    alert('Invalid Email Address');
                    return false;
                }
            });
        });
        function validateEmail(sEmail) {
            var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
            if (filter.test(sEmail)) {
                return true;
            }
            else {
                return false;
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <table>
            <tr>
                <td>First Name
                </td>
                <td>
                    <asp:TextBox ID="txt_firstname" runat="server"></asp:TextBox>
                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please enter first name"
                        ControlToValidate="txt_firstname" Display="None" ValidationGroup="btnsubmit">*</asp:RequiredFieldValidator>--%>
                </td>
            </tr>
            <tr>
                <td>Last Name
                </td>
                <td>
                    <asp:TextBox ID="txt_LastName" runat="server"></asp:TextBox>
                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter last name"
                        ControlToValidate="txt_LastName" Display="None" ValidationGroup="btnsubmit">*</asp:RequiredFieldValidator>--%>
                </td>
            </tr>
            <tr>
                <td>Emailid
                </td>
                <td>
                    <asp:TextBox ID="txt_emailid" runat="server"></asp:TextBox>
                    <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please enter email id"
                        ControlToValidate="txt_emailid" Display="None" ValidationGroup="btnsubmit">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="rev1" runat="server" Display="None" ErrorMessage="Enter Proper email ID" ControlToValidate="txt_emailid" ValidationGroup="btnsubmit" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>--%>
                </td>
            </tr>
            <tr>
                <td>Mobile No
                </td>
                <td>
                    <asp:TextBox ID="txt_mobileno" runat="server"></asp:TextBox>
                    <%--  <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" TargetControlID="txt_mobileno" FilterType="Numbers">
                    </cc1:FilteredTextBoxExtender>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" Display="None" runat="server" ErrorMessage="Please enter mobile no"
                        ControlToValidate="txt_mobileno" ValidationGroup="btnsubmit">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" Display="None" runat="server" ErrorMessage="Please enter 10 digit mobile no"
                        ControlToValidate="txt_mobileno" ValidationGroup="btnsubmit" ValidationExpression="^[0-9]{10}$"></asp:RegularExpressionValidator>--%>
                </td>
            </tr>
            <tr>
                <td>Gender
                </td>
                <td>
                    <asp:RadioButtonList ID="rb_gender" runat="server">
                        <asp:ListItem>Male</asp:ListItem>
                        <asp:ListItem>Female</asp:ListItem>
                    </asp:RadioButtonList>
                    <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please select gender"
                        ControlToValidate="rb_gender" Display="None" ValidationGroup="btnsubmit">*</asp:RequiredFieldValidator>--%>
                </td>
            </tr>
            <tr>
                <td>Country
                </td>
                <td>
                    <asp:DropDownList ID="ddl_country" runat="server" DataTextField="country" DataValueField="intglcode" AutoPostBack="true" OnSelectedIndexChanged="ddl_country_SelectedIndexChanged">
                    </asp:DropDownList>
                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please select Country"
                        ControlToValidate="ddl_country" Display="None" ValidationGroup="btnsubmit">*</asp:RequiredFieldValidator>--%>
                </td>
            </tr>
            <tr>
                <td>State
                </td>
                <td>
                    <asp:DropDownList ID="ddl_state" runat="server" DataTextField="state" DataValueField="intglcode">
                        <asp:ListItem>-- Select State --</asp:ListItem>
                    </asp:DropDownList>
                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Please select State"
                        ControlToValidate="ddl_state" Display="None" ValidationGroup="btnsubmit">*</asp:RequiredFieldValidator>--%>
                </td>
            </tr>
            <tr>
                <td>Hobbies
                </td>
                <td>
                    <asp:CheckBoxList ID="ch_hobbies" runat="server">
                        <asp:ListItem>Chess</asp:ListItem>
                        <asp:ListItem>Cricket</asp:ListItem>
                        <asp:ListItem>Hooly Ball</asp:ListItem>
                        <asp:ListItem>Football</asp:ListItem>
                        <asp:ListItem>Net Surfing</asp:ListItem>
                    </asp:CheckBoxList>
                </td>
            </tr>
            <tr>
                <td>Image
                </td>
                <td>
                    <asp:FileUpload ID="FileUpload1" runat="server"></asp:FileUpload>
                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="Please select Image"
                        ControlToValidate="FileUpload1" Display="None" ValidationGroup="btnsubmit">*</asp:RequiredFieldValidator>--%>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Button ID="btn_submit" runat="server" value="btn_submit" Text="Submit"
                        OnClick="btn_submit_Click"></asp:Button>
                    <%--  <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true" ShowSummary="false" ValidationGroup="btnsubmit" />--%>
                    <asp:Button ID="btn_update" runat="server" Text="Update" OnClick="btn_update_Click" Visible="false"></asp:Button>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td>
                    <asp:GridView ID="GridView1" runat="server" DataKeyNames="Code" AllowPaging="true" PageSize="10" AutoGenerateColumns="false" OnRowDeleting="GridView1_RowDeleting" OnRowEditing="GridView1_RowEditing" OnPageIndexChanging="GridView1_PageIndexChanging">
                        <Columns>
                            <asp:CommandField HeaderText="Delete" ShowDeleteButton="true" ButtonType="Link" />
                            <asp:CommandField HeaderText="Edit" ShowEditButton="true" ButtonType="Link" />
                            <asp:BoundField HeaderText="First Name" DataField="FirstName" />
                            <asp:BoundField HeaderText="Last Name" DataField="LastName" />
                            <asp:BoundField HeaderText="Emailid" DataField="Emailid" />
                            <asp:BoundField HeaderText="Mobile No" DataField="MobileNo" />
                            <asp:BoundField HeaderText="Gender" DataField="Gender" />
                            <asp:BoundField HeaderText="Country" DataField="Country" />
                            <asp:BoundField HeaderText="State" DataField="State" />
                            <asp:BoundField HeaderText="Hobbies" DataField="Hobbies" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Image ID="Image1" runat="server" ImageUrl='<%#Eval("fhoto_nm") %>' Width="50px"
                                        Height="50px" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
