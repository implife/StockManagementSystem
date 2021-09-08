<%@ Page Title="" Language="C#" MasterPageFile="~/SystemBackEnd/Main.Master" AutoEventWireup="true" CodeBehind="ApproveList.aspx.cs" Inherits="StockManagement.SystemBackEnd.Approve.ApproveList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"><title>ApproveList</title>
    <link href="../../StyleSheet/boostrap.min.css" rel="stylesheet" /> 
    <script src="../../Scripts/bootstrap.min.js"></script>
    <link href="../../StyleSheet/ApproveListStyle.css" rel="stylesheet" />
    <script src="../../Scripts/customize/jquery-3.6.0.min.js"></script>
    <script>/*Animated Arrow Stlye*/
        $(function () {
            $('.round').click(function (e) {
                e.preventDefault();
                e.stopPropagation();
                $('.arrow').toggleClass('bounceAlpha');
            });


        })
    </script>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="Switch">
        <div class="tabber">
            <label for="t1">單據審核</label>
            <input id="t1" name="food" type="radio" checked>
            <label for="t2">報廢核銷</label>
            <input id="t2" name="food" type="radio">
            <div class="blob"></div>
        </div>
    </div>
    <div style="width: 53rem;">
        <div class="accordion" id="accordionExample">

            <asp:Literal ID="ltlOrderList" runat="server" EnableViewState="false"></asp:Literal>

           <%-- <div class="accordion-item">
                <h2 class="accordion-header" id="headingTwo">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                        data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                        <table class="table" style="margin-bottom: 0%;">
                            <tbody class="ContentTbody">
                                <tr>
                                    <th scope="row">編號：52544525</th>
                                    <td>訂貨日期：2021-08-03</td>
                                    <td>點貨員：林韋傑</td>
                                    <td>負責人：陳致安</td>

                                </tr>
                            </tbody>
                        </table>
                    </button>
                </h2>
                <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo"
                    data-bs-parent="#accordionExample">
                    <div class="accordion-body">
                        <div id="OrderDetail" class="accordion-body">
                            <div class="list-group">
                                <a class="list-group-item disabled">
                                    <div class="row">
                                        <div class="col-4">
                                            <small>專輯名稱
                                            </small>
                                        </div>
                                        <div class="col-2">
                                            <small>單價
                                            </small>

                                        </div>
                                        <div class="col-2">
                                            <samll>
                                                數量
                                            </samll>
                                        </div>
                                        <div class="col-2">
                                            <samll>
                                                是由
                                            </samll>
                                        </div>
                                        <div class="col-2">
                                            <samll>
                                                備註
                                            </samll>
                                        </div>
                                    </div>
                                </a>
                                <a class="list-group-item list-group-item-action ToolTip_Item">
                                    <div class="row">
                                        <div class="col-4">
                                            Unconditional-2021Remastae
                                        </div>
                                        <div class="col-2">900</div>
                                        <div class="col-2">6</div>
                                        <div class="col-2">補貨</div>
                                        <div class="col-2">補訂</div>
                                    </div>
                                </a>
                                <a class="list-group-item list-group-item-action ToolTip_Item">
                                    <div class="row">
                                        <div class="col-4">
                                            Rubber Soul
                                        </div>
                                        <div class="col-2">730</div>
                                        <div class="col-2">5</div>
                                        <div class="col-2">補貨</div>
                                        <div class="col-2">補訂</div>
                                    </div>
                                    <div class="MyToolTip">
                                        <h5>Unconditional-2021Remastae</h5>
                                        <p>音樂家：Aimer</p>
                                        <p>發行公司： Sony Music Entertainment Japan</p>
                                        <p>發行日期：2021-09-06</p>
                                        <p>地區：Japan</p>

                                    </div>
                                </a>
                                <a class="list-group-item list-group-item-action ToolTip_Item">
                                    <div class="row">
                                        <div class="col-4">
                                            Rubber Soul
                                        </div>
                                        <div class="col-2">730</div>
                                        <div class="col-2">5</div>
                                        <div class="col-2">補貨</div>
                                        <div class="col-2">補訂</div>
                                    </div>
                                </a>
                                <a class="list-group-item list-group-item-action cdListItem">
                                    <div class="row">
                                        <div class="col-4">
                                            Rubber Soul
                                        </div>
                                        <div class="col-2">730</div>
                                        <div class="col-2">5</div>
                                        <div class="col-2">補貨</div>
                                        <div class="col-2">補訂</div>
                                    </div>
                                </a>
                                <a class="list-group-item list-group-item-action cdListItem">
                                    <div class="row">
                                        <div class="col-4">
                                            Rubber Soul
                                        </div>
                                        <div class="col-2">730</div>
                                        <div class="col-2">5</div>
                                        <div class="col-2">補貨</div>
                                        <div class="col-2">補訂</div>
                                    </div>
                                </a>
                                <a class="list-group-item list-group-item-action cdListItem">
                                    <div class="row">
                                        <div class="col-4">
                                            Rubber Soul
                                        </div>
                                        <div class="col-2">730</div>
                                        <div class="col-2">5</div>
                                        <div class="col-2">補貨</div>
                                        <div class="col-2">補訂</div>
                                    </div>
                                </a>
                                <a class="list-group-item list-group-item-action ToolTip_Item">
                                    <div class="row">
                                        <div class="col-4">
                                            Rubber Soul
                                        </div>
                                        <div class="col-2">730</div>
                                        <div class="col-2">5</div>
                                        <div class="col-2">補貨</div>
                                        <div class="col-2">補訂</div>
                                    </div>
                                    <div class="MyToolTip">
                                        <h5>Unconditional-2021Remastae</h5>
                                        <p>音樂家：Aimer</p>
                                        <p>發行公司： Sony Music Entertainment Japan</p>
                                        <p>發行日期：2021-09-06</p>
                                        <p>地區：Japan</p>
                                        <p>單價：800</p>

                                    </div>
                                </a>
                            </div>
                        </div>
                        <div class="col-12" style="text-align: center">
                            <input type="submit" value="核可" class="btn btn-outline-primary btn_Review"
                                style="width: 3rem; height: 2rem;" />
                            <input type="submit" value="修改" class="btn btn-outline-primary btn_Modify"
                                style="width: 3rem; height: 2rem;" />
                            <br />

                        </div>
                    </div>
                </div>
            </div>
            <div class="accordion-item">
                <h2 class="accordion-header" id="headingThree">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                        data-bs-target="#collapseThree" aria-expanded="false">
                        <table class="table" style="margin-bottom: 0%;">
                            <tbody class="ContentTbody">
                                <tr>
                                    <th scope="row">編號：52544525</th>
                                    <td>訂貨日期：2021-08-03</td>
                                    <td>點貨員：林韋傑</td>
                                    <td>負責人：陳致安</td>

                                </tr>
                            </tbody>
                        </table>
                    </button>
                </h2>
                <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree"
                    data-bs-parent="#accordionExample">
                    <div class="accordion-body">
                        <div id="OrderDetail" class="accordion-body">
                            <div class="list-group">
                                <a class="list-group-item disabled">
                                    <div class="row">
                                        <div class="col-4">
                                            <small>專輯名稱
                                            </small>
                                        </div>
                                        <div class="col-2">
                                            <small>單價
                                            </small>

                                        </div>
                                        <div class="col-2">
                                            <samll>
                                                數量
                                            </samll>
                                        </div>
                                        <div class="col-2">
                                            <samll>
                                                是由
                                            </samll>
                                        </div>
                                        <div class="col-2">
                                            <samll>
                                                備註
                                            </samll>
                                        </div>
                                    </div>
                                </a>
                                <a class="list-group-item list-group-item-action cdListItem">
                                    <div class="row">
                                        <div class="col-4">
                                            Unconditional-2021Remastae
                                        </div>
                                        <div class="col-2">900</div>
                                        <div class="col-2">6</div>
                                        <div class="col-2">補貨</div>
                                        <div class="col-2">補訂</div>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <div class="col-12" style="text-align: center">
                            <input type="submit" value="核可" class="btn btn-outline-primary btn_Review"
                                style="width: 3rem; height: 2rem;" />
                            <input type="submit" value="修改" class="btn btn-outline-primary btn_Modify"
                                style="width: 3rem; height: 2rem;" />
                            <br />

                        </div>
                    </div>
                </div>
            </div>
            <div class="accordion-item">
                <h2 class="accordion-header" id="headingFour"></h2>
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                    data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseTwo">
                    Accordion Item #2
                </button>

                <div id="collapseFour" class="accordion-collapse collapse" aria-labelledby="headingFour"
                    data-bs-parent="#accordionExample">
                    <div class="accordion-body">
                        <strong>This is the second item's accordion body.</strong> It is hidden by default, until
                        the collapse plugin adds the appropriate classes that we use to style each element. These
                        classes control the overall appearance, as well as the showing and hiding via CSS
                        transitions. You can modify any of this with custom CSS or overriding our default variables.
                        It's also worth noting that just about any HTML can go within the
                        <code>.accordion-body</code>, though the transition does limit overflow.
                    </div>
                </div>
            </div>
            <div class="accordion-item">
                <h2 class="accordion-header" id="headingFive">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                        data-bs-target="#collapseFive" aria-expanded="false" aria-controls="collapseFive">
                        Accordion Item #3
                    </button>
                </h2>
                <div id="collapseFive" class="accordion-collapse collapse" aria-labelledby="headingFive"
                    data-bs-parent="#accordionExample">
                    <div class="accordion-body">
                        <strong>This is the third item's accordion body.</strong> It is hidden by default, until the
                        collapse plugin adds the appropriate classes that we use to style each element. These
                        classes control the overall appearance, as well as the showing and hiding via CSS
                        transitions. You can modify any of this with custom CSS or overriding our default variables.
                        It's also worth noting that just about any HTML can go within the
                        <code>.accordion-body</code>, though the transition does limit overflow.
                    </div>
                </div>
            </div>
        </div>--%>

    </div>

    </div>

</asp:Content>
