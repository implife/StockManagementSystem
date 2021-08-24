<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="StockManagement.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, height=device-width, initial-scale=1.0"/>
    <link href="StyleSheet/boostrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="StyleSheet/LoginStyle.css" />


    <title>Login</title>
</head>
<body>
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
                                        <%--<input type="email" placeholder="請輸入帳號/員工編號" id="typeEmailX" class="form-control form-control-lg" />--%>
                                        <asp:TextBox ID="txtAccount" runat="server" CssClass="form-control form-control-lg" placeholder="請輸入帳號/員工編號"></asp:TextBox>
                                    </div>

                                    <div class="form-outline form-white mb-4">
                                        <%--<input type="password" placeholder="請輸入密碼" ="typePasswordX" class="form-control form-control-lg" />--%>
                                        <asp:TextBox ID="txtPWD" runat="server" TextMode="Password" CssClass="form-control form-control-lg" placeholder="請輸入密碼"></asp:TextBox>
                                    </div>

                                    <p class="small mb-5 pb-lg-2"><a class="text-white-50" href="#!">Forgot password?</a></p>

                                    <asp:Button ID="btnLogin" runat="server" Text="登入" CssClass="btn btn-outline-primary btn-lg px-5" OnClick="btnLogin_Click" />
                                    <br />
                                    <asp:Literal ID="ltlMsg" runat="server"></asp:Literal>
                                    <!--<button class="btn btn-outline-primary btn-lg px-5 ","btn-primary active"" type="submit">登入</button>-->
                                   
                                </div>

                                <div>
                                    
                                    <p class="mb-0">2021/08/21 23:59:40 </p>
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
