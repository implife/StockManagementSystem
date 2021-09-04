<%@ Page Title="" Language="C#" MasterPageFile="~/SystemBackEnd/Main.Master" AutoEventWireup="true" CodeBehind="NewProduct.aspx.cs" Inherits="StockManagement.SystemBackEnd.Order.NewProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../Content/bootstrap.css" rel="stylesheet" />
    <script src="../../Scripts/bootstrap.js"></script>

    <script src="../../Scripts/customize/jquery-3.6.0.min.js"></script>

    <style>
        .form-item {
            margin-bottom: 5px;
        }

        div.row label {
            padding: 1rem 1.5rem;
        }
    </style>
    <script>



        $(function () {
            //document.getElementsByTagName("FORM").noValidate = true;
            $("form").prop("novalidate", true);
            $("form").addClass("needs-validation");
            $("#CDForm_Container input").prop("required", true);

            (function () {
                'use strict'

                // Fetch all the forms we want to apply custom Bootstrap validation styles to
                var forms = document.querySelectorAll('.needs-validation')

                // Loop over them and prevent submission
                Array.prototype.slice.call(forms)
                    .forEach(function (form) {
                        form.addEventListener('submit', function (event) {

                            let dateStr = $("#PubDate").val();
                            let datetime = new Date(dateStr);
                            let now = new Date(Date.now());
                            let strict = new Date("1900-01-01");
                            if (datetime > now) {
                                $("#spanMsg").html("日期不可大於今天");
                                event.preventDefault();
                                event.stopPropagation();
                            }
                            if (datetime < strict) {
                                $("#spanMsg").html("日期不可小於1900-01-01");
                                event.preventDefault();
                                event.stopPropagation();
                            }
                            if (!form.checkValidity()) {
                                event.preventDefault()
                                event.stopPropagation()
                            }
                            $("input[id$=HFPubDate]").val(dateStr);

                            form.classList.add('was-validated')
                        }, false)
                    })

                //const eleDate = document.getElementById('PubDate');
                //eleDate.addEventListener('input', validateFirstname(eleDate));

                //function validateFirstname(e) {
                //    let checker = new Date(e.value);
                //    let now = new Date(Date.now());
                //    console.log(e.value);
                //    if (checker > now) {
                //        console.log("Invalid myValidation");
                //        e.setCustomValidity("This field must not be blank !");
                //    } else {
                //        e.setCustomValidity("");
                //    }
                //}
            })()
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-sm-10 col-md-6 offset-md-3" id="CDForm_Container">

        <div class="row">
            <div class="col-sm-12 col-md-6 form-item form-floating">
                <asp:TextBox ID="EpisodeName" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:Label ID="Label1" runat="server" Text="專輯名稱" AssociatedControlID="EpisodeName"></asp:Label>
                <div class="invalid-feedback">
                    請輸入專輯名稱
                </div>
                <div class="valid-feedback">
                    Good!
                </div>
            </div>
            <div class="col-sm-12 col-md-6 form-item form-floating">
                <asp:TextBox ID="Brand" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:Label ID="Label2" runat="server" Text="發行公司" AssociatedControlID="Brand"></asp:Label>
                <div class="invalid-feedback">
                    請輸入發行公司
                </div>
                <div class="valid-feedback">
                    Good!
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-12 col-md-6 form-item form-floating">
                <asp:TextBox ID="Artist" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:Label ID="Label3" runat="server" Text="表演者" AssociatedControlID="Artist"></asp:Label>
                <div class="invalid-feedback">
                    請輸入表演者
                </div>
                <div class="valid-feedback">
                    Good!
                </div>
            </div>
            <div class="col-sm-12 col-md-6 form-item form-floating">
                <asp:TextBox ID="Region" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:Label ID="Label4" runat="server" Text="地區" AssociatedControlID="Region"></asp:Label>
                <div class="invalid-feedback">
                    請輸入地區
                </div>
                <div class="valid-feedback">
                    Good!
                </div>
            </div>
        </div>


        <div class="col-sm-12 col-md-6 form-item  offset-md-3">
            <label for="PubDate" class="form-label">發行日期</label>
            <input type="date" class="form-control" id="PubDate">
            <div class="invalid-feedback">
                請輸入發行日期
            </div>
            <div class="valid-feedback">
                Good!
            </div>
        </div>
        <asp:HiddenField ID="HFPubDate" runat="server" />
        <div class="col-12" style="text-align: center">
            <asp:Button ID="btnCreate" runat="server" Text="建立" CssClass="btn btn-outline-primary" OnClick="btnCreate_Click" />
            <a class="btn btn-outline-secondary" href="NewOrder.aspx" role="button">取消</a>
            <br />
            <span id="spanMsg"></span>
        </div>

    </div>
    <asp:Literal ID="ltlFailedModal" runat="server"></asp:Literal>
</asp:Content>
