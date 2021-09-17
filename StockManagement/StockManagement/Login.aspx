<%@ Page Language="C#" Title="薛丁格庫存管理系統登入頁" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="StockManagement.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, height=device-width, initial-scale=1.0" />
    <link href="StyleSheet/boostrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="StyleSheet/LoginStyle.css" />

    <script src="Scripts/customize/jquery-3.6.0.min.js"></script>
    <script src="Scripts/customize/Validation.js"></script>

    <script>
        function startTime() {
            const today = new Date();
            let mon = today.getMonth() + 1;
            let d = today.getDate();
            let h = today.getHours();
            let m = today.getMinutes();
            let s = today.getSeconds();
            m = checkTime(m);
            s = checkTime(s);
            document.getElementById('login_Clock').innerHTML = mon + " 月 " + d + " 日 " + h + ":" + m + ":" + s;
            setTimeout(startTime, 1000);
        }

        function checkTime(i) {
            if (i < 10) { i = "0" + i };  // add zero in front of numbers < 10
            return i;
        }

        $(function () {
            $('form').submit(function (event) {
                // Check所有.myValidation是否通過
                if (!$('input.myValidation').toArray().every(CheckHasValid)) {
                    event.preventDefault();
                    event.stopPropagation();
                }
            })
        })

    </script>


    <title>Login</title>
</head>
<body onload="startTime()">
    <section>
        <form id="form1" runat="server">
            <div class="container py-5 h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-12 col-md-8 col-lg-6 col-xl-5">
                        <div class="card text-black cardlogin" style="border-radius: 1rem; background-color: #f4fcf9;">
                            <div class="card-body p-5 text-center">

                                <div class="mb-md-5 mt-md-4 pb-5">

                                    <h2 class="fw-bolder text-dark">薛丁格庫存管理系統</h2>
                                    <p class="text-black-50 mb-5">
                                        請登入以查看系統內容
                                    </p>

                                    <div class="form-outline form-white mb-4">
                                        <asp:TextBox ID="txtAccount" runat="server" CssClass="form-control form-control-lg myValidation validateNullWhiteSpace" placeholder="請輸入帳號"></asp:TextBox>
                                        <div class="invalid-feedback">
                                            --
                                        </div>
                                        <div class="valid-feedback">
                                           
                                        </div>
                                    </div>

                                    <div class="form-outline form-white mb-4">
                                        <asp:TextBox ID="txtPWD" runat="server" TextMode="Password" CssClass="form-control form-control-lg myValidation validateNullWhiteSpace" placeholder="請輸入密碼"></asp:TextBox>
                                        <div class="invalid-feedback">
                                            --
                                        </div>
                                        <div class="valid-feedback">
                                            
                                        </div>
                                    </div>

                                    <p class="small mb-5 pb-lg-2"><a class="text-white-50" href="#!">Forgot password?</a></p>

                                    <asp:Button ID="btnLogin" runat="server" Text="登入" CssClass="btn btn-outline-primary btn-lg px-5" OnClick="btnLogin_Click" />
                                    <br />
                                    <asp:Label ID="lblMsg" runat="server" Text="" CssClass="loginMsg"></asp:Label>
                                    <%--<asp:Literal ID="ltlMsg" runat="server" EnableViewState="false"></asp:Literal>--%>

                                </div>

                                <div>
                                    <p class="mb-0" id="login_Clock">--</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </section>
</body>
</html>
