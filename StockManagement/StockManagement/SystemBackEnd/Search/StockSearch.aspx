<%@ Page Title="" Language="C#" MasterPageFile="~/SystemBackEnd/Main.Master" AutoEventWireup="true" CodeBehind="StockSearch.aspx.cs" Inherits="StockManagement.SystemBackEnd.Search.StockSearch" %>

<%@ Register Src="~/UserControls/ucPager.ascx" TagPrefix="uc1" TagName="ucPager" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	
     <link href="../../Content/bootstrap.css" rel="stylesheet" />

    <script src="../../Scripts/bootstrap.js"></script>
    <script src="../../Scripts/bootstrap.bundle.min.js"></script>

    <script src="../../Scripts/customize/fuse.js"></script>
    <script src="../../Scripts/customize/jquery-3.6.0.min.js"></script>
    <style>
      #inp{
        width: 32% ;
      }
      #tabl{
        width:98% ;
      }

     
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div  id="inp"    class="input-group mb-3">
  <input type="text" class="form-control" placeholder="請輸入關鍵字..." aria-label="請輸入關鍵字..." aria-describedby="button-addon2">
  <button class="btn btn-outline-success" type="button" id="button-addon2">查詢</button>
</div>

                <div id="tabl" >
                    <table class="table">
                        <thead>
                          <tr class="table-light">
                            <th scope="col">#</th>
                            <th scope="col">專輯名稱</th>
                            <th scope="col">可用庫存</th>
                            <th scope="col">在途庫存</th>
                            <th scope="col">待審核庫存</th>
                            <th scope="col">歌手</th>
                            <th scope="col">發行日期</th>
                            <th scope="col">發行公司</th>
                            <th scope="col">地區</th>
                         
                          </tr>
                        </thead>
                        <tbody>
                          <tr>
                            <th scope="row">1</th>
                            <td> FIRE SCREAM/No Rain,No Rainbow</td>
                            <td>50</td>
                            <td>10</td>
                            <td>2</td>
                            <td>NANA MIZUKI</td>
                            <td>2020-10-07</td>
                            <td>KING RECORDS</td>
                            <td>Japan</td>
                         
                          </tr>
                          <tr class="table-success">
                            <th scope="row">2</th>
                            <td>Sun Dance & Penny Rain (SpecialBox(1BD+2CD))</td>
                            <td>50</td>
                            <td>10</td>
                            <td>2</td>
                            <td>Aimer</td>
                            <td>2019-04-10</td>
                            <td>Sony Music Entertainment Japan</td>
                            <td>Japan</td>
                         
                          </tr>
                          <tr>
                            <th scope="row">3</th>
                            <td> FIRE SCREAM/No Rain,No Rainbow</td>
                            <td>50</td>
                            <td>10</td>
                            <td>2</td>
                            <td>NANA MIZUKI</td>
                            <td>2020-10-07</td>
                            <td>KING RECORDS</td>
                            <td>Japan</td>
                          
                          </tr>
                          <tr class="table-success">
                            <th scope="row">4</th>
                            <td> FIRE SCREAM/No Rain,No Rainbow</td>
                            <td>50</td>
                            <td>10</td>
                            <td>2</td>
                            <td>NANA MIZUKI</td>
                            <td>2020-10-07</td>
                            <td>KING RECORDS</td>
                            <td>Japan</td>
                           
                          </tr>
                          <tr>
                            <th scope="row">5</th>
                            <td> FIRE SCREAM/No Rain,No Rainbow</td>
                            <td>50</td>
                            <td>10</td>
                            <td>2</td>
                            <td>NANA MIZUKI</td>
                            <td>2020-10-07</td>
                            <td>KING RECORDS</td>
                            <td>Japan</td>
                          
                          </tr>
                          <tr class="table-success">
                            <th scope="row">6</th>
                            <td> FIRE SCREAM/No Rain,No Rainbow</td>
                            <td>50</td>
                            <td>10</td>
                            <td>2</td>
                            <td>NANA MIZUKI</td>
                            <td>2020-10-07</td>
                            <td>KING RECORDS</td>
                            <td>Japan</td>
                           
                          </tr>
                          <tr>
                            <th scope="row">7</th>
                            <td> FIRE SCREAM/No Rain,No Rainbow</td>
                            <td>50</td>
                            <td>10</td>
                            <td>2</td>
                            <td>NANA MIZUKI</td>
                            <td>2020-10-07</td>
                            <td>KING RECORDS</td>
                            <td>Japan</td>
                          
                          </tr>
                          <tr class="table-success">
                            <th scope="row">8</th>
                            <td> FIRE SCREAM/No Rain,No Rainbow</td>
                            <td>50</td>
                            <td>10</td>
                            <td>2</td>
                            <td>NANA MIZUKI</td>
                            <td>2020-10-07</td>
                            <td>KING RECORDS</td>
                            <td>Japan</td>
                          
                          </tr>
                          <tr>
                            <th scope="row">9</th>
                            <td> FIRE SCREAM/No Rain,No Rainbow</td>
                            <td>50</td>
                            <td>10</td>
                            <td>2</td>
                            <td>NANA MIZUKI</td>
                            <td>2020-10-07</td>
                            <td>KING RECORDS</td>
                            <td>Japan</td>
                           
                          </tr>
                          <tr class="table-success">
                            <th scope="row">10</th>
                            <td> FIRE SCREAM/No Rain,No Rainbow</td>
                            <td>50</td>
                            <td>10</td>
                            <td>2</td>
                            <td>NANA MIZUKI</td>
                            <td>2020-10-07</td>
                            <td>KING RECORDS</td>
                            <td>Japan</td>
                           
                          </tr>
                        </tbody>
                      </table>
					<uc1:ucPager runat="server" ID="ucPager" Url="" />
                </div>
            </div>
</asp:Content>
