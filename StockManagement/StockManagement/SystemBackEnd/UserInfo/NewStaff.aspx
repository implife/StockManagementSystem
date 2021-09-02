<%@ Page Title="" Language="C#" MasterPageFile="~/SystemBackEnd/Main.Master" AutoEventWireup="true" CodeBehind="NewStaff.aspx.cs" Inherits="StockManagement.SystemBackEnd.UserInfo.NewStaff" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../../Scripts/customize/jquery-3.6.0.min.js"></script>
    <script src="../../Scripts/customize/popper.min.js"></script>

    <script src="../../Scripts/bootstrap.min.js"></script>
    <script src="../../Scripts/bootstrap.bundle.js"></script>
    <link href="../../StyleSheet/boostrap.min.css" rel="stylesheet" />
     <script>
        $(function () {
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


                            if (!form.checkValidity()) {
                                event.preventDefault()
                                event.stopPropagation()
                            }

                            form.classList.add('was-validated')
                        }, false)
                    }
                )
            })()

            $('li').click(function () {
                $(this).parent().siblings("button").text($(this).text());
            })

        });

     </script>
        <style>
        .form-item {
            margin-bottom: 5px;
        }

        div.row label {
            padding: 1rem 1.5rem;
        }

        .form__input {
            display: block;
            width: 100%;
            padding: 20px;
            font-family: "Roboto";
            -webkit-appearance: none;

            outline: 1px;
            transition: 0.3s;
        }

        .form__input:focus {
            background: #f7f7f7;
        }

        .form-control {
            border-radius: 0;

        }

        .form-control1 {
            border-top-left-radius: 0.8rem;
            border-top-right-radius: 0.8rem;
        }

        .form-control2 {
            border-bottom-left-radius: 0.8rem;
            border-bottom-right-radius: 0.8rem;
        }

        .user__title {
            font-size: 24px;
            text-align: center;
            font-family: "Roboto";
            font-weight: 500;
            color: rgb(146, 139, 146);
            margin-top: 6rem;
            
        }

        .btn-success {
            color: #c19065;
            background-color: #F6FBF9;
            border-color: #b6b4b4;
            width: 100%;
            border-radius: 0;
            height: 3rem;

        }
        .btn-success:hover{
            color: #c19065;
            background-color: #B6E9C4;
            border-color: #b6b4b4;
        }

        .btn-check:focus+.btn-danger, .btn-danger:focus {
            color: #fff;
            background-color: #CBEEE1;
            border-color: #CBEEE1;
            box-shadow: 0 0 0 0.25rem rgb(219 239 232 / 100%);
        }
        body {
            font-family: "Roboto";
            font-size: 14px;
            background-size: 200% 100% !important;
            -webkit-animation: move 8s ease infinite;
            animation: move 8s ease infinite;
            transform: translate3d(0, 0, 0);
            background: linear-gradient(-45deg, #dd6945, #d660ee, #3bb7e4, #7ef5d9, #ccfaf0);
            height: 100vh;
        }
            .containerDiv {
                height: 28.4rem;
                width: 35rem;
                position: absolute;
                right: 30%;
                top: 8%;
                background-color: #fafffd00;
            }

        @-webkit-keyframes move {
            0% {
                background-position: 160% 40%;
            }

            50% {
                background-position: 120% 10%;
            }

            100% {
                background-position: 0 0;
            }
        }

        @keyframes move {
            0% {
                background-position: 0 0;
            }

            50% {
                background-position: 100% 0;
            }

            100% {
                background-position: 0 0;
            }
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="row">
                    <div class="col-sm-12 col-md-12 form__group form-floating">

                        <input type="text" id="ContentPlaceHolder1_EpisodeName"
                            class="form-control form-control1 form__input" placeholder="請輸入姓名" />
                        <label for="ContentPlaceHolder1_EpisodeName" id="ContentPlaceHolder1_Label1">請輸入姓名</label>
                        <div class="invalid-feedback">
                            請輸入姓名
                        </div>
                
                    </div>

                    <div class="col-sm-12 col-md-12 form__group form-floating">
                        <input type="text" id="ContentPlaceHolder1_Brand" class="form-control form__input"
                            placeholder="發行公司" />
                        <label for="ContentPlaceHolder1_Brand" id="ContentPlaceHolder1_Label2">請輸入帳號</label>
                        <div class="invalid-feedback">
                            請輸入帳號
                        </div>
                    </div>

                    <div class="col-sm-12 col-md-12 form__group form-floating">
                        <input type="text" id="ContentPlaceHolder1_Brand" class="form-control form__input"
                            placeholder="發行公司" />
                        <label for="ContentPlaceHolder1_Brand" id="ContentPlaceHolder1_Label2">請輸入密碼</label>
                        <div class="invalid-feedback">
                            請輸入密碼
                        </div>
                    </div>

                    <div class="col-sm-12 col-md-12 form__group form-floating">
                        <input type="text" id="ContentPlaceHolder1_Brand" class="form-control form__input"
                            placeholder="發行公司" />
                        <label for="ContentPlaceHolder1_Brand" id="ContentPlaceHolder1_Label2">請輸入電子郵件</label>
                        <div class="invalid-feedback">
                            請輸入電子郵件
                        </div>
                    </div>

                    <div class="col-sm-12 col-md-12 form__group form-floating">
                        <input type="text" id="ContentPlaceHolder1_Brand" class="form-control form__input"
                            placeholder="發行公司" />
                        <label for="ContentPlaceHolder1_Brand" id="ContentPlaceHolder1_Label2">請輸入電話號碼</label>
                        <div class="invalid-feedback">
                            請輸入電話號碼
                        </div>
                    </div>

                    <div class="col-sm-12 col-md-12 form__group form-floating" style="align-items: center;">
                        <button type="button" class="btn btn-success dropdown-toggle" data-bs-toggle="dropdown"
                            aria-expanded="false">
                            職位
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">主管</a></li>
                            <li><a class="dropdown-item" href="#">全職</a></li>
                            <li><a class="dropdown-item" href="#">兼職</a></li>
                        </ul>
                    </div>

                    <div class="col-sm-12 col-md-12 form__group form-floating" style="align-items: center;">
                        <button type="button" class="btn btn-success dropdown-toggle" data-bs-toggle="dropdown"
                            aria-expanded="false">
                            血型
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">A</a></li>
                            <li><a class="dropdown-item" href="#">B</a></li>
                            <li><a class="dropdown-item" href="#">AB</a></li>
                            <li><a class="dropdown-item" href="#">O</a></li>
                        </ul>       
                    </div>
                </div>


                <div class="col-sm-12 col-md-12 form-item ">

                    <input type="date" class="form-control form-control2 form__input" id="PubDate" placeholder="到職日期">

                    <div class="invalid-feedback">
                        請輸入到職日期
                    </div>
                    <div class="valid-feedback">
                        Good!
                    </div>
                </div>
                <input type="hidden" name="ctl00$ContentPlaceHolder1$HFPubDate" id="ContentPlaceHolder1_HFPubDate" />
                <div class="col-12" style="text-align: center">
                    <input type="submit" name="ctl00$ContentPlaceHolder1$btnCreate" value="建立"
                        id="ContentPlaceHolder1_btnCreate" class="btn btn-outline-primary" style="width: 6rem; height: 2.5rem;" />
                    <a class="btn btn-outline-secondary " href="NewOrder.aspx" role="button" style="width: 6rem; height: 2.5rem;">取消</a>
                    <br />
                    <span id="spanMsg"></span>
                </div>

</asp:Content>
