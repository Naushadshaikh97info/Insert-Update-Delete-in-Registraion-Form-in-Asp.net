<%@ Page Language="C#" AutoEventWireup="true" CodeFile="registraion_form.aspx.cs" Inherits="registraion_form" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registraion</title>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js">
    </script>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.8.2.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

    <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%=btn_submit.ClientID %>').click(function () {

            var Name = $.trim($('#<%=txt_firstname.ClientID %>').val());
            var Description = $.trim($('#<%=txt_LastName.ClientID %>').val());
            var Author = $.trim($('#<%=txt_mobileno.ClientID %>').val());
            var Category = $('#<%=ddl_country.ClientID %>').val();
            //For more on DropDownList
            //Visit http://codedisplay.com/jquery-to-get-selectedvalue-selectedindex-selectedtext-of-a-dropdownlist-asp-net-c-vb-net/

            $.ajax({
                type: "POST",
                url: "registraion_form.aspx/insert_registraion",
                data: "{'sName':'" + Name + "', 'sDescription':'" + Description + "','sAuthor':'" + Author + "','sCategory':'" + Category + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (Response_msg) {
                    if (Response_msg.d.indexOf("ERROR") < 0) {
                        $('#divStatus').html(Response_msg.d)
                        $('#divStatus').css({ "font-weight": "bold", "color": "Green" })
                        $('#<%=txt_firstname.ClientID %>').val("")
                        $('#<%=txt_LastName.ClientID %>').val("")
                        $('#<%=txt_mobileno.ClientID %>').val("")
                        $('#<%=ddl_country.ClientID %>').val("0")
                        $('#divStatus').fadeOut(5000);
                    }
                    else {
                        $('#divStatus').html(Response_msg.d)
                        $('#divStatus').css({ "font-weight": "bold", "color": "Red" })
                    }
                },
                error: function (xhr, status, errorThrown) {
                    $('#divStatus').html(errorThrown + '</br>' + status + '</br>' + xhr.statusText)
                }
            });
            return false;
        });
    });
    </script>

    <%--<script type="text/javascript">
       $(function () {
           $('#btn_submit').click(function () {
               var name = $('#txt_firstname').val();
               var subject = $('#txt_firstname').val();
               var body = $('#txt_firstname').val();
               if (name != '' && subject != '' && body) {
                   $.ajax({
                       type: "POST",
                       contentType: "application/json; charset=utf-8",
                       url: "registraion_form.aspx/insert_registraion",
                       data: "{'username':'" + name + "','subj':'" + subject + "','desc':'" + body + "'}",
                       dataType: "json",
                       success: function (data) {
                           var obj = data.d;
                           if (obj == 'true') {
                               $('#txt_firstname').val('');
                               $('#txt_firstname').val('');
                               $('#txt_firstname').val('');
                               $('#lblNoRecords').html("Details Submitted Successfully");
                               window.location.reload();
                           }
                       },
                       error: function (result) {
                           alert("Error");
                       }
                   });
               }
               else {
                   alert('Please enter all the fields')
                   return false;
               }
           })
       });
</script>--%>
    <style type="text/css">
        .GridHeader {
            background-color: #808080;
            color: #ffffff;
            font-weight: bold;
            font-size: 15px;
        }

        .GridRow {
            background-color: #ffffff;
            font-size: 13px;
        }

        .GridAltRow {
            background-color: #d3d3d3;
            font-size: 13px;
        }
    </style>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%=btn_serch.ClientID %>').click(function (e) {
                SearchGridData();
                e.preventDefault();
            });
        });
        function SearchGridData() {
            var counter = 0;
            //Get the search text
            var searchText = $('#<%=txtSearch.ClientID %>').val().toLowerCase();
            //Hide No record found message
            $('#<%=lblNoRecords.ClientID %>').hide();
            //Hode all the rows of gridview
            $('#<%=GridView1.ClientID %> tr:has(td)').hide();
            if (searchText.length > 0) {
                //Iterate all the td of all rows
                $('#<%=GridView1.ClientID %> tr:has(td)').children().each(function () {
                    var cellTextValue = $(this).text().toLowerCase();
                    //Check that text is matches or not
                    if (cellTextValue.indexOf(searchText) >= 0) {
                        $(this).parent().show();
                        counter++;
                    }
                });
                if (counter == 0) {
                    //Show No record found message
                    $('#<%=lblNoRecords.ClientID %>').show();
                }
            }
            else {
                //Show All the rows of gridview
                $('#<%=GridView1.ClientID %> tr:has(td)').show();
            }
        }
    </script>
    <%-- <script src="Scripts/jquery-1.7.1.min.js"></script>
     <script type="text/javascript" language="javascript">
         $(document).ready(function () {
             $('#<%=lblNoRecords.ClientID%>').css('display', 'none');

        $('#<%=btn_serch.ClientID%>').click(function (e) {
            $('#<%=lblNoRecords.ClientID%>').css('display', 'none'); // Hide No records to display label.
            $("#<%=GridView1.ClientID%> tr:has(td)").hide(); // Hide all the rows.

            var iCounter = 0;
            var sSearchTerm = $('#<%=txtSearch.ClientID%>').val(); //Get the search box value

            if (sSearchTerm.length == 0) //if nothing is entered then show all the rows.
            {
                $("#<%=GridView1.ClientID%> tr:has(td)").show();
                return false;
            }
            //Iterate through all the td.
            $("#<%=GridView1.ClientID%> tr:has(td)").children().each(function () {
                var cellText = $(this).text().toLowerCase();
                if (cellText.indexOf(sSearchTerm.toLowerCase()) >= 0) //Check if data matches
                {
                    $(this).parent().show();
                    iCounter++;
                    return true;
                }
            });
            if (iCounter == 0) {
                $('#<%=lblNoRecords.ClientID%>').css('display', '');
            }
            e.preventDefault();
        })
    })
    </script>--%>
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
                <td>
                    <asp:Label ID="lblNoRecords" runat="server" Text="No records to display"></asp:Label>
                </td>
            </tr>
        </table>
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
                    <asp:TextBox ID="txtSearch" runat="server" />
                    <asp:Button ID="btn_serch" Text="Search" runat="server" OnClick="btn_serch_Click" />
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td>
                    <asp:GridView ID="GridView1" runat="server" DataKeyNames="Code" OnRowDataBound="GridView1_RowDataBound" AllowPaging="true" PageSize="10" AutoGenerateColumns="false" OnRowDeleting="GridView1_RowDeleting" OnRowEditing="GridView1_RowEditing" OnPageIndexChanging="GridView1_PageIndexChanging">
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
        <script type="text/javascript">
            jQuery(document).ready(function () {
                $("#GridView1").tablesorter({ debug: false, widgets: ['zebra'], sortList: [[0, 0]] });
            });
        </script>
    </form>
</body>
</html>
